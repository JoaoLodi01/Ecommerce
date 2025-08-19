<?php

namespace App\Http\Controllers\Config;

use App\Http\Controllers\Controller;
use App\Services\Config\ConfigEmailService;
use Illuminate\Http\Request;

class ConfigEmailController extends Controller
{
    public function __construct(
        protected ConfigEmailService $configEmailService
    ){}

    public function getAll(int $issuerID)
    {
        return apiSuccess('Todos os e-mails', $this->configEmailService->getAll($issuerID));
    }

    public function create(Request $data)
    {
        return apiSuccess('E-mail adicionado com sucesso!', $this->configEmailService->create($data->input('mail'), $data->input('issuerID')));

    }
    
    public function delete(Request $data)
    {
        return apiSuccess('E-mail deletado com sucesso!', $this->configEmailService->delete($data->input('mailCode'), $data->input('issuerID')));

    }
}
