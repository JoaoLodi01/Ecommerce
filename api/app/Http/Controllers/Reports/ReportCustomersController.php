<?php

namespace App\Http\Controllers\Reports;

use App\Http\Controllers\Controller;
use App\Services\CustomerService;

use PhpOffice\PhpSpreadsheet\Writer\Xlsx;
use PhpOffice\PhpSpreadsheet\Spreadsheet;

use Illuminate\Support\Facades\Log;

class ReportCustomersController extends Controller
{
    public function __construct(
        protected CustomerService $customerService,
        public $spreadsheet,
        public $sheet
    )
    {
        $spreadsheet = new Spreadsheet();
        $sheet = $this->spreadsheet->getActiveSheet();
    }

    public function exportAllClients()
    {
        $this->sheet->setCellValue('A1', 'Cliente');
        $this->sheet->setCellValue('B1', 'CNPJ');
        $this->sheet->setCellValue('C1', 'CPF');
        $this->sheet->setCellValue('D1', 'E-mail');

        $customersData = $this->customerService->getAll();
        $customersArray = $customersData->toArray()['data'];

        for ($i=0; $i < count($customersArray); $i++) { 
            Log::info($customersArray[$i]['name']);
            Log::info('$sheet->getCell(A$i)->setValue($customersArray[$i][name])');
            
            $this->sheet->getCell('A' . $i + 2)->setValue($customersArray[$i]['name']);
            $this->sheet->getCell('B' . $i + 2)->setValue($customersArray[$i]['cnpj']);
            $this->sheet->getCell('C' . $i + 2)->setValue($customersArray[$i]['cpf']);
            $this->sheet->getCell('D' . $i + 2)->setValue($customersArray[$i]['email']);

        }
        
        $writer = new Xlsx($this->spreadsheet);
        $fileName = 'clientes.xlsx';

        $writer->save(public_path($fileName));
        return response()->download(public_path($fileName));

    }

    public function exportAllDisabledClients()
    {

    }
}