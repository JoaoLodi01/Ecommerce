<?php

$ch = curl_init();

curl_setopt_array($ch, [
    CURLOPT_URL => "https://open.cnpja.com/office/17089484000190",
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_TIMEOUT => 10,
    CURLOPT_SSL_VERIFYPEER => false
]);

$response = curl_exec($ch);
curl_close($ch);

if(curl_errno($ch))
{
    echo "Erro: " . curl_error($ch);
} else {
    fopen('response.txt', 'a');
    
}
