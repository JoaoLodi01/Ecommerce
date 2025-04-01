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
        protected Spreadsheet $spreadsheet
    )
    {
        $this->spreadsheet = new Spreadsheet();
        
    }

    public function exportAllClients()
    {
        $sheet = $this->spreadsheet->getActiveSheet();
        $sheet->setCellValue('A1', 'Cliente');
        $sheet->setCellValue('B1', 'CNPJ');
        $sheet->setCellValue('C1', 'CPF');
        $sheet->setCellValue('D1', 'E-mail');
        $sheet->setCellValue('E1', 'Status');

        $customersData = $this->customerService->getAll();
        $customersArray = $customersData->toArray()['data'];

        foreach ($customersArray as $i => $value) {
            $row = $i + 2;

            $sheet->getCell("A$row")->setValue($customersArray[$i]['name']);
            $sheet->getCell("B$row")->setValue($customersArray[$i]['cnpj']);
            $sheet->getCell("C$row")->setValue($customersArray[$i]['cpf']);
            $sheet->getCell("D$row")->setValue($customersArray[$i]['email']);
            $sheet->getCell("E$row")->setValue($customersArray[$i]['active'] ? 'Ativo' : 'Inativo');

        }
        
        $writer = new Xlsx($this->spreadsheet);
        $fileName = 'clientes.xlsx';
        $writer->save($fileName);

        return response()->download(public_path($fileName));

    }

    public function exportAllDisabledClients()
    {
        
    }
}