<?php

namespace App\Services\EcommerceService;

use App\Repositories\Eloquent\EcommerceEloquent\PaymentsRepository;
use Exception;

class PaymentsService
{
    public function __construct(
        protected PaymentsRepository $paymentsRepository
    ) {}

    public function getAll(int $issuerID){
        $paymentsRepository = $this->paymentsRepository->getAll($issuerID);

        if(!$paymentsRepository)
        {
            throw new Exception('Erro ao buscar as espécies!');
        }
        
        return $paymentsRepository;

    }

    public function findOneByID(int $issuerID, int $code)
    {
        $specie = $this->paymentsRepository->findOneByID($issuerID, $code);
            
        if(!$specie)
        {
            throw new Exception("Erro ao buscar espécie", 1);
            
        }

        return $specie;
    }

    public function findKey(int $issuer_id)
    {
        $key = $this->paymentsRepository->findKey($issuer_id);
        if($key['success'])
        {
            return response()->json([
                'success' => $key['success'],
                'key' => $key['key']
                
            ]);

        } else {
            return response()->json([
                'success' => false,
                'message' => 'Graxa',
                'key' => $key
                
            ]);
        }
    }

    public function create(array $data){
        $paymentForm = $this->paymentsRepository->create($data);
        if(!$paymentForm)
        {
            throw new Exception("Erro ao criar nova espécie de pagamento");

        }

        return $paymentForm;
    }

    public function update(array $data, int $id)
    {
        
    }

    public function delete(int $id)
    {
        
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