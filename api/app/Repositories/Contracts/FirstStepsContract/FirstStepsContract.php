<?php

namespace App\Repositories\Contracts\FirstStepsContract;

interface FirstStepsContract
{
    public function getAll(int $id);
    public function ignoreFirstSteps(int $id);
}