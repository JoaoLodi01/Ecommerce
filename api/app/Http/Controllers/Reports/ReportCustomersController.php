<?php

namespace App\Http\Controllers\Reports;

use App\Http\Controllers\Controller;
use App\Services\CustomerService;
use App\Services\ReportsService\ReportCustomerService;
use Illuminate\Support\Facades\Log;
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

    public function exportAllClients(int $issuer_id)
    {
        $sheet = $this->spreadsheet->getActiveSheet();
        $sheet->setCellValue('A1', 'Cliente');
        $sheet->setCellValue('B1', 'CNPJ');
        $sheet->setCellValue('C1', 'CPF');
        $sheet->setCellValue('D1', 'Status');

        $customersData = $this->customerService->getAll($issuer_id);
        $customersArray = $customersData->toArray();
        
        foreach ($customersArray as $i => $value) {
            $row = $i + 2;

            $sheet->getCell("A$row")->setValue($value['company_name'] ?? '');
            $sheet->getCell("B$row")->setValue($value['cnpj'] ?? '');
            $sheet->getCell("C$row")->setValue($value['cpf'] ?? '');
            $sheet->getCell("D$row")->setValue($value['active'] ? 'Ativo' : 'Inativo');

        }
        
        $writer = new Xlsx($this->spreadsheet);
        $path = public_path('/xlsx/ativos');
        $fileName = "clientes_ativos.xlsx";
        $filePath = "$path/$fileName";
        $writer->save($filePath);
        
        return response()->download($filePath, $fileName, [
            'Content-Type' => 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',

        ]);

    }

    public function exportAllDisabledClients()
    {
        $sheet = $this->spreadsheet->getActiveSheet();
        $sheet->setCellValue('A1', 'Cliente');
        $sheet->setCellValue('B1', 'CNPJ');
        $sheet->setCellValue('C1', 'CPF');
        $sheet->setCellValue('D1', 'Status');

        $customersData = $this->reportCustomerService->exportAllDisabledClients();
        foreach ($customersData as $i => $value) {
            $row = $i + 2;

            Log::info($value['cnpj']);
            
            $sheet->getCell("A$row")->setValue($value['company_name']);
            $sheet->getCell("B$row")->setValue($value['cnpj']);
            $sheet->getCell("C$row")->setValue($value['cpf']);            
            $sheet->getCell("D$row")->setValue('Inativo');

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

        return response()->download($filePath, [
            'Content-Type' => 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',

        ]);

    }
}