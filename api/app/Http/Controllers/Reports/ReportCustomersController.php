<?php

namespace App\Http\Controllers\Reports;

use App\Http\Controllers\Controller;
use App\Services\CustomerService;
use App\Services\ReportsService\ReportCustomerService;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;
use PhpOffice\PhpSpreadsheet\Spreadsheet;

class ReportCustomersController extends Controller
{
    public function __construct(
        protected CustomerService $customerService,
        protected Spreadsheet $spreadsheet,
        protected ReportCustomerService $reportCustomerService
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
        $path = public_path('/xlsx/ativos');
        $fileName = "clientes_ativos.xlsx";
        $filePath = "$path/$fileName";
        $writer->save($filePath);

        return response()->download($filePath);

    }

    public function exportAllDisabledClients()
    {
        $sheet = $this->spreadsheet->getActiveSheet();
        $sheet->setCellValue('A1', 'Cliente');
        $sheet->setCellValue('B1', 'CNPJ');
        $sheet->setCellValue('C1', 'CPF');
        $sheet->setCellValue('D1', 'E-mail');
        $sheet->setCellValue('E1', 'Status');

        $customersData = $this->reportCustomerService->exportAllDisabledClients();
        foreach ($customersData as $i => $value) {
            $row = $i + 2;
            
            $sheet->getCell("A$row")->setValue($customersData[$i]['name']);
            $sheet->getCell("B$row")->setValue($customersData[$i]['cnpj']);
            $sheet->getCell("C$row")->setValue($customersData[$i]['cpf']);
            $sheet->getCell("D$row")->setValue($customersData[$i]['email']);
            $sheet->getCell("E$row")->setValue('Inativo');

        }

        $writer = new Xlsx($this->spreadsheet);
        $path = public_path('/xlsx/inativos');
        if(!is_dir($path))
        {
            mkdir($path, 0775, true);
        }
        $fileName = "clientes_inativos.xlsx";
        $filePath = "$path/$fileName";
        $writer->save($filePath);

        return response()->download($filePath);

    }
}