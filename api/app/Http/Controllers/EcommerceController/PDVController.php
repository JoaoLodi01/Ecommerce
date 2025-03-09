<?php

namespace App\Http\Controllers\EcommerceController;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Requests\EcommerceRequest\PDVSaveSaleRequest;
use App\Services\EcommerceService\PDVService;


class PDVController extends Controller
{
    public function __construct(
        protected PDVService $pdvService
    ){
        $this->pdvService = $pdvService;
    }

    public function getAll(){
        return $this->pdvService->getAll();
    }

    public function store(Request $request){
        //$data = $request->validated();
        return $this->pdvService->store($request->all());
    }

    public function update(Request $request, int $id){
        //$data = $request->validated();
        return $this->pdvService->update($request->all(), $id);

    }

    public function saveSale(PDVSaveSaleRequest $request)
    {
        $data = $request->validated();
        
        return $this->pdvService->saveSale($data);
        
    }
}
