<?php

namespace App\Repositories\Eloquent;

use App\Models\Consumer;
use App\Repositories\Contracts\Base;

class ConsumerRepository extends BaseRepository implements Base
{
    public function getAll(int $active){ 
        return Consumer::where('active', $active)->get();
    }

    public function findByID(string $params){
        return Consumer::where('id', $params)->first();
    }

    public function store(array $data){
        return Consumer::create($data);
    }

    public function update(array $data, int $id){
        return Consumer::where('id', $id)->update($data);
    }

    public function delete(int $id){
        return Consumer::where('id', $id)->update([
            'active' => 0,
        ]);
    }
}