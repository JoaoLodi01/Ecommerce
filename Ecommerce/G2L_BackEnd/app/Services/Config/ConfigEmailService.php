<?php

namespace App\Services\Config;

use App\Repositories\Eloquent\Config\ConfigAditionalEmailRepository;

use Exception;
use Illuminate\Support\Facades\Log;

class ConfigEmailService
{
    protected string $message = 'Configuração gravada com sucesso!';

    public function __construct(
        protected ConfigAditionalEmailRepository $configAditionalEmailRepository

    ) {}
    
    public function getAll(int $issuerID)
    {
        $mails = $this->configAditionalEmailRepository->getAll($issuerID);
        if (!$mails)
        {
            throw new Exception("Erro ao buscar todos os e-mails");
        }

        return $mails;
    }

    public function create(string $mail, int $issuerID)
    {
        $mail = $this->configAditionalEmailRepository->create($mail, $issuerID);        
        return $mail;
    }
    
    public function delete(int $mailCode, int $issuerID)
    {
        $mail = $this->configAditionalEmailRepository->delete($mailCode, $issuerID);        
        return $mail;
    }
}