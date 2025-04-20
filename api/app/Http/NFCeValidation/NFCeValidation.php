<?php

namespace App\Http\NFCeValidation;

use App\Repositories\Eloquent\EcommerceEloquent\ErrosPDVRepository;
use Illuminate\Support\Facades\Log;

class NFCeValidation
{
    public function __construct(
        protected FindTributs $findTributs,
        protected ErrosPDVRepository $errosPDVRepository
    ){}

    public function validation(array $products)
    {
        Log::info("-- Iniciou o NFCeValidation() --");
        Log::info('Produtos NFCeValidation');
        Log::info($products);

        $erros = [];
        $productCFOP = $products['cfop'];
        $productCSON = $products['csosn'];
        
        $cfops = $this->findTributs->getCFOPs();
        $csosncsts = $this->findTributs->getCSOSNCST($productCSON);        

        $cfopValidate = array_key_exists($productCFOP, $cfops);
        
        $csosnValidate = array_key_exists($productCSON, $csosncsts);

        if(!$cfopValidate)
        {
            $erros['produtoErroCFOP'] = "Produto: {$products['product']} com CFOP incorreto: {$products['cfop']}|ID:[{$products['product_id']}]";

        }
        
        if(!$csosnValidate)
        {
            $erros['produtoErroCSOSN'] = "Produto: {$products['product']} com CSOSN/CST incorreto: {$products['csosn']}|ID:[{$products['product_id']}]";
            
        }

        Log::info('Quantia de erros: ' . count($erros));
        return array(
            'cfopValidate' => $cfopValidate,
            'csosnValidate' => $csosnValidate,
            'errors' => $erros

        );
    }
}

