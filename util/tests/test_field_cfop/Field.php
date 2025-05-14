<?php

require 'vendor/autoload.php';

use PhpOffice\PhpSpreadsheet\IOFactory;

class NCMsServices
{
    public function getNCMs()
    {
        $filePath = './Produots_Supervans1.xlsx';
        $spreadsheet = IOFactory::load($filePath);
        $sheet = $spreadsheet->getActiveSheet();

        $barcodes = [];

        foreach ($sheet->getRowIterator() as $rowIndex => $row) {
            if ($rowIndex === 1) continue; // Pula o cabeçalho

            $cellIterator = $row->getCellIterator();
            $cellIterator->setIterateOnlyExistingCells(false);

            $data = [];
            foreach ($cellIterator as $cell) {
                $data[] = $cell->getFormattedValue();
            }

            if (isset($data[8]) && $data[8] === '5405') {
                $barcodes[] = $data[0]; // Código de Barras
            }
        }

        // Caminho do arquivo de saída
        $outputPath = './codigos_de_barras.txt';

        // Grava os códigos separados por vírgula
        file_put_contents($outputPath, implode(',', $barcodes));

        return $outputPath;
    }
}

// Executa
$ncm = new NCMsServices();
$fileCreated = $ncm->getNCMs();

echo "Arquivo criado: " . $fileCreated;
