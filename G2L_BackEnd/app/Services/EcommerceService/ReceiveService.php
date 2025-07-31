<?php

namespace App\Services\EcommerceService;

use App\Repositories\Eloquent\ReceiveRepository;
use Exception;

class ReceiveService
{
    public function __construct(
        protected ReceiveRepository $receiveRepository
    ){}

    public function getOne(int $document){
        $one = $this->receiveRepository->getOne($document);
        if(!$one)
        {
            throw new \App\Exceptions\EcommerceExceptions\ReceiveException("Erro ao buscar as primeiras parcelas do receber");

        }

        return $one;
    }

    public function getAll(int $issuer_id){
        $all = $this->receiveRepository->getAll($issuer_id);
        if(!$all)
        {
            throw new \App\Exceptions\EcommerceExceptions\ReceiveException("Erro ao buscar todas as parcelas do receber");

        }

        return $all;
    }

    public function findByID(int $id){
        return response()->json([
            'success' => true,
            'receive' => $this->receiveRepository->findByID($id)
        ]);
    }

    public function create(array $data){
        $receive = $this->receiveRepository->create($data);

        return response()->json([
            'Dados' => $receive,
            'success' => true,
        ]);
    }

    public function update(array $data, int $id){
        $this->receiveRepository->update($data, $id);
        return response()->json([
            'success' => true,
        ]);
    }

    public function updateInstallment(array $data, int $id){
        $installment = $this->receiveRepository->updateInstallment($id);

        if (!$installment) {
            throw new \Exception("Parcela não encontrada");
        }

        $installment->update($data);

        return $installment;
    }

    public function delete(int $id){
        $this->receiveRepository->delete($id);
        return response()->json([
            'success' => true,
        ]);
    }
}
