<?php

namespace App\Services\EcommerceService;

use App\Repositories\Eloquent\UserRepository;

class UserService
{
    public function __construct(
        protected UserRepository $userRepository
    )
    {}

    public function getAll(int $issuer_id){
        try {
            return response()->json([
                'success' => true,
                'all' => $this->userRepository->getAll($issuer_id)
            ]); 
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

    public function create(array $data){
        try {
            $user = $this->userRepository->create($data);
            return response()->json([
                'success' => true,
                'user' => $user
                 
            ], 201);
            
        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function update(array $data, int $id){
        $this->userRepository->update($data, $id);
        return response()->json([
            'sucess' => true,
            'message' => 'Usuário alterado com sucesso!'
        ], 200);
    }

    public function delete(int $id){
        $this->userRepository->delete($id);
        return response()->json([
            'success' => true,
            'message' => 'Usuário desativado com sucesso!'
        ], 200);

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