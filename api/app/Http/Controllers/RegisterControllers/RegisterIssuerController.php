<?php

namespace App\Http\Controllers\RegisterControllers;

use App\Http\Controllers\Controller;
use App\Http\Requests\Register\RegisterIssuerRequest;
use App\Services\RegisterService\RegisterIssuerService;

class RegisterIssuerController extends Controller
{
    public function __construct(
        protected RegisterIssuerService $registerIssuerService
    ){}

    public function create(RegisterIssuerRequest $request)
    {
        $data = $request->validated();
        return $this->registerIssuerService->create($data);
    }

    public function find(int $id)
    {
        return $this->registerIssuerService->find($id);
    }
}