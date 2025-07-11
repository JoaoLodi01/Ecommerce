<?php

namespace App\Traits;

use Illuminate\Support\Facades\Log;

class LogPayMentRepository
{
    public function logInfo(string $messasge, array $context = [])
    {
        Log::channel('payment')->info($messasge, $context);

    }
    
    public function logDebug(array $context = [])
    {
        //Log::channel('payment')->debug($context);
        
    }
}