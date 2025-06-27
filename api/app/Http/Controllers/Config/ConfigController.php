<?php

namespace App\Http\Controllers\Config;

use Illuminate\Support\Facades\Log;

use App\Services\Config\ConfigService;
use App\Http\Controllers\Controller;
use App\Http\Requests\Config\ConfigColor;
use App\Http\Requests\Customers\Config\ConfigCustomerRequest;
use App\Http\Requests\HotelRequest\Config\ConfigHotelRequest;
use App\Http\Requests\PDV\Config\ConfigPDVRequest;
class ConfigController extends Controller
{
    public function __construct(
        protected ConfigService $configService
    )
    {
        Log::info('Memória usada ConfigController::class, __construct: ' . memory_get_usage(true));
    }

    public function getConfigs(string $issuer_id)
    {
        $configs = $this->configService->getConfigs($issuer_id);
        return apiSuccess('Sucesso!', $configs);
        
    }

    public function updateHotel(ConfigHotelRequest $request, int $issuer_id)
    {
        $config = $this->configService->updateHotel($request->all(), $issuer_id);
        return apiSuccess('Configurações do Hotel alteradas com sucesso', $config);
 
    }

    public function updatePDV(ConfigPDVRequest $request, int $issuer_id)
    {
        $config = $this->configService->updatePDV($request->validated(), $issuer_id);
        return apiSuccess('Configurações do PDV alteradas com sucesso', $config);
        
    }

    public function updateCustomer(ConfigCustomerRequest $request, int $issuer_id)
    {
        Log::info($request->all());
        $config = $this->configService->updateCustomer($request->validated(), $issuer_id);
        
        return apiSuccess('Configurações do PDV alteradas com sucesso', $config);
        
    }

    public function updateColor(ConfigColor $request, int $issuer_id)
    {
        $config = $this->configService->updateColor($request->validated(), $issuer_id);
        return apiSuccess('Cor alteradas com sucesso!', $config);

    }
}
