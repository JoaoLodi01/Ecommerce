<?php

namespace App\Repositories\Eloquent;

use App\Models\{
    DetailRooms,
    HotelDetail,
    Capacity
};

use App\Repositories\Interface\HotelDetailContract;
use Illuminate\Support\Facades\Log;

class HotelRepository implements HotelDetailContract
{
    public function all(int $active)
    {
        $hotel = HotelDetail::where('active', $active)->first();
        
        if(!empty($hotel) && $hotel->cep)
        {
            Log::info('Chamou o checkAddress com, hotel: ' . $hotel);
            return $this->checkAddress($hotel);
        } else if (empty($hotel)) {
            Log::info("Hotel não encontrado");

            return array(
                'success' => false,
                'message' => 'Hotel não encontrado'
                
            );
            
        } else if (!$hotel->cep) {
            Log::info("CEP do Hotel não encontrado ou não informado");

            return array(
                'success' => false,
                'message' => 'CEP do Hotel não encontrado ou não informado'
                
            );
        }
    }

    public function checkAddress(object $hotel)
    {
        Log::info('Vai iniciar a consulta do CEP');
        $ch = curl_init();

        curl_setopt_array($ch, [
            CURLOPT_URL => "https://viacep.com.br/ws/$hotel->cep/json/",
            CURLOPT_RETURNTRANSFER => true, 
            CURLOPT_TIMEOUT => 10,
            CURLOPT_SSL_VERIFYPEER => false

        ]);

        $data = curl_exec($ch);

        if(curl_errno($ch))
        {
            Log::info('Erro ao fazer a consulta: ' . curl_error($ch));
            return "Erro CURL: \n" . curl_error($ch) . " rota: https://viacep.com.br/ws/$hotel->cep/json/";

        }

        $response = json_decode($data, true);
        curl_close($ch);

        Log::info('Terminou e encerrou a consulta, vai comparar o endereço do CEP');
        Log::info('Endereço ' . $response['logradouro'] . "rota: https://viacep.com.br/ws/$hotel->cep/json/");

        if($hotel->address != $response['logradouro'])
        {
            Log::info('Vai fazer a alteração');            
            $hotel->update([
                'address' => $response['logradouro']
            ]);

            $hotel->save();

            return array(
                'success' => true,
                'hotel' => $hotel,
                'a' => 1
            
            );

            Log::info('Fim do bloco, linha 62');
        }

        return array(
            'success' => true,
            'hotel' => $hotel
        
        );
        Log::info('Não vai alterar o endereço');
        Log::info('Fim do bloco, linha 66');
    }

    public function create(array $data)
    {
        $hotel = HotelDetail::create($data);
        
        for ($number = 1; $number <= $hotel->number_of_rooms; $number++)
        {
            $detailRoom = DetailRooms::create([
                'capacity' => rand(2, 5),
                'price_for_night' => rand(20, 45),
                'number_room' => $number,
                'hotel_id' => $hotel->id,
                
            ]);

            Capacity::create([
                'room_id' => $detailRoom->id,
                'capacity' => $detailRoom->capacity
            ]);
            
        }

        return $hotel;        
    }

    public function update(array $data, int $id)
    {
        return HotelDetail::where('id', $id)->update($data);

    }
    
    public function find(string $param)
    {
        return HotelDetail::where('id', $param)
                            ->orWhere('cnpj', $param)
                            ->orWhere('name', 'like', '%' . $param . '%' )
                            ->get();
        
    }

    public function delete(int $id) // fechar a empresa na prática kkkk
    {
        return HotelDetail::where('id', $id)->update([
            'active' => 0
            
        ]);
        
    }
}