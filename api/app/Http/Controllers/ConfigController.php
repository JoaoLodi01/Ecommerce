<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Services\ConfigService as ConfigHotelService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class ConfigController extends Controller
{
    public function __construct(
        protected ConfigHotelService $configService
    )
    {
        Log::info('Memória usada ConfigController::class, __construct: ' . memory_get_usage(true));
    }

    public function getConfigs()
    {
        return $this->configService->getConfigs();
    }

    public function update(Request $request)
    {
        $data = $request->all();

        return $this->configService->update($data);
 
    }
}
