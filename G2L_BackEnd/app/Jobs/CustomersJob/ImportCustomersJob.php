<?php

namespace App\Jobs\CustomersJob;

use App\DTO\Customers\CustomersDTO;
use App\Repositories\Eloquent\CustomerRepository;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Foundation\Queue\Queueable;
use Illuminate\Queue\SerializesModels;
use Box\Spout\Reader\Common\Creator\ReaderEntityFactory;
use Exception;
use Illuminate\Support\Facades\Log;

class ImportCustomersJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

     public function __construct(
            public string $filePath, 
            public int $issuerID
        )
    {
        $this->filePath = $filePath;
        $this->issuerID = $issuerID;
        
    }

    public function handle(CustomerRepository $customerRepository)
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
                        'Razão social',
                        'Nome fantasia',
                        'CNPJ',
                        'CPF'
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

                    $dto = new CustomersDTO(
                        issuer_id: $this->issuerID,
                        company_name: $cells[0]->getValue(),
                        trade_name: $cells[1]->getValue(),
                        cnpj: $cells[2]->getValue(),
                        cpf: $cells[3]->getValue()

                    );

                    $customerRepository->importCustomers($dto);
                }
            }
            $reader->close();
        } catch (\Throwable $th) {
            Log::warning($th->getMessage());
            throw $th;
        }
    }
}