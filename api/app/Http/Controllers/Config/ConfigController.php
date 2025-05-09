<?php

namespace App\Http\Controllers\Config;

use App\Http\Controllers\Controller;
use App\Services\Config\ConfigService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

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

    public function getConfigs(string|int $issuer_id)
    {
        Log::info('ConfigController: $issuer_id ' . $issuer_id);
        $id = (int) $issuer_id;
        return $this->configService->getConfigs($id);
    }

    public function updateHotel(ConfigHotelRequest $request)
    {
        $data = $request->all();
        return $this->configService->updateHotel($data);
 
    }

    public function updatePDV(ConfigPDVRequest $request)
    {
        $data = $request->validated();
        Log::info('$data');
        Log::info($data);
        return $this->configService->updatePDV($data);
    }
}
