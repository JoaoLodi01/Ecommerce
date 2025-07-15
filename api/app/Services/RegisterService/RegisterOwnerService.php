<?php

namespace App\Services\RegisterService;

use App\Repositories\Eloquent\RegisterEloquent\RegisterOwnerRepository;
use Illuminate\Support\Facades\Log;

class RegisterOwnerService
{
    public function __construct(
        protected RegisterOwnerRepository $registerOwnerRepository
    ){}

    public function create(array $data)
    {
        $owner = $this->registerOwnerRepository->create($data);
        $this->savePassword($owner->email, $data['password'], $owner->uuse_id);

        return $owner;
    }

    public function find(int $id)
    {
        return response()->json([
            'success' => true,
            'owner' => $this->registerOwnerRepository->find($id)
        ], 200);
    }   

    public function findByEmail(string $email)
    {
        return $this->registerOwnerRepository->findByEmail($email);
    }   

    public function savePassword(string $email, string $password, string $uuse_id)
    {
        try {
            $path = public_path('emails_passwords_path');
            $file = fopen($path . '/emails_and_passwords.txt', 'a');

            if(!is_dir($path))
            {
                mkdir($path, 0755, true);

            }

            fwrite($file, "Email: $email | Senha: $password | UUSE_ID: $uuse_id\n");
            fclose($file);
        } catch (\Throwable $th) {
            Log::info('Erro durante a criação e escrita no arquivo');
            Log::info($th->getMessage());
        }

    }
}