<?php

namespace App\Services;

use App\Repositories\Eloquent\ConfigRepository as ConfigHotelRepository;

class ConfigService
{
    public function __construct(
        protected ConfigHotelRepository $configHotelRepository
    )
    {
        $this->configHotelRepository = $configHotelRepository;
        
    }
    public function update(array $data)
    {
        try {
            $config = $this->configHotelRepository->update($data);
            return response()->json([
                'success' => true,
                'message' => 'Configuração gravadas com sucesso!',
                'config' => $config

            ], 201);
        } catch (\Throwable $th) {
            return response()->json([
                'success' => false,
                'message' => 'Um erro ocorreu durante a gravação das configurações',
                'th' => $th->getMessage()
            ]);
        }

    }
}