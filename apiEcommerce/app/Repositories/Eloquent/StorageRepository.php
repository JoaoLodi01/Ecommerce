<?php

namespace App\Repositories\Eloquent;

use App\Models\Storage;

class StorageRepository
{
    public function getAll(int $active){ //Inserir 1 no service depois
        return Storage::where('active', $active)->get();
    }

    public function findByID(int $id){
        return Storage::where('id', $id)->first();
    }

    public function store(array $data){
        return Storage::create($data);
    }

    public function show(int $id){
        return Storage::where('id', $id)->first();
    }

    public function update(array $data, int $id){
        return Storage::where('id', $id)->update($data, $id);
    }

    public function delete(int $id){
        return Storage::where('id', $id)->update([
            'active' => 0,
        ]);
    }
}