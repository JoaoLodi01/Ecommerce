<?php

namespace App\Repositories\Eloquent\EcommerceEloquent;

use App\DTO\Products\ProductsDTO;
use App\Models\EcommerceModels\Products;
use App\Models\Registers\FirstSteps;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Cache;
use Box\Spout\Reader\Common\Creator\ReaderEntityFactory;
class ProductsRepository 
{
    protected $cacheKeyPrefix = 'products';
    protected $cacheDurration = 10;

    public function __construct(
        protected GroupRepository $groupRepository
    ) {}

    public function getAll(int $issuer_id)
    {
        $cacheKey = "{$this->cacheKeyPrefix}_{$issuer_id}";

        $products = Cache::remember($cacheKey, $this->cacheDurration, function() use ($issuer_id) {
            return Products::where('issuer_id', $issuer_id)->get();

        });

        return $products;
        
    }

    public function search(array $data)
    {
        Log::info('-- Vai começar a busca --');
        Log::info($data);
        $products = null;
        $search = $data['search'];
        $issuerID = $data['issuer_id'];
        
        switch ($data['filter']) {
            case 'Cód barras interno':
                $products = Products::where('active', 1)
                    ->where(function($query) use ($search, $issuerID){
                        $query->where('barcode_internal', $search)
                              ->where('issuer_id', $issuerID);
                        

                    })->get();
                break;
            
            case 'Cód barras':
                $products = Products::where('active', 1)
                    
                    ->where(function($query) use ($search, $issuerID){
                        $query->where('barcode', $search)
                               ->where('issuer_id', $issuerID);

                    })->get();

                break;

            case 'Cód barras & Cód barras interno':
                $products = Products::where('active', 1)
                    ->where(function($query) use ($search, $issuerID){
                        $query->where('issuer_id', $issuerID)
                              ->where('barcode', $search)
                              ->orWhere('barcode_internal');

                    })->get();
                break;
    
            case 'Padrão (nome do produto, cód.barras ou cód.produto)':
                $products = Products::where('active', 1)
                    ->where(function($query) use ($search, $issuerID){
                        $query->where('product_cod', $search)
                                ->orWhere('barcode', $search)
                                ->orWhere('product', 'like', '%' . $search . '%')
                                ->where('issuer_id', $issuerID);
                    })->get();

                Log::info('Padrão (nome do produto, cód.barras ou cód.produto)');
                Log::debug($products);
                break;

            default:
                # code...
                break;
        }
        
        return $products;
    }

    public function formatField(string $field): float|int
    {
        return str_replace(',', '.', $field);
    }

    public function create(array $data)
    {
        Log::info("data");
        Log::info($data);

        $issuer_id = $data['issuer_id'];
        $data['group_id'] ? $group = $this->groupRepository->findByID($data['group_id']) : null;

        $maxCod = Products::where('issuer_id', $issuer_id)->max('product_cod');

        $stpes = FirstSteps::where('issuer_id', $issuer_id)->first();
        $stpes->update([
            'complete_products' => 1
        ]);
        $stpes->save();
        
        return Products::create([
            'product_cod' => $maxCod ? $maxCod + 1 : 1,
            'issuer_id' => $issuer_id,
            'product' => $data['product'],
            'image' => $data['image'],
            'barcode' => $data['barcode'],
            'barcode_internal' => $data['barcodeInternal'],
            'amount' => $data['amount'],
            'group_id' => $group->id ?? null,
            'group' => $group->group ?? null,
            'cost_price' => $this->formatField($data['costPrice']),
            'sale_price' => $this->formatField($data['salePrice']),
            'profit_percentage' => $this->formatField($data['profitPercentage']),
            'unit' => $data['unit'],
            

            // Tributs
            'ncm' => $data['ncm'],
            'cest' => $data['cest'],
            'cfop' => $data['cfop'],    
            'csosncst' => $data['csosncst'],
            'cod_origem_icms' => $data['codOrigemIcms'],
            'origem_icms' => $data['origemIcms'],
            'icms_ecf' => $this->formatField($data['icmsEcf']),
            'taxable_amount' => $data['taxableAmount'] ?? 1,
            'taxable_unit' => $data['taxableUnit'] ?? '1',
            'tax_benefit' => $data['taxBenefit'] ?? '1',
            'cod_ipi' => $data['codIpi'],
            'aliquot_ipi' => $this->formatField($data['aliquotIpi']),
            'cod_pis' => $data['codPis'],
            'aliquot_pis' => $this->formatField($data['aliquotPis']),
            'cod_cofins' => $data['codCofins'],
            'aliquot_cofins' => $this->formatField($data['aliquotCofins']),
            'cod_use_type' => $data['codUseType'] ?? '1',
            'use_type' => $data['useType'] ?? '1',

        ]);
    }

    public function update(array $data, int $id){
        $group = $data['groupId'] ? $this->groupRepository->findByID($data['groupId']) : null;
        return Products::where('id', $id)->update([
            'product' => $data['product'],
            'image' => $data['image'],
            'barcode' => $data['barcode'],
            'barcode_internal' => $data['barcodeInternal'],
            'amount' => $data['amount'],
            'group_id' => $group->id ?? null,
            'group' => $group->group ?? null,
            'cost_price' => $this->formatField($data['costPrice']),
            'sale_price' => $this->formatField($data['salePrice']),
            'profit_percentage' => $this->formatField($data['profitPercentage']),
            'unit' => $data['unit'],
            
            // Tributs
            'ncm' => $data['ncm'],
            'cest' => $data['cest'],
            'cfop' => $data['cfop'],    
            'csosncst' => $data['csosncst'],
            'cod_origem_icms' => $data['codOrigemIcms'],
            'origem_icms' => $data['origemIcms'],
            'icms_ecf' => $this->formatField($data['icmsEcf']),
            'taxable_amount' => $data['taxableAmount'] ?? 1,
            'taxable_unit' => $data['taxableUnit'] ?? '1',
            'tax_benefit' => 1 ?? $data['taxBenefit'],
            'cod_ipi' => $data['codIpi'],
            'aliquot_ipi' => $this->formatField($data['aliquotIpi']),
            'cod_pis' => $data['codPis'],
            'aliquot_pis' => $this->formatField($data['aliquotPis']),
            'cod_cofins' => $data['codCofins'],
            'aliquot_cofins' => $this->formatField($data['aliquotCofins']),
            'cod_use_type' => $data['codUseType'] ?? '1',
            'use_type' => $data['useType'] ?? '1',
            'active' => 1

        ]);
    }

    public function active(int $id, int $productCod)
    {
        $product = Products::where('issuer_id', $id)->where('product_cod', $productCod)->first();
        $product->update([
            'active' => 1

        ]);

        return $product->product;

    }

    public function delete(int $id, int $productCod)
    {
        Log::info($id);
        Log::info($productCod);
        $product = Products::where('issuer_id', $id)
                            ->where('product_cod', $productCod)
                            ->first();

        
        Log::debug($product);
        $product->update([
            'active' => 0

        ]);

        return $product->product;

    }
    
    public function findByID(int $issuerID, int $productCod){
        return Products::where('issuer_id', $issuerID)->where('product_cod', $productCod)->first();
        
    }

    public function decreaseQuantiy(int $product_cod, float|int $quantiy)
    {
        /*Log::info('-- Inicio decreaseQuantiy, linha 50 --');
        $product = $this->findByID($product_cod);
        if($product)
        {
            Log::info('Produto encontrado ' . $product->product_cod . ' produto: ' . $product);
            $product->update([
                'amount' => $product->amount - $quantiy
            ]);
            
        }

        Log::info('-- Fim decreaseQuantiy, linha 62 --');*/
    }

    public function importProducts(ProductsDTO $dto): void
    {
        Log::debug('Repositorio: importProducts');
        Log::debug($dto->amount);
        $maxCod = Products::where('issuer_id', $dto->issuer_id)->max('product_cod');
        Products::create([
            'product_cod' => $maxCod ? $maxCod + 1 : 1,
            'issuer_id' => $dto->issuer_id,
            'product' => $dto->product,
            'cost_price' => $dto->cost_price,
            'profit_percentage' => $dto->profit_percentage,
            'sale_price' => $dto->sale_price,
            'amount' => $dto->amount,
            'cfop' => $dto->cfop,
            'unit' => $dto->unit,
            'csosncst' => $dto->csosncst

        ]);
    } 
}
