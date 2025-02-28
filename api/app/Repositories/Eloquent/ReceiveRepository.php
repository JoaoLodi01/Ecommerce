<?php

namespace App\Repositories\Eloquent;

use App\Models\{
    CashRegister,
    Receive
};
use Illuminate\Support\Facades\Log;

class ReceiveRepository
{
    public function create(array $cashRegister)
    {
        Log::info('Vai iniciar criação no RECEBER, dados: ');
        Log::info('Quantia: '. count($cashRegister));
        Log::info($cashRegister);
        if(count($cashRegister) >= 2)
        {
            for ($i=0; $i < count($cashRegister); $i++) { 
                Receive::create($cashRegister[$i]);
                
            }
            
        }

        if(count($cashRegister) === 1)
        {
            Log::info();
            Receive::create($cashRegister[0]);
        }
        return;
    }

    public function cashReceive()
    {
        Log::info();
    }
}