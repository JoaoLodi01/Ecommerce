<?php

namespace App\Repositories\Eloquent\EcommerceEloquent;

use App\Models\EcommerceModels\PaymentForms;
use App\Models\Registers\Issuer;
use Illuminate\Support\Facades\Log;

class PaymentsRepository
{
    public function getAll(int $issuer_id){
        Log::info("Iniciou getAll PaymentsRepository");
        Log::info("Buscando por emitente");
        $issuer = Issuer::where('id', $issuer_id)->first();

        Log::info('Resultado: '. $issuer);
        if(empty($issuer)){
            return [
                'success' => false,
                'message' => 'Emitente não encontrado',
            ];
        }

        return PaymentForms::where('issuer_id', $issuer_id)->get();
        Log::info('Resultado: '. $issuer_id);
    }

    public function findByID(array $data){
        Log::info("Buscando a espécie pelo ID.");
        Log::info($data);
        
        $result = [];
        foreach ($data as $id) {
            $result[] = PaymentForms::where('id', $id)->first();
            
        }
        Log::info('$result');
        Log::info($result);
        return $result;
    }

    public function store(array $data){
        
        Log::info("Se o campo especie NÃO estiver vazio vai criar");
        if (!empty($data['especie'])){
            
            Log::info("Criando espécie");
            $payment = PaymentForms::create([
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
        $paymentID = PaymentForms::where('id', $id)->update($data);

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
        return PaymentForms::where('id', $id)->update([
            'active' => 0,
        ]);
    }

}