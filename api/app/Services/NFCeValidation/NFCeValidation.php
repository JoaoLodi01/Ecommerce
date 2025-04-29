<?php

namespace App\Services\NFCeValidation;

use App\Repositories\Eloquent\EcommerceEloquent\ErrorsPDVRepository;
use Illuminate\Support\Facades\Log;

class NFCeValidation
{
    public function __construct(
        protected FindTributs $findTributs,
        protected ErrorsPDVRepository $errorsPDVRepository
    ){}

    public function validation(array $products)
    {
        Log::info("-- Iniciou o NFCeValidation() --");
        Log::info('Produtos NFCeValidation');
        Log::info($products);

        $errors = [];
        $productCFOP = $products['cfop'];
        $productCSON = $products['csosn'];
        
        $cfops = $this->findTributs->getCFOPs();
        $csosncsts = $this->findTributs->getCSOSNCST($productCSON);        

        $cfopValidate = array_key_exists($productCFOP, $cfops);
        
        $csosnValidate = array_key_exists($productCSON, $csosncsts);

        if(!$cfopValidate)
        {
            $errors['produtoErroCFOP'] = "Produto: {$products['product']} com CFOP incorreto: {$products['cfop']}[{$products['product_id']}]";

        }
        
        if(!$csosnValidate)
        {
            $errors['produtoErroCSOSN'] = "Produto: {$products['product']} com CSOSN/CST incorreto: {$products['csosn']}[{$products['product_id']}]";
            
        }

        if(count($errors) >= 1)
        {
            Log::info('Vai criar registro de erro');
            $this->errorsPDVRepository->create($errors, $products['pdv_id']);
        }

        Log::info('Quantia de errors: ' . count($errors));
        return array(
            'cfopValidate' => $cfopValidate,
            'csosnValidate' => $csosnValidate,
            'errors' => $errors

        );
    }
}

