<?php

namespace App\Repositories\Eloquent\FirstStepEloquent;

use App\Models\FirstSteps;
use App\Repositories\Contracts\FirstStepsContract\FirstStepsContract;

class FirstStepsRepository implements FirstStepsContract
{
    public function getAll(int $id)
    {
        return FirstSteps::where('issuer_id', $id)->first();

    }
}