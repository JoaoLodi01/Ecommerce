<?php

namespace App\Http\Controllers\RegisterControllers;

use App\Http\Controllers\Controller;
use App\Http\Requests\Register\RegisterIssuerRequest;
use App\Services\RegisterService\RegisterIssuerService;
use Illuminate\Http\Request;

class RegisterIssuerController extends Controller
{
    public function __construct(
        protected RegisterIssuerService $registerIssuerService
    ){}

    public function getAll(string $ownerID)
    {
        return $this->registerIssuerService->getAll($ownerID);
    }

    public function create(RegisterIssuerRequest $request)
    {
        $data = $request->validated();
        return $this->registerIssuerService->create($data);
    }

    public function find(int $id)
    {
        return $this->registerIssuerService->find($id);
    }

    public function completeRegister(Request $request, int $id)
    {
        $data = $request->all();
        return $this->registerIssuerService->update($data, $id);
    }
}