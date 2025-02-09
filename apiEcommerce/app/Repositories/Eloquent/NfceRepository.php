<?php

namespace App\Repositories\Eloquent;

use App\Models\Nfce;
use App\Repositories\Contracts\Base;

class NfceRepository extends BaseRepository implements Base
{
    public function getAll(int $active){
        return Nfce::where('active', $active)->get();
    }

    public function findByID(string $params){
        return Nfce::where('id', $params)
                    ->orWhere('products', 'like', '%'. $params . '%')
                    ->get();
    }

    public function store(array $data){
        return Nfce::create($data);
    }

    public function update(array $data, int $id){
        return Nfce::where('id', $id)->update($data, $id);
    }

    public function delete(int $id){
        return Nfce::where('id', $id)->update([
            'active' => 0,
        ]);
    }

}