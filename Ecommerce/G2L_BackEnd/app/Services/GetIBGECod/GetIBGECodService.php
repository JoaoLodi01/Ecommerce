<?php

namespace App\Services\GetIBGECod;

use Illuminate\Support\Facades\Log;
use Box\Spout\Reader\Common\Creator\ReaderEntityFactory;
class GetIBGECodService
{
    public function readerFile(string $path, string $city)
    {
        $reader = ReaderEntityFactory::createXLSXReader();
        $reader->open($path);

        foreach ($reader->getSheetIterator() as $sheet) {
            foreach ($sheet->getRowIterator() as $row) {
                $cells = $row->getCells();

                $cellCityName = $cells[8]->getValue();
                $cellIBGE = $cells[7]->getValue();
            
                if($city === $cellCityName)
                {
                    //Log::channel('uf_code')->debug('Código: ' . $cellIBGE);
                    $reader->close();
                    return $cellIBGE;
                    
                }
            }
        }
        $reader->close();
        Log::channel('uf_code')->warning("Cidade '$city' não encontrada na planilha.");
        return null;
    }

    public function getData(string $city)
    {
        $dir = public_path('tables');
        $path = "$dir/estados/MUNICIPIOS.xlsx";

        if($path && $city)
        {
            $data = $this->readerFile($path, $city);
            Log::channel('uf_code')->debug((string) $data);
            return $data;
        }        
    }
}