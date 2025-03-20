<?php

namespace App\Services\EcommerceService;

use App\Repositories\Eloquent\UserRepository;

class UserService
{
    protected $userRepository;

    public function __construct(UserRepository $userRepository){
        $this->userRepository = $userRepository;
    }

    public function getAll(){}

    public function findById(){}

    public function store(){}

    public function update(){}

    public function delete(){}

    public function returnResponse($th){
        return response()->json([
            'success' => false,
            'th' => $th->getMessage(),
            'line' => $th->getLine(),
            'file' => $th->getFile(),
        ]);
    }
}