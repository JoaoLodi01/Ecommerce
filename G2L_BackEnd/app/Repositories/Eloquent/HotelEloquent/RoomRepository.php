<?php

namespace App\Repositories\Eloquent\HotelEloquent;

use App\Models\HotelModels\{
    DetailRooms,
    HotelDetail,
    Room,
    Capacity,
    Reservation
};

use App\Repositories\Eloquent\EcommerceEloquent\{
    PaymentsRepository,
    CashRegisterRepository
    
};

use App\Models\{
    Customer,
    CustomerCredit
    
};

use App\Repositories\Contracts\HotelContract\RoomContract;
use App\Services\PayMentMethodService;
use Illuminate\Support\Facades\Log;
use Carbon\Carbon;
class RoomRepository implements RoomContract
{
    public function __construct(
        protected PaymentsRepository $paymentsRepository,
        protected CashRegisterRepository $cashRegisterRepository,
        protected HotelRepository $hotelRepository,
        protected PayMentMethodService $payMentMethodService

    ){
        Log::info('Memória usada RoomRepository::class, __construct: ' . memory_get_usage(true));

    }
    
    public function allRooms(int $active)
    {
        Log::info("Vai buscar todos os quartos ativos do hotel table = DetailRooms");
        return DetailRooms::where('active', $active)->paginate(10);

    }
    
    public function all(int $active)
    {
        Log::info("Vai buscar todos os quartos ativos do hotel table = Rooms");
        return Room::where('active', $active)->get();

    }

    public function create(array $data)
    {
        $customer = $this->findCustomer($data['uesr_id']);
        $detailRoom = DetailRooms::where('id', $data['room_id'])->first();
        
        $hotel = HotelDetail::where('id', $detailRoom->hotel_id)->first();
        
        if($customer && $detailRoom && $hotel)
        {
            $room = Room::create([
                'customer_id' => $customer->id,
                'customer' => $customer->company_name,
                'room_id' => $detailRoom->id,
                'number_room' => $detailRoom->number_room,
                'start_period' => $data['start_period'],
                'end_period' => $data['end_period'],
                
            ]);

            $hotel->update([
                'total_busy_rooms' => $detailRoom->sum('busy')
                
            ]);
            
            $hotel->save();

            $detailRoom->update([
                'busy' => 1,
                'capacity' => $detailRoom->capacity - 1

            ]);

            $detailRoom->save();

            return $room;

        } else if (!$customer){
            return "Cliente não encontrado";

        } else if (!$detailRoom){
            return "Quarto não encontrado";

        } else if (!$hotel){
            return "Hotel não encontrado";
            
        }
    
        return false;
    }

    public function checkIn(array $data)
    {  
        $capacity = Capacity::where('id', $data['room_id'])->first(); // Pega a quantia anterior
        $rooms = $this->findByRoomID($data['room_id']);
        $customer = $this->findByCustomerID($data['customer_id']);
        Log::info("Cliente encontrado $customer");
        
        $detailRooms = $this->find($data['room_id']);
        
        Log::info('Dados de entrada:' . $data['room_id']);
        Log::info("Quarto encontrado: \n$rooms");

        if($customer)
        {
            Log::info("Vai zerar os clientes");
            $customer->update([
                'active' => 0

            ]);

            Log::info("Retornou a quantia - 1");
            $detailRooms->update([
                'capacity' => $capacity->capacity - 1

            ]);
            
            $detailRooms->save();
            Log::info($detailRooms);

            $customer->save();

        }

        Log::info("Vai calcular o count->active");
        foreach ($rooms as $room) {
            $count = $this->countActive($room, $data['room_id']);

            if($count <= 0)
            {
                Log::info("Vai retornar o quarto como vago, quarto: $detailRooms");
                $detailRooms->update([
                    'busy' => 0,
                    'capacity' => $capacity->capacity

                ]);
                
                Log::info("Quarto pós update");
                Log::info($room);
            }
        }
        
        return $room;
    }

    public function reservation(array $forms, array $payment, float $total, int $roomID, bool $generateCredit)
    {
        // $payment = array do pagemento todo
        Log::info('Vai procurar o quarto');
        $room = $this->find($roomID);
        
        Log::info('Vai procurar o cliente');
        $customer = $this->findCustomer(1);
        
        Log::info('Vai procurar a(s) formas de pagamento');
        $formsPayment = $this->paymentsRepository->findByID($forms); // formsPayment - apenas as espécies
        
        Log::info('Vai buscar o hotel');
        $hotel = $this->hotelRepository->find(1);
        
        if(
            $total > $room->price_for_night 
            && $customer 
            && $formsPayment
            && $hotel
        )
        {
            Log::info("Valor informado: R$ $total, maior que o valor do quarto: $room->price_for_night");
            
            $room->update([
                'reserved' => 1
        
            ]);
            
            // Se der completamente errado, retornar para >= 2
            Log::info('-- Começo do registro no caixa, RoomRepository.php, linha 191 --');
            $this->payMentMethodService->payment($formsPayment, $payment, $customer, 'Reserva hotel', 'hotel', $room);
            Log::info('-- Fim do registro no caixa, RoomRepository.php, linha 193 --');

            if($generateCredit === true)
            {
                $this->createCredit($customer, (float) $total - $room->price_for_night, $room);

            }
            
            return array(
                'success' => true,
                'message' => 'Reserva concluida'
            
            );
        }
        
        if(
            $total === $room->price_for_night 
            && $customer 
            && $formsPayment
            && $hotel
        )
        {
            Log::info('Quarto encontrado' . $room);
            $room->update([
                'reserved' => 1
        
            ]);
    
            Log::info('-- Começo do registro no caixa, RoomRepository.php, linha 221 --');
            $this->payMentMethodService->payment($formsPayment, $payment, $customer, 'Reserva hotel', 'hotel', $room);
            Log::info('-- Fim do registro no caixa, RoomRepository.php, linha 223 --');
            
            return array(
                'success' => true,
                'message' => 'Reserva concluida',
                'bigger' => false
            
            );
        }

        return array(
            'success' => false,
            'errorMessage' => 'O valor pago é menor que o valor do quarto',
            'amountPaid' => $total,
            'remaining' => $room->price_for_night - $total,
            
        );
    }

    public function createCredit(object $customer, float $credit, object $room) 
    {
        Log::info('-- Inicio createCredit linha 244 --');
        Log::info('Memória usada RoomRepository::class, createCredit: ' . memory_get_usage(true));
        Log::info('Vai criar o crédito do cliente, R$: ' . $credit);
        $customerCredit = CustomerCredit::create([
            'customer_id' => $customer->id,
            'name' => $customer->company_name,
            'current_credit' => $credit,
            'validate' => Carbon::now()->addDays(30)->format('Y-m-d')

        ]);
        $this->payMentMethodService->decreaseCash($customer, $customerCredit->current_credit, 'Geração de crédito', 'hotel', $room->id);
        Log::info('-- Fim createCredit linha 255 --');   
    }

    public function countActive(object $room, int $roomID)
    {
        Log::info('Memória usada RoomRepository::class, countActive: ' . memory_get_usage(true));
        Log::info("Chamou o countActive");
        return $room->where('active', 1)
                    ->where('room_id', $roomID)
                    ->count('active');
        
    }

    public function findByCustomerID(string $id)
    {
        Log::info('Memória usada RoomRepository::class, findByCustomerID: ' . memory_get_usage(true));
        Log::info("Vai procurar o quarto pelo cliente e se está ativo");
        $room = Room::where('customer_id', $id)->first();
        Log::info('room ' .  $room);
        return $room;

    }

    public function findByRoomID(string $id)
    {
        Log::info("Vai procurar o quarto pelo número dele");
        return Room::where('room_id', $id)->first();

    }

    public function find(string $param)
    {
        return DetailRooms::where('id', $param)->first();

    }

    public function findCustomer(int $id)
    {
        return Customer::where('id', $id)           
                            ->first();
    }

    public function update(array $data, int $id)
    {
        return DetailRooms::where('id', $id)->update($data);
    }

    public function delete(int $id)
    {
        return DetailRooms::where('id', $id)->update([
            'active' => 0
        ]); // Desativa o quarto
    }

    public function checkReservation(int $customerID)
    {
        Log::info('Memória usada RoomRepository::class, checkReservation: ' . memory_get_usage(true));
        return Reservation::where('customer_id', $customerID)->first();

    }
}