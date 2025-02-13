<?php

namespace App\Services;

use App\Repositories\Eloquent\IPRepository;
use Illuminate\Support\Facades\Log;

class IPService
{
    public function __construct(
        protected IPRepository $ipRepository
    ){
        $this->ipRepository = $ipRepository;
    }

    public function create(string $ip = '')
    {
        Log::info("Chamou o IPService");
        try {
            $ip = $this->ipRepository->create($ip);
            return response()->json([
                'success' => true,
                'ip' => $ip

            ]);

        } catch (\Throwable $th) {
            return response()->json([
                'success' => false,
                'message' => $th->getMessage(),
                'line' => $th->getLine()

            ]);
        }
    }

}