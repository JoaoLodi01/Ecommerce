<?php

namespace App\Http\Controllers\FirstSteps;

use App\Http\Controllers\Controller;
use App\Services\FirstSteps\FirstStepsService;
use Illuminate\Http\Request;

class FirstStepsController extends Controller
{
    public function __construct(
        protected FirstStepsService $firstStepsService
    ) {}

    public function getAll(int $id)
    {
        return $this->firstStepsService->getAll($id);
    }
}
