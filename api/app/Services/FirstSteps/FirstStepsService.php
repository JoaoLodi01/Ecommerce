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
        $data = $this->firstStepsRepository->getAll($id);
        return $data;
        
    }

    public function ignoreFirstSteps(int $id)
    {
        $ignore = $this->firstStepsRepository->ignoreFirstSteps($id);
        return response()->json([
            'success' => true,
            'ignore' => $ignore
        ], 200);
    }
}