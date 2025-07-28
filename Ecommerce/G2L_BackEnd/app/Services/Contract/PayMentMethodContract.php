<?php

namespace App\Services\Contract;

interface PayMentMethodContract
{
    public function payment(
        array $forms, // Formas de pagamento
        array $paymentValues, // Valores pagos
        object $customer, // Cliente da nota
        string $description, // Tipo de venda
        string $origem, // Origem
        object $pdv, // Corpo do PDV
        int $issuerID, // ID do emitente,
        object $user // Usuário que fez a venda
                
    );

    public function decreaseCash(
        object $customer, // Cliente da nota
        float $value, // Valor total
        string $description, // Tipo de venda
        string $origem, // Origem
        string|int $issuerID // ID do emitente
    );
}