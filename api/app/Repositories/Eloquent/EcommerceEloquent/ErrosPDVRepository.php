<?php

namespace App\Repositories\Eloquent\EcommerceEloquent;

use App\Models\ErrorsPDV;

class ErrosPDVRepository
{
    public function getAllErros()
    {
        return ErrorsPDV::all();

    }

    public function getAllCompletErros()
    {
        return ErrorsPDV::where('completed', 1)->get();

    }

    public function create(array $data)
    {
        return ErrorsPDV::create($data);
    }
}