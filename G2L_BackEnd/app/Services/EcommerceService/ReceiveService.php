<?php

namespace App\Services\EcommerceService;

use App\Repositories\Eloquent\ReceiveRepository;
use Exception;

class ReceiveService
{
    public function __construct(
        protected ReceiveRepository $receiveRepository
    ){}

    public function getOne(string $document){
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

    public function payInstallment(array $data, int $id){
        $installment = $this->receiveRepository->findByID($id);

        if (!$installment) {
            throw new \Exception("Parcela não encontrada");
        }

        if ($installment->status === 'cancelada'){
            throw new \Exception("Não é possível quitar uma parcela cancelada");
        }

        if ($installment->status === 'quitada') {
            throw new \Exception("Parcela já está quitada");
        }

        return $this->receiveRepository->payInstallment($data, $id);
    }

    public function UndoInstallment(array $data, int $id){
        $installment = $this->receiveRepository->findByID($id);

        if (!$installment) {
            throw new \Exception("Parcela não encontrada");
        }

        if ($installment->status !== 'quitada') {
            throw new \Exception("A parcela não está quitada");
        }

        return $this->receiveRepository->undoInstallment($data, $id);
    }

    public function delete(int $id){
        $this->receiveRepository->delete($id);
        return response()->json([
            'success' => true,
        ]);
    }
}
