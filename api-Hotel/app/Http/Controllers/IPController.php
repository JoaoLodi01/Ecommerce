<?php

namespace App\Http\Controllers;

use App\Services\IPService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class IPController
{
    public function __construct(
        protected IPService $ipService
    )
    {
        $this->ipService = $ipService;
    }

    public function create(Request $request)
    {
        Log::info('Chamou o IPController');
        
        //return ip2long('192.168.98.51');
        return $this->ipService->create($request->ip());

    }
    
}