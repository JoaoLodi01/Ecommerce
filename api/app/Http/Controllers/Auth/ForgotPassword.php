<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Log;

class ForgotPassword extends Controller
{
    public function send()
    {
        Log::info('ForgotPassword::class, send');
        return response()->json([
            'message' => 'Enviando e-mail...'
        ], 200);
    }

}