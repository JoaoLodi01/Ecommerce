<?php

namespace App\Services\Config;

use App\Repositories\Eloquent\Config\{
    ConfigHotelRepository,
    ConfigCustomersRepository,
    ConfigPDVRepository,
    ConfigColorRepository,
    ConfigProductsRepostiry
};
use Exception;
use Illuminate\Support\Facades\Log;

class ConfigService
{
    protected string $message = 'Configuração gravada com sucesso!';

    public function __construct(
        protected ConfigHotelRepository $configHotelRepository,
        protected ConfigPDVRepository $configPDVRepository,
        protected ConfigCustomersRepository $configCustomersRepository,
        protected ConfigColorRepository $configColorRepository,
        protected ConfigProductsRepostiry $configProductsRepostiry

    ) {}

    public function getConfigs(int $issuer_id)
    {
        return [
            'hotel' => $this->configHotelRepository->getConfigs($issuer_id),
            'pdv' => $this->configPDVRepository->getConfigs($issuer_id),
            'customers' => $this->configCustomersRepository->getConfigs($issuer_id),
            'color' => $this->configColorRepository->getConfigs($issuer_id),
            'products' => $this->configProductsRepostiry->getConfigs($issuer_id)
            
        ];
    }

    public function updateHotel(array $data, int $issuer_id)
    {
        $config = $this->configHotelRepository->update($data, $issuer_id);
        return $config;

    }

    public function updatePDV(array $data, int $id)
    {
        $config = $this->configPDVRepository->update($data, $id);
        return $config;
    }

    public function updatePDVLogo(object $file, int $id)
    {
        Log::debug('Vai armanzenar a logo');
        $destiny = "images/{$id}";
        $fileName = $file->getClientOriginalName();

        $path = $file->storeAs($destiny, $fileName, 'public');

        // Gera caminho web acessível
        $url = "/storage/{$path}";

        // Salva no banco
        $this->configPDVRepository->updatePDVLogo($url, $id);

        return $url;
    }
    
    public function downloadLogo(int $id)
    {
        $url = $this->configPDVRepository->downloadLogo($id);

        return $url;
    }
    
    public function updateCustomer(array $data, int $issuer_id)
    {
        $config = $this->configCustomersRepository->update($data, $issuer_id);
        return $config;
    }

    // Colors
    public function updateColor(array $data, int $issuer_id)
    {
        $config = $this->configColorRepository->update($data, $issuer_id);
        return $config;

    }

    public function exportColors(int $issuerID)
    {
        $configs = $this->configColorRepository->exportColors($issuerID);

        if(!$configs)
        {
            throw new Exception('Erro ao exportar cores');
        }
        
        return $configs;

    }
    //
}