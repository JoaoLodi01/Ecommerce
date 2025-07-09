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

        if(!$issuer){
            return [
                'success' => false,
                'message' => 'Emitente não encontrado',
            ];
        }

        Log::info('Cod. emitente: '. $issuer_id);
        Log::info("Buscando espécies");
        $species = PaymentForms::where('issuer_id', $issuer_id)->get();
        Log::info("Terminou");

        return $species;
    }

    public function findByID(array $data){
        Log::info("Buscando a espécie pelo ID.");
        Log::info($data);
        
        $result = [];
        foreach ($data as $id => $value) {
            $result[] = PaymentForms::where('payment_cod', $id + 1)->first();
            
        }

        return $result;
    }

    public function findKey(int $issuer_id)
    {
        $paymentForm = PaymentForms::where('issuer_id', $issuer_id)
                                    ->where('payments_form_type', 'PIX')
                                    ->where('pix_key', '<>', '')
                                    ->first();
        Log::info('paymentForm ' . $paymentForm);
        if($paymentForm)
        {
            return array(
                'success' => true,
                'key' => $paymentForm->pix_key
            );
        } elseif (!$paymentForm->pix_key){
            return array(
                'success' => false,
                'message' => 'Chave PIX ausente'
            );
        }

    }

    public function create(array $data){
        if (!empty($data)){
            Log::info("Criando espécie");
            $paymentCod = PaymentForms::where('issuer_id', $data['issuer_id'])->max('payment_cod');
            $payment = PaymentForms::create([
                'payment_cod' => $paymentCod ? $paymentCod + 1 : 1,
                'issuer_id' => $data['issuer_id'],
                'especie' => $data['especie'],
                'tipo_lancamento' => $data['tipo_lancamento'],
                'payments_form_type' => $data['payments_form_type'],
                'pix_key' => preg_replace('/[^a-zA-Z0-9]/', '', $data['pix_key']) ?? null,
                'bank_key' => preg_replace('/[^a-zA-Z0-9]/', '', $data['bank_key']) ?? null,
                'other_key' => preg_replace('/[^a-zA-Z0-9]/', '', $data['other_key']) ?? null,
            ]);
            if($payment)
            {
                return array(
                    'status' => 201,
                    'success' => true
                );
            }

        } else {
            return response()->json([
                'success' => false,
                'error' => 'Campos necessários.',
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