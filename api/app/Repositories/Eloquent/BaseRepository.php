<?php

namespace App\Repositories\Eloquent;

use Illuminate\Database\Eloquent\Model;

class BaseRepository
{
    protected $model;
    public function __construct(Model $model)
    {
        $this->model = $model;
        
    }
    public function getAll(int $active){
        return $this->model->where('active', $active)->get();
        
    }

    public function findByID(string $params){
        return $this->model::where('id', $params)
                    ->orWhere('products', 'like', '%'. $params . '%')
                    ->get();
    }

    public function store(array $data){
        return $this->model::create($data);
    }

    public function update(array $data, int $id){
        return $this->model::where('id', $id)->update($data, $id);
    }

    public function delete(int $id){
        return $this->model::where('id', $id)->update([
            'active' => 0,
        ]);
    }

}