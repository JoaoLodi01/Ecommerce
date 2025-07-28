<?php

namespace App\Jobs\ProductsJobs;

use App\DTO\Products\ProductsDTO;
use App\Repositories\Eloquent\EcommerceEloquent\ProductsRepository;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Foundation\Queue\Queueable;
use Illuminate\Queue\SerializesModels;
use Box\Spout\Reader\Common\Creator\ReaderEntityFactory;
use Exception;
use Illuminate\Support\Facades\Log;

class ImportProductsJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    public function __construct(
        public string $filePath, 
        public int $issuerID,
    ){}

    public function handle(ProductsRepository $productsRepository)
    {
        try {
            Log::debug('Caiu no job');
            $reader = ReaderEntityFactory::createXLSXReader();
            $reader->open($this->filePath);

            $firstRow = true;
            foreach ($reader->getSheetIterator() as $sheet) 
            {
                Log::debug('Dentro foreach 1');
                foreach ($sheet->getRowIterator() as $row) {
                    $cells = $row->getCells();
                    $expectedHeader = [
                        'Nome produto', 
                        'Preço de custo', 
                        'Perce. De Lucro', 
                        'Preço de venda', 
                        'Qtde',
                        'CFOP',
                        'UN',
                        'CSOSN/CST'
                    ];

                    if ($firstRow) {
                        $header = array_map(fn($cell) => trim($cell->getValue()), $cells);

                        if (count($header) !== count($expectedHeader)) {
                            throw new Exception('A planilha deve conter exatamente ' . count($expectedHeader) . ' colunas! Confirme os dados da mesma e tente novamente!');
                        }

                        foreach ($header as $i => $colName) {
                            if (mb_strtolower($colName) !== mb_strtolower($expectedHeader[$i])) {
                                throw new Exception("Coluna inválida na posição " . ($i+1) . ": esperado '{$expectedHeader[$i]}', recebido '{$colName}'");
                            }
                        }

                        $firstRow = false;
                        continue;
                    }

                    $isRowEmpty = collect($cells)->every(function ($cell) {
                        return is_null($cell->getValue()) || trim($cell->getValue()) === '';
                    });

                    if ($isRowEmpty) {
                        continue;
                    }

                    $dto = new ProductsDTO(
                        issuer_id: $this->issuerID,
                        product: $cells[0]->getValue(),
                        cost_price: floatval(str_replace(',', '.', $cells[1]->getValue())),
                        profit_percentage: floatval(str_replace(',', '.', $cells[2]->getValue())),
                        sale_price: floatval(str_replace(',', '.', $cells[3]->getValue())),
                        amount: floatval($cells[4]->getValue()),
                        cfop: $cells[5]->getValue(),
                        unit: $cells[6]->getValue(),
                        csosncst: $cells[7]->getValue()

                    );

                    $productsRepository->importProducts($dto);
                }
            }
            $reader->close();
        } catch (\Throwable $th) {
            Log::warning($th->getMessage());
            throw $th;
        }
    }
}