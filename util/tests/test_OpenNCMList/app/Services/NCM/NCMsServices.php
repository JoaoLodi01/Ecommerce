<?php

class NCMsServices
{
    public function getNCMs()
    {
        $handle = fopen('../../../public/IBPT/SC.csv', 'r');
        $row = 0;

        while ($line = fgetcsv($handle, 1000, ';')) 
        {
            if($row++ == 0){
                continue;
            }

            if($line[2] == 0)
            {
                $ncm = $line[0];
                $description = $line[3];
                $nacional_federal = $line[4];
                $importados_federal = $line[5];
                $estadul = $line[6];
                $municipal = $line[7];
                $inicio = $line[8];
                $fim = $line[9];
                $chave = $line[10];
                $versao = $line[11];
                echo "NCM: $ncm \n";
            }

        }
    
        fclose($handle);

    }
} 

$ncm = new NCMsServices;
echo $ncm->getNCMs();