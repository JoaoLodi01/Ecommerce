<?php

namespace App\Service;

class IPService
{
    public function __construct(
        
        
    ){
        

    }

    public function create(array $data)
    {
        try {
            return response()->json([
                'success' => true,
                'message' => 'IP gravado com sucesso'

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