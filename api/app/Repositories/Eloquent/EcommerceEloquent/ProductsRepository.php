<?php

namespace App\Repositories\Eloquent\EcommerceEloquent;

use App\Models\EcommerceModels\Products;
use App\Models\Registers\FirstSteps;
use App\Models\Registers\Issuer;
use Illuminate\Support\Facades\Log;
class ProductsRepository 
{
    public function __construct(
        protected GroupRepository $groupRepository
    )
    {}

    public function getAll(int $issuer_id)
    {
        $issuer = Issuer::where('id', $issuer_id)->first();
        Log::info('ProductsRepository: getAll: ' . $issuer_id . ' issuer: ' . $issuer);
        return Products::where('issuer_id', $issuer->id)->get();
    }

    public function search(array $data)
    {
        Log::info('-- Vai começar a busca --');
        Log::info($data);
        $products = null;
        $search = $data['search'];
        $issuer_id = $data['issuer_id'];
        
        switch ($data['fillter']) {
            case 'Cód barras interno':
                $products = Products::where('active', 1)
                    ->where(function($query) use ($search, $issuer_id){
                        $query->where('barcode_internal', $search)
                              ->where('issuer_id', $issuer_id);
                        

                    })->get();
                break;
            
            case 'Cód barras':
                $products = Products::where('active', 1)
                    
                    ->where(function($query) use ($search, $issuer_id){
                        $query->where('barcode', $search)
                               ->where('issuer_id', $issuer_id);

                    })->get();

                break;

            case 'Cód barras & Cód barras interno':
                $products = Products::where('active', 1)
                    
                    ->where(function($query) use ($search, $issuer_id){
                        $query->where('barcode', $search)
                              ->where('issuer_id', $issuer_id)
                              ->orWhere('barcode_internal');

                    })->get();
                break;
    
            case 'Padrão (cód.barras ou cód.produto)':
                $products = Products::where('active', 1)
                    
                    ->where(function($query) use ($search, $issuer_id){
                        $query->where('product_cod', $search)
                                ->where('issuer_id', $issuer_id)
                                ->orWhere('barcode', $search)
                                ->orWhere('product', 'like', '%' . $search . '%');
                    })->get();

                break;

            default:
                # code...
                break;
        }
        
        return $products;
    }

    public function create(array $data)
    {
        Log::info("data");
        Log::info($data);

        $issuer_id = $data['issuer_id'];
        $data['group_id'] ? $group = $this->groupRepository->findByID($data['group_id']) : null;

        $maxCode = Products::where('issuer_id', $issuer_id)->max('product_cod');
        $productCod = $maxCode ? $maxCode + 1 : 1;

        $stpes = FirstSteps::where('issuer_id', $issuer_id)->first();
        $stpes->update([
            'complete_products' => 1
        ]);
        $stpes->save();
        
        return Products::create([
            'product_cod' => $productCod,
            'issuer_id' => $issuer_id,
            'product' => $data['product'],
            'image' => $data['image'],
            'barcode' => $data['barcode'],
            'barcode_internal' => $data['barcode_internal'],
            'amount' => $data['amount'],
            'group_id' => $group->id ?? null,
            'group' => $group->group ?? null,
            'cost_price' => $data['cost_price'],
            'sale_price' => $data['sale_price'],
            'profit_percentage' => $data['profit_percentage'],
            'unit' => $data['unit'],
            

            // Tributs
            'ncm' => $data['ncm'],
            'cest' => $data['cest'],
            'cfop' => $data['cfop'],            
            'csosncst' => $data['csosncst'],
            'cod_origem_icms' => $data['cod_origem_icms'],
            'origem_icms' => $data['origem_icms'],
            'icms_ecf' => $data['icms_ecf'],
            'taxable_amount' => $data['taxable_amount'] ?? '1',
            'taxable_unit' => $data['taxable_unit'] ?? '1',
            'tax_benefit' => $data['tax_benefit'] ?? '1',
            'cod_ipi' => $data['cod_ipi'],
            'aliquot_ipi' => $data['aliquot_ipi'],
            'cod_pis' => $data['cod_pis'],
            'aliquot_pis' => $data['aliquot_pis'],
            'cod_cofins' => $data['cod_cofins'],
            'aliquot_cofins' => $data['aliquot_cofins'],
            'cod_use_type' => $data['cod_use_type'] ?? '1',
            'use_type' => $data['use_type'] ?? '1',

        ]);
    }

    public function update(array $data, int $id){
        $group = $this->groupRepository->findByID($data['groupID']);
        return Products::where('id', $id)->update([
            'product' => $data['product'],
            'amount' => $data['amount'],
            'group_id' => $group->id,
            'group' => $group->group,
            'cost_price' => $data['costPrice'],
            'sale_price' => $data['salePrice'],
            'profit_percentage' => $data['profitPercentage'],
            'cfop' => $data['cfop'],
            'csosncst' => $data['csosncst'],
            'ncm' => $data['ncm'],
            'cest' => $data['cest'],
            'unit' => $data['unit']
        ]);
    }

    public function delete(int $product_cod){
        return Products::where('product_cod', $product_cod)->update([
            'active' => 0,
        ]);
    }
    
    public function findByID(int $product_cod){
        return Products::where('product_cod', $product_cod)->first();
    }

    public function decreaseQuantiy(int $product_cod, float|int $quantiy)
    {
        Log::info('-- Inicio decreaseQuantiy, linha 50 --');
        $product = $this->findByID($product_cod);
        if($product)
        {
            Log::info('Produto encontrado ' . $product->product_cod . ' produto: ' . $product);
            $product->update([
                'amount' => $product->amount - $quantiy
            ]);
            
        }

        Log::info('-- Fim decreaseQuantiy, linha 62 --');
    }
       
}
