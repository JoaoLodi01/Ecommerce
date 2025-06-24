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

    ) {}

    public function getConfigs(int $issuer_id)
    {
        return [
            'hotel' => $this->configHotelRepository->getConfigs(),
            'pdv' => $this->configPDVRepository->getConfigs($issuer_id)

        ];
    }

    public function updateHotel(array $data)
    {
        $config = $this->configHotelRepository->update($data);
        return $config;

    }

    public function updatePDV(array $data)
    {
        $config = $this->configPDVRepository->update($data);
        return $config;
    }
}