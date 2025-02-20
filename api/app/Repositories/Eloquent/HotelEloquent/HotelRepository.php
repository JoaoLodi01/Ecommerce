<?php

namespace App\Repositories\Eloquent\HotelEloquent;

use App\Models\HotelModels\{
    DetailRooms,
    HotelDetail,
    Capacity
};

use App\Models\Config as ConfigHotel;
use App\Repositories\Contracts\HotelContract\HotelDetailContract;
use Illuminate\Support\Facades\Log;

class HotelRepository implements HotelDetailContract
{
    public function all(int $active)
    {
        Log::info("Vai buscar o hotel e as configurações");
        $hotel = HotelDetail::where('active', $active)->first();
        $config = ConfigHotel::where('active', $active)->first();

        if(!empty($hotel))
        {  
            Log::info("O hotel foi encontrado");
            Log::info("Vai conferir as configurações ( se houver ) de CEP");
            
            if($config)
            {
                if($config->address_by_cep === 1){
                    Log::info('Opção ativa vai alterar o endereço');
                    Log::info('Chamou o checkAddress com, hotel: ' . $hotel);
                    $this->checkStatusCNPJ($hotel->cnpj);
                    return $this->checkAddress($hotel);

                }

            } 
            
            Log::info("Opção desativada, não vai alterar o endereço");
            return array(
                'success' => true,
                'hotel' => $hotel,
                
            );
        } else {
            Log::info("O hotel não foi encontrado");
        
            return array(
                'success' => false,
                'message' => 'Hotel não encontrado'

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

    public function checkStatusCNPJ(string $cnpj)
    {
        Log::info("Vai checar o status do CNPJ $cnpj");
        $ch = curl_init();

        curl_setopt_array($ch, [
            CURLOPT_URL => env("CNPJA/$cnpj"),
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_TIMEOUT => 10
        ]);

        $data = curl_exec($ch);
        if(curl_errno($ch))
        {
            return "Erro CURL: " . curl_error($ch) . ' rota: ' . env("CNPJA");

        }
        $response = json_decode($data, true);
        curl_close($ch);

        return $response;
        
    }

    public function create(array $data)
    {
        $hotel = HotelDetail::create($data);
    
        Log::info("Vai começar a criar os quartos");
        for ($n = 1; $n <= $hotel->number_of_rooms; $n++)
        {
            $detailRoom = DetailRooms::create([
                'capacity' => rand(2, 5),
                'price_for_night' => rand(20, 45),
                'number_room' => $n,
                'hotel_id' => $hotel->id,
                
            ]);

            Log::info("Quartos: $detailRoom");

            Capacity::create([
                'room_id' => $detailRoom->id,
                'capacity' => $detailRoom->capacity
            ]);
            
        }
        Log::info("Vai criar as configs");
        ConfigHotel::create();

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
        $hotel = HotelDetail::where('id', $id)->update([
            'active' => 0,
            
        ]);

        $hotel->update([
            'cnpj' => '---',
            'end_date' => $hotel->update_at
        ]);

        $hotel->save();

        $rooms = DetailRooms::where('hotel_id', $hotel->id)->update([
            'active' => 0
            
        ]);

        $rooms->save();

        return $hotel;
        
    }

}