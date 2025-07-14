<?php

namespace App\Services\ReportsService\PDVReportService;

use App\Repositories\Eloquent\Reports\PDV\ReportCashClosingPeriodRepository;

class ReportCashClosingPeriodService
{
    public function __construct(
        protected ReportCashClosingPeriodRepository $reportCashClosingPeriodRepository
    ){}

    public function getData(array $data)
    {
        $returnData = $this->reportCashClosingPeriodRepository->returnData($data);

        return $returnData;

    }
}