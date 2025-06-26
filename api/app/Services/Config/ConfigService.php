<?php

namespace App\Services\Config;

use App\Repositories\Eloquent\Config\{
    ConfigHotelRepository,
    ConfigCustomersRepository,
    ConfigPDVRepository
};

class ConfigService
{
    protected string $message = 'Configuração gravada com sucesso!';

    public function __construct(
        protected ConfigHotelRepository $configHotelRepository,
        protected ConfigPDVRepository $configPDVRepository,
        protected ConfigCustomersRepository $configCustomersRepository

    ) {}

    public function getConfigs(int $issuer_id)
    {
        return [
            'hotel' => $this->configHotelRepository->getConfigs($issuer_id),
            'pdv' => $this->configPDVRepository->getConfigs($issuer_id),
            'customers' => $this->configCustomersRepository->getConfigs($issuer_id)
        ];
    }

    public function updateHotel(array $data, int $id)
    {
        $config = $this->configHotelRepository->update($data, $id);
        return $config;

    }

    public function updatePDV(array $data, int $id)
    {
        $config = $this->configPDVRepository->update($data, $id);
        return $config;
    }
    
    public function updateCustomer(array $data, int $id)
    {
        $config = $this->configCustomersRepository->update($data, $id);
        return $config;
    }
}