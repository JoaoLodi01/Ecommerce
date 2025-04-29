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
        return response()->json([
            'success' => true,
            'first_steps' => $this->firstStepsRepository->getAll($id)
        ], 200);
    }
}