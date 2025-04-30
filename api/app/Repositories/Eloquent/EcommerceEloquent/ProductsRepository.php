<?php

namespace App\Repositories\Eloquent\EcommerceEloquent;

use App\Models\EcommerceModels\Products;
use App\Models\FirstSteps;
use App\Models\Issuer;
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

    public function findByID(int $id){
        return Products::where('id', $id)->first();
    }
    
    public function findImage(int $id){
        $product = Products::where('id', $id)->first();

        Log::info($product->image);

        return response($product->image)->header('Content-Type', 'image/jpeg');
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
            'cfop' => $data['cfop'],
            'csosncst' => $data['csosncst'],
            'ncm' => $data['ncm'],
            'cest' => $data['cest'],
            'unit' => $data['unit']

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

    public function delete(int $id){
        return Products::where('id', $id)->update([
            'active' => 0,
        ]);
    }

    public function decreaseQuantiy(int $id, float|int $quantiy)
    {
        Log::info('-- Inicio decreaseQuantiy, linha 50 --');
        $product = $this->findByID($id);
        if($product)
        {
            Log::info('Produto encontrado ' . $product->id);
            Log::info($product);
            $product->update([
                'amount' => $product->amount - $quantiy
            ]);
            
        }

        Log::info('-- Fim decreaseQuantiy, linha 62 --');
    }

        
}
