<?php

namespace App\Services\EcommerceService;

use App\Exceptions\IssuerExceptions\IssuerNotFound;
use App\Repositories\Eloquent\EcommerceEloquent\GroupRepository;
use App\Repositories\Eloquent\EcommerceEloquent\ProductsRepository;
use App\Exceptions\ProductsExceptions\ProductNotFound;
use App\Jobs\ProductsJobs\ImportProductsJob;
use App\Repositories\Eloquent\RegisterEloquent\RegisterIssuerRepository;
use Carbon\Carbon;
use Exception;
use Illuminate\Support\Facades\Log;

class ImportProductService
{

    public function update(array $data, int $id):bool {




        return $this->productsRepository->update($data, $id);
    }



}
