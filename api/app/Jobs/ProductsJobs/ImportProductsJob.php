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
use Illuminate\Support\Facades\Log;

class ImportProductsJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    public string $filePath;
    public int $issuerID;

    public function __construct(
            string $filePath, 
            int $issuerID
        )
    {
        $this->filePath = $filePath;
        $this->issuerID = $issuerID;
        
    }

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
                    if($firstRow)
                    {
                        $firstRow = false;
                        continue;

                    }

                    $cells = $row->getCells();
                    Log::debug('Dentro foreach 2');

                    $dto = new ProductsDTO(
                        issuer_id: $this->issuerID,
                        product: $cells[0]->getValue(),
                        cost_price: $cells[1]->getValue(),
                        sale_price: $cells[2]->getValue(),
                        profit_percentage: $cells[3]->getValue(),
                        cfop: $cells[4]->getValue(),
                        unit: $cells[5]->getValue(),
                        csosncst: $cells[6]->getValue()

                    );

                    $productsRepository->importProducts($dto);
                }
            }
            $reader->close();
        } catch (\Throwable $th) {
            Log::warning($th->getMessage());
        }
    }
}