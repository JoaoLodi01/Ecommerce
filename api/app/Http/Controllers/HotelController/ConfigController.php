<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Services\ConfigService as ConfigHotelService;
use Illuminate\Support\Facades\Request;

class ConfigController extends Controller
{
    public function __construct(
        protected ConfigHotelService $configService
    )
    {
        $this->configService = $configService;

    }

    public function update(Request $request)
    {
        return $this->configService->update($data);

    }
}
