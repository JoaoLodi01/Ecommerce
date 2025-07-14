<?php

namespace App\Http\Controllers\Reports\PDV;

use App\Http\Requests\Report\PDVReport\ReportCashClosingPeriodRequest;
use App\Services\ReportsService\PDVReportService\ReportCashClosingPeriodService;
use Illuminate\Support\Facades\Log;

use PhpOffice\PhpSpreadsheet\Writer\Xlsx;
use PhpOffice\PhpSpreadsheet\Spreadsheet;


class ReportCashClosingPeriodController
{
    public function __construct(
        protected ReportCashClosingPeriodService $reportCashClosingPeriodService,
        protected Spreadsheet $spreadsheet,
    ){
        $this->spreadsheet = new Spreadsheet();
    }

    public function getData(ReportCashClosingPeriodRequest $request)
    {
        $data = $request->validated();
        Log::info('Dados do fechamento:');
        Log::info($data);
        $returnData = $this->reportCashClosingPeriodService->getData($data);
        
        Log::info('Dados retornados:');
        Log::info($returnData);
        
    }

}