<?php

namespace App\Services\EcommerceService;

use App\Repositories\Eloquent\UserRepository;

class UserService
{
    protected $userRepository;

    public function __construct(UserRepository $userRepository){
        $this->userRepository = $userRepository;
    }

    public function getAll(){
        try {
            return $this->userRepository->getAll(1);
        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function selectSeller(array $search){
        try {
            return $this->userRepository->selectSeller($search);
        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function findById(int $id){
        try {
            return response()->json([
                'success' => true,
                'winner' => $this->userRepository->findById($id)
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
            $this->userRepository->update($array, $id);
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
            return $this.returnResponse($th);
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