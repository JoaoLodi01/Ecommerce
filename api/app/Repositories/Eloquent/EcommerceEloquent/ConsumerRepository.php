<?php

namespace App\Repositories\Eloquent\EcommerceEloquent;

use Illuminate\Support\Facades\Log;
use App\Models\Customer;

class ConsumerRepository 
{
    public function getAll(int $active){
        Log::info("Buscando todos os clientes");
        return Customer::where('active', $active)->get();
    }

    public function findByID(string $params){
        Log::info("Buscando cliente por ID.");
        return Customer::where('id', $params)->first();
    }

    public function store(array $data){

        Log::info("Se tiver nome, cnpj ou cpf vai criar.");
        if (!empty($data['name']) && !empty($data['cnpj']) || !empty($data['cpf'])){

            Log::info("Criando cliente");
            $customer = Customer::create([
                'name' => $data['name'],
                'cnpj' => $data['cnpj'],
                'cpf' => $data['cpf'],
                'cep' => $data['cep'],
                'address' => $data['address'],
                'number' => $data['number'],
                'email' => $data['email'],
                'phone' => $data['phone'],
                'active' => 1,
            ]);

            return response()->json([
                'success' => true,
                'message' => 'Cliente criado com sucesso!',
            ], 201);
        } else {
            Log::info("Dados insuficientes");
            return response()->json([
                'error' => 'Campos obrigatórios não preenchidos'
            ], 400);
        }
    }

    public function update(array $data, int $id){

        Log::info("Buscando cliente por ID");
        $customerID = Customer::where('id', $id)->update($data);

        if ($customerID){
            Log::info("Cliente atualizado com sucesso!");
            return response()->json([
                'success' => true,
                'message' => 'Cliente atualizado com sucesso!',
            ], 200);
        } else {
            Log::info("Cliente não encontrado.");
            return response()->json([
                'success' => false,
                'error' => 'Cliente não encontrado.',
            ], 404);
        }
    }

    public function delete(int $id){
        Log::info("Iniciando exclusão do cliente");
        $customerID = Customer::find($id);

        if (!$customerID) {
            Log::info("Cliente não encontrado.");
            return response()->json([
                'success' => false,
                'error' => 'Cliente não encontrado.',
            ], 404);
        }

        $customerID->update(['active' => 0]);

        Log::info("Cliente desativado com sucesso!");
        return response()->json([
            'success' => true,
            'message' => 'Cliente deletado com sucesso!',
        ], 200);
    }
}