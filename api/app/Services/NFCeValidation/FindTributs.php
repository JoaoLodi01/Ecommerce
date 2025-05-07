<?php

namespace App\Services\NFCeValidation;

use App\Repositories\Eloquent\TributsEloquent\TributsRepository;

class FindTributs
{ 
    public function getCFOPs(string $param)
    {        
        $file = fopen("../public/tables/cfop/table-$param.txt", 'r');
        
        $cfops = [];

        while (($line = fgets($file)) !== false) 
        {
            $parts = explode(';', $line);

            if(count($parts) === 2)
            {
                $cfop = trim($parts[0]);
                $description = trim($parts[1], "\" \n\r");
                $cfops[$cfop] = $description;

            }
        }

        fclose($file);

        return $cfops;
    }
    
    public function getCSOSNCST(string $csosncst)
    {
        $file = fopen('../public/tables/csosncst/table-' . count(str_split($csosncst)) . '.txt', 'r');

        $data = [];
        
        while (($line = fgets($file)) !== false) 
        {
            $parts = explode(';', $line);

            if(count($parts) === 2)
            {
                $csosncst = trim($parts[0]);
                $description = trim($parts[1], "\" \n\r");
                $data[$csosncst] = $description;

            }
        }

        fclose($file);
        return $data;
    }
}