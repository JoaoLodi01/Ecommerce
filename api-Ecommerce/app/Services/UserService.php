<?php

namespace App\Services;

use App\Repositories\Eloquent\UserRepository;

class UserService{
    
    protected $userRepository;

    public function __construct(UserRepository $userRepository)
    {
        $this->userRepository = $userRepository;
    }
    
    public function getAll(){
        try {
            return $this->userRepository->getAll(1);
        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function findByID(int $id){
        try {
            return response()->json([
                'success' => true,
                'product' => $this->userRepository->findByID($id)
            ]);

        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function store(array $data){
        try {
            $this->userRepository->store($data);
            return response()->json(true);

        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function update(array $data, int $id){
        try {
            $this->userRepository->update($data, $id);
            return response()->json(true);

        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function delete(int $id){
        try {
            $this->userRepository->delete($id);
            return response()->json(true);
            
        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function returnResponse($th){
        return response()->json([
            'success' => false,
            'th' => $th->getMessage(),
            'line' => $th->getLine(),
            'file' => $th->getFile(),
        ]);
    }
}