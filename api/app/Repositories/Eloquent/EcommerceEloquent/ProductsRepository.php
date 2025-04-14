<?php

namespace App\Repositories\Eloquent\EcommerceEloquent;

use App\Models\EcommerceModels\Products;
use App\Repositories\Contracts\EcommerceContract\Products as C;
use Illuminate\Support\Facades\Log;

class ProductsRepository 
{
    public function __construct(
        protected GroupRepository $groupRepository
    )
    {}

    public function getAll()
    {
        return Products::paginate(10);
    }

    public function search(array $data)
    {
        Log::info('-- Vai começar a busca --');
        Log::info($data);
        $products = null;
        $search = $data['search'];
        
        switch ($data['fillter']) {
            case 'Cód barras interno':
                $products = Products::where('active', 1)
                    ->where('product', 'like', '%' . $search . '%')
                    ->get();

                    Log::info('O que achou: ');
                    Log::info($products);

                break;
            
            case 'Cód barras':

                break;

            case 'Padrão (cód.barras ou cód.produto)':
                $products = Products::where('active', 1)
                            ->where(function($query) use ($search){
                                $query->where('id', $search)
                                        ->orWhere('barcode', $search)
                                        ->orWhere('product', 'like', '%' . $search . '%');
                            })->get();

                Log::info('O que achou: ');
                Log::info($products);
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
        Log::info("data[groupID]");
        Log::info($data['groupID']);
        $group = $this->groupRepository->findByID($data['groupID']);

        return Products::create([
            'product' => $data['product'],
            'image' => $data['image']->getClientOriginalName(),
            'barcode' => $data['barcode'],
            'barcode_internal' => $data['barcode_internal'],
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