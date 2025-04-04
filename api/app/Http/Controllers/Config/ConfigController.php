<?php

namespace App\Http\Controllers\Config;

use App\Http\Controllers\Controller;
use App\Services\Config\ConfigService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class ConfigController extends Controller
{
    public function __construct(
        protected ConfigService $configService
    )
    {
        Log::info('Memória usada ConfigController::class, __construct: ' . memory_get_usage(true));
    }

    public function getConfigs()
    {
        return $this->configService->getConfigs();
    }

    public function updateHotel(Request $request)
    {
        $data = $request->all();

        return $this->configService->updateHotel($data);
 
    }

    public function updatePDV(Request $request)
    {
        $data = $request->all();
        return $this->configService->updatePDV($data);
    }
}
