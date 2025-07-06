<?php

namespace App\Services\FirstSteps;

use App\Repositories\Eloquent\FirstStepEloquent\FirstStepsRepository;

class FirstStepsService
{
    public function __construct(
        protected FirstStepsRepository $firstStepsRepository
    ) {}

    public function getAll(int $id)
    {
        return $this->firstStepsRepository->getAll($id);
        
    }

    public function ignoreFirstSteps(int $id)
    {
        return $this->firstStepsRepository->ignoreFirstSteps($id);
    
    }
}