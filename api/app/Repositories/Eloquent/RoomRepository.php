<?php
namespace App\Repositories\Eloquent;

use App\Models\{
    Customer,
    DetailRooms,
    HotelDetail,
    Room,
    Capacity
};

use App\Repositories\Interface\RoomContract;
use Illuminate\Support\Facades\Log;

class RoomRepository implements RoomContract
{
    public function all(int $active)
    {
        Log::info("Vai buscar todos os quartos do hotel table = Rooms");
        return Room::all();

    }

    public function create(array $data)
    {
        $customer = Customer::where('id', $data['customer_id'])->first();
        $detailRoom = DetailRooms::where('id', $data['room_id'])->first();
        
        $hotel = HotelDetail::where('id', $detailRoom->hotel_id)->first();
        
        if($customer && $detailRoom && $hotel)
        {
            $room = Room::create([
                'customer_id' => $customer->id,
                'customer' => $customer->name,
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
        //$detailRooms = DetailRooms::where('id', $data['room_id'])->first();
        $detailRooms = $this->find($data['room_id']);
        
        Log::info('Dados de entrada:' . $data['room_id']);
        Log::info("Quarto encontrado: \n$rooms");

        if($customer)
        {
            Log::info("Vai zerar os clientes");
            $customer->update([
                'active' => 0

            ]);

            $detailRooms->update([
                'capacity' => $capacity->capacity - 1

            ]);
            
            $detailRooms->save();
            Log::info("Vai colocar a capacidade do quarto - 1");
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

    public function countActive(object $room, int $room_id)
    {
        Log::info("Chamou o countActive");
        return $room->where('active', 1)
                    ->where('room_id', $room_id)
                    ->count('active');
        
    }

    public function findByCustomerID(string $id)
    {
        Log::info("Vai procurar o quarto pelo cliente e se está ativo");
        return Room::where('customer_id', $id)
                        ->where('active', 1)
                        ->first();

    }

    public function findByRoomID(string $id)
    {
        Log::info("Vai procurar o quarto pelo número dele");
        return Room::where('room_id', $id)
                        ->get();

    }

    public function find(string $param)
    {
        return DetailRooms::where('id', $param)->first();

    }

    public function update(array $data, int $id)
    {
        return DetailRooms::where('id', $id)->update($data);

    }

    public function delete(int $id)
    {
        return DetailRooms::where('id', $id)->update([
            'active' => 0
        ]);
        // Desativa o quarto
    }
}