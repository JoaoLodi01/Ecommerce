<?php

namespace App\Repositories\Eloquent\EcommerceEloquent;

use App\Models\EcommerceModels\Products;

class ProductsRepository
{
    public function getAll(int $active){
        return Products::where('active', $active)->get();
    }

    public function search(array $data)
    {
        return Products::where('active', 1)
            ->where(function ($query) use ($data) {
                if (!empty($data['produto'])) { 
                    $query->where('produto', 'like', '%' . $data['produto'] . '%');
                }

                if (!empty($data['id'])) {
                    $query->orWhere('id', $data['id']);
                }
            })
            ->paginate(10);
}

    public function findByID(int $id){
        return Products::where('id', $id)->first();
    }

    public function store(array $data){
        return Products::create($data);
    }

    public function update(array $data, int $id){
        return Products::where('id', $id)->update($data, $id);
    }

    public function delete(int $id){
        return Products::where('id', $id)->update([
            'active' => 0,
        ]);
    }
}