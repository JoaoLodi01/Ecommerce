<?php

$data = [
    array(
        'cash_register_code' => 1,
        'issuer_id' => 1,
        'description' => 'nm',
        'document' => NULL,
        'pdv_code' => 7,
        'receive_cod' => NULL,
        'receive_document' => NULL,
        'customer_code' => 1,
        'name' => 'Consumidor Padrão',
        'especie_cod' => 1,
        'especie' => NULL,
        'date_register' => '2025-07-18',
        'input_value' => 10,
        'output_value' => 0,
        'origem' => 'pdv',
        'user_id' => 1,
        'seller' => 'Vendedor',
    ),
    array(
        'cash_register_code' => 1,
        'issuer_id' => 1,
        'description' => 'nm',
        'document' => NULL,
        'pdv_code' => 7,
        'receive_cod' => NULL,
        'receive_document' => NULL,
        'customer_code' => 1,
        'name' => 'Consumidor Padrão',
        'especie_cod' => 2,
        'especie' => NULL,
        'date_register' => '2025-07-18',
        'input_value' => 10,
        'output_value' => 0,
        'origem' => 'pdv',
        'user_id' => 1,
        'seller' => 'Vendedor',
    )
];

for($i = 0; $i < count($data); $i++)
{
    $element = $data[$i]['especie_cod'] . "\n";
    print_r($element);
}