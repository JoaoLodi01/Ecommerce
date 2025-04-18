<?php

namespace App\Http\NFCeValidation;

use Illuminate\Support\Facades\Log;

class NFCeValidation
{
    public function __construct(
        protected FindTributs $findTributs
    ){}

    public function validation(array $products)
    {
        Log::info("-- Iniciou o NFCeValidation() --");
        Log::info('Produtos NFCeValidation');
        Log::info($products);

        $productCFOP = $products['cfop'];
        $productCSON = $products['csosn'];
        
        $cfops = $this->findTributs->getCFOPs();
        $csosncsts = $this->findTributs->getCSOSNCST($productCSON);

        $erros = [];

        $cfopValidate = array_key_exists($productCFOP, $cfops);
        
        $csosnValidate = array_key_exists($productCSON, $csosncsts);

        if(!$cfopValidate)
        {
            $erros['produtoErroCFOP'] = "Produto: {$products['product']} com CFOP incorreto: {$products['cfop']}";

        }
        
        if(!$csosnValidate)
        {
            $erros['produtoErroCSOSN'] = "Produto: {$products['product']} com CSOSN/CST incorreto: {$products['csosn']}";
            
        }

        Log::info('$cfopValidate no NFCeValidation');
        Log::info($cfopValidate);

        Log::info('$csosnValidate no NFCeValidation');
        Log::info($csosnValidate);

        return array(
            'cfopValidate' => $cfopValidate,
            'csosnValidate' => $csosnValidate,
            'errors' => $erros
        );
    }
}

