<?php

class Carro
{
    public function __construct(
        private string $marca
    ) { }
    public function mostrarMarca()
    {
        return 'O carro é da marca: ' . $this->marca . "\n";

    }
}

$carro1 = new Carro('Toyota');
$carro2 = new Carro('Fiat');
echo $carro1->mostrarMarca();
echo $carro2->mostrarMarca();