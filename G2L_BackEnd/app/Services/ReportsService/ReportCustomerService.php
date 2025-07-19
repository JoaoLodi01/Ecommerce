<?php

namespace App\Services\ReportsService;

use App\Repositories\Eloquent\Reports\Customers\ReportCustomersRepository;
use App\Models\Customer;

class ReportCustomerService
{
    public function __construct(
        protected ReportCustomersRepository $reportCustomersRepository
    )
    {}

    public function exportAllDisabledClients()
    {
        return $this->reportCustomersRepository->exportAllDisabledClients();
    }
}