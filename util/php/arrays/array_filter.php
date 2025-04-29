<?php

$payMentsValues = array (
    0 => 0, // dinheiro
    1 => 100, // pix
    2 => 0, // cartão 1
    3 => 20, // cartão 2
);

$total = 0;
$forms = [];

$filltred = array_filter($payMentsValues);
foreach ($filltred as $key => $value) {
    $total += (float) $value;
    $forms[] = $key;
}

echo "Total: R$ $total, formas => ";
print_r($forms); 