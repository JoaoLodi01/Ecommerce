<?php

namespace App\Services;

use App\Exceptions\ExceptionCreateCustomer;
use App\Repositories\Eloquent\CustomerRepository;
use Illuminate\Support\Facades\Log;
use App\Exceptions\CustomersExceptions\CustomerNotFound;
use App\Jobs\CustomersJob\ImportCustomersJob;
use Carbon\Carbon;
use Illuminate\Support\Facades\Cache;

class CustomerService
{
    protected $cacheKeyPrefix;
    protected $chaceTime;

    public function __construct(
        protected CustomerRepository $customerRepository
    )
    {}

    public function getAll(int $issuer_id){
        return $this->customerRepository->getAll($issuer_id);

    }

    public function search(array $searchData){
        $customer = $this->customerRepository->search($searchData);
        
        if(!$customer)
        {
            throw new CustomerNotFound("Cliente não encontrado");
            
        }

        return $customer;
    }

    public function findByID(int $id){
        $customer = $this->customerRepository->findByID($id);
        
        if(!$customer)
        {
            throw new CustomerNotFound("Cliente não encontrado");

        }

        return $customer;
        
    }

    public function create(array $data){
        $customer = $this->customerRepository->create($data);
        
        if(!$customer)
        {
            throw new \App\Exceptions\CustomersExceptions\CustomerCreateException("Erro na criação do cliente");
        }

        return $customer;

    }

    public function update(array $data, int $id){
        $customer = $this->customerRepository->update($data, $id);

        if(!$customer)
        {
            throw new CustomerNotFound("Cliente não encontrado");

        }

        return $customer;

    }

    public function delete($id)
    {
        $customer = $this->customerRepository->delete($id);

        if(!$customer)
        {
            throw new CustomerNotFound("Cliente não encontrado");

        }

        return $customer;
    }

    public function active($id)
    {
        $customer = $this->customerRepository->active($id);

        if(!$customer)
        {
            throw new CustomerNotFound("Cliente não encontrado");

        }

        return $customer;
    }

    public function importCustomers(object $file, int $issuerID)
    {
        Log::debug('Caiu no import service');
        $fileName = $file->getClientOriginalName();
        $date = new Carbon();
        $directory = storage_path("files/{$issuerID}/customers/" . $date->format('Y-m-d'));

        if(!is_dir($directory))
        {
            mkdir($directory, 0755, true);

        }

        $file->move($directory, $fileName);
        
        //$path = public_path('files/' . $file->getClientOriginalName());
        //unlink($path);
        $filePath = $directory . DIRECTORY_SEPARATOR . $fileName;
        $importJob = ImportCustomersJob::dispatch($filePath, $issuerID);
        
        if(!$importJob)
        {
            Log::warning('Erro no Job');
            return;
        };
        return $directory . DIRECTORY_SEPARATOR . $fileName;
    }
}
