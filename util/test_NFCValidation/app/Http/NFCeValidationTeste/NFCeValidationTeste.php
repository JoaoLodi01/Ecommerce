<?php

//namespace App\Http\NFCeValidationTeste;

class NFCeValidationTeste
{
    public function __construct(
        protected FindTributs $findTributs
    )
    {}

    public function validation(array $products)
    {
        $productCFOP = $products['cfop'];
        $cfops = $this->findTributs->getCFOPs();
        $csosncsts = $this->findTributs->getCSOSNCST($products['csosncst']);

        array_key_exists($products['csosncst'], $csosncsts) === true ? true : false;

        array_key_exists($productCFOP, $cfops) === true ? true : false;
        
    }
}

