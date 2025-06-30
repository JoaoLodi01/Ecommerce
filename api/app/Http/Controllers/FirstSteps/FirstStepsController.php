<?php

namespace App\Http\Controllers\FirstSteps;

use App\Http\Controllers\Controller;
use App\Services\FirstSteps\FirstStepsService;
class FirstStepsController extends Controller
{
    public function __construct(
        protected FirstStepsService $firstStepsService
    ) {}

    public function getAll(int $id)
    {
        $firstSteps = $this->firstStepsService->getAll($id);
        return apiSuccess('Primeiros passos', $firstSteps);
    }

    public function ignoreFirstSteps(int $id)
    {
        return $this->firstStepsService->ignoreFirstSteps($id);
    }
}
