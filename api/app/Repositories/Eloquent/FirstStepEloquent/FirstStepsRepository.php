<?php

namespace App\Repositories\Eloquent\FirstStepEloquent;

use App\Models\Registers\FirstSteps;
use App\Repositories\Contracts\FirstStepsContract\FirstStepsContract;
use Illuminate\Support\Facades\Log;

class FirstStepsRepository implements FirstStepsContract
{
    public function getAll(int $id)
    {
        return FirstSteps::where('issuer_id', $id)->first();

    }

    public function ignoreFirstSteps(int $id)
    {
        return FirstSteps::where('issuer_id', $id)->update([
            'ignore_first_steps' => 1
        ]);
    }
}