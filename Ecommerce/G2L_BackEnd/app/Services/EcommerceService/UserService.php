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
        $all = $this->userRepository->getAll($issuer_id);

        if(!$all)
        {
            apiError('Erro', $all);
        }
        return $all;
    }

    public function findById(int $id){
        try {
            return response()->json([
                'success' => true,
                'user' => $this->userRepository->findById($id)
            ]);
        } catch (\Throwable $th) {
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
        }
    }

    public function update(array $data, int $id){
        $user = $this->userRepository->update($data, $id);
        return $user;
    }

    public function delete(int $id){
        $this->userRepository->delete($id);
        return response()->json([
            'success' => true,
            'message' => 'Usuário desativado com sucesso!'
        ], 200);

    }
}