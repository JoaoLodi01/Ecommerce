<?php

namespace App\Repositories\Eloquent;

use App\Models\Products;
use App\Repositories\Contracts\Base;

class ProductsRepository
{
    public function getAll(int $active){
        return Products::where('active', $active)->get();
    }

    public function search(array $data){
        return Products::where('active', 1)
                       ->where(function ($query) use ($data) {
                           $query->where('name', 'like', '%' . $data['name'] . '%')
                                 ->orWhere('id', $data['id']);
                       })
                       ->paginate(10);
    }

    public function findByID(string $params){
        return Products::where('id', $params)->first();
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