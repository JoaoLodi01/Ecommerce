<?php

namespace App\Repositories\Eloquent\EcommerceEloquent;

use App\Models\EcommerceModels\Payment;
use Illuminate\Support\Facades\Log;

class PaymentsRepository
{
    public function getAll(int $active){
        Log::info("Buscando todas as espécies na table: payments");
        return Payment::where('active', $active)->get();
    }

    public function findByID(array $data){
        Log::info("Buscando a espécie pelo ID.");
        $result = [];
        foreach ($data as $i) {
            $result[] = Payment::where('id', $i)->first();
            
        }
        Log::info('$result');
        Log::info($result);
        return $result;
    }

    public function store(array $data){
        
        Log::info("Se o campo especie NÃO estiver vazio vai criar");
        if (!empty($data['especie'])){
            
            Log::info("Criando espécie");
            $payment = Payment::create([
                'especie' => $data['especie'],
                'tipo_lancamento' => $data['tipo_lancamento'],
                'active' => 1,
            ], 201);
        } else {
            return response()->json([
                'success' => false,
                'error' => 'Preencha o nome da espécie.',
            ], 400);
        }

    }

    public function update(array $data, int $id){

        Log::info("Buscando espécie pelo ID");
        $paymentID = Payment::where('id', $id)->update($data);

        if ($paymentID){
            Log::info("Espécie atualizada com sucesso!");
            return response()->json([
                'success' => true,
                'message' => 'Espécie atualizada com sucesso!',
            ], 200);
       } else {
            return response()->json([
                'success' => false,
                'error' => 'Espécie não encontrada',
            ], 404);
       }
    }

    public function delete(int $id){
        Log::info("Função delete");
        return Payment::where('id', $id)->update([
            'active' => 0,
        ]);
    }

}