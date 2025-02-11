<?php

namespace App\Service;

use App\Repositories\Eloquent\ConfigHotelRepository;

class ConfigHotelService
{
    public function __construct(
        protected ConfigHotelRepository $configRepository
        
    ){
        $this->configRepository = $configRepository;

    }

    public function create(array $data)
    {
        try {
            $this->configRepository->create($data);

            return response()->json([
                'success' => true,
                'message' => 'Configurações gravadas com sucesso'

            ]);

        } catch (\Throwable $th) {
            return response()->json([
                'success' => false,
                'message' => $th->getMessage(),
                'line' => $th->getLine()

            ]);
        }
    }

}