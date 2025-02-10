<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Http\Requests\ConfigHotelRequest;
use App\Service\ConfigHotelService;

class ConfigHotelController extends Controller
{
    public function __construct(
        protected ConfigHotelService $configService
    )
    {
        $this->configService = $configService;

    }

    public function create(ConfigHotelRequest $request)
    {
        $data = $request->validated();
        return $this->configService->create($data);

    }
}
