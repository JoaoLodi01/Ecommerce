<?php

use Illuminate\Support\Facades\Log;

function apiSuccess($message = 'Sucesso!', $data = [], $success = true, $status = 200)
{
    return response()->json([
        'success' => $success,
        'message' => $message,
        'data' => $data,
        'status' => $status
        
    ], $status);
};

function apiError($message, $data = [], $success = false, $status = 400)
{
    Log::info('Chamou o apiError');
    return response()->json([
        'success' => $success,
        'message' => $message,
        'data' => $data,
        'status' => $status
        

    ], $status);

}