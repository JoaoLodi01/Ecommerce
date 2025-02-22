<?php

namespace App\Repositories\Eloquent\EcommerceEloquent;

use Illuminate\Support\Facades\Log;
use App\Models\EcommerceModels\Customer;

class ConsumerRepository 
{
    public function getAll(int $active){ 
        return Customer::where('active', $active)->get();
    }

    public function findByID(string $params){
        return Customer::where('id', $params)->first();
    }

    public function store(array $data){

        Log::info("Se tiver nome, cnpj ou cpf vai criar.");
        if (!empty($data['name']) || !empty($data['cnpj']) || !empty($data['cpf'])){

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
        } else {
            Log::info("Dados insuficientes");
            return response()->json([
                'error' => 'Campos obrigatórios não preenchidos'
            ], 400);
        }
    }

    public function update(array $data, int $id){

        Log::info("Caiu no update");
        $customerId = Customer::where('id', $id)->update($data);

        if ($customerId){
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
        Log::info("Caiu no delete");
        return Customer::where('id', $id)->update([
            'active' => 0,
        ]);
    }
}