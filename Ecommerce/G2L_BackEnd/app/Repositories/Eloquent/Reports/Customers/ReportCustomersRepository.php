<?php

namespace App\Repositories\Eloquent\Reports\Customers;

use App\Models\Customer;

class ReportCustomersRepository
{
    public function exportAllDisabledClients()
    {
        return Customer::where('active', '=', 0)->get();

    }
}