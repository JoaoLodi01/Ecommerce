<?php

namespace App\Services\Config;

use App\Repositories\Eloquent\Config\{
    ConfigHotelRepository,
    ConfigPDVRepository
};

class ConfigService
{
    protected string $message = 'Configuração gravada com sucesso!';

    public function __construct(
        protected ConfigHotelRepository $configHotelRepository,
        protected ConfigPDVRepository $configPDVRepository,

    )   
    {}

    public function getConfigs()
    {
        return response()->json([
            'success' => true,
            'configHotel' => $this->configHotelRepository->getConfigs(),
            'configPDV' => $this->configPDVRepository->getConfigs()

        ], 200);
    }

    public function updateHotel(array $data)
    {
        $config = $this->configHotelRepository->update($data);
        return response()->json([
            'success' => true,
            'message' => $this->message,
            'config' => $config

        ], 200);

    }

    public function updatePDV(array $data)
    {
        $config = $this->configPDVRepository->update($data);
        return response()->json([
            'success' => true,
            'message' => $this->message,
            'config' => $config

        ]);
    }
}