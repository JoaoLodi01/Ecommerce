<?php

namespace App\Repositories\Eloquent;

use App\Models\EcommerceModels\Receive;
use Illuminate\Support\Facades\Log;

class ReceiveRepository
{
    public function getAll(){
        Log::info('Memória utilizada ReceiveRepository::class, getAll: ' . memory_get_usage(true));
        return Receive::paginate(20);
    }

    public function create(array $cashRegister)
    {
        Log::info('Memória usada ReceiveRepository::class, create: ' . memory_get_usage(true));
        if ($cashRegister) {
            Log::info('Vai iniciar criação no RECEBER, dados: ');
            Log::info('Quantia: '. count($cashRegister));
            Log::info($cashRegister);
            Receive::create($cashRegister);
            return;
        }
        
    }
}