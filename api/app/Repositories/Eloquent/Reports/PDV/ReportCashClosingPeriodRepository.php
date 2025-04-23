<?php

namespace App\Repositories\Eloquent\Reports\PDV;

use App\Models\EcommerceModels\PDV;
use Illuminate\Support\Facades\Log;

class ReportCashClosingPeriodRepository
{
    public function returnData(array $data)
    {
        $startDate = $data['start'];
        $endDate = $data['end'];
        $seller = $data['seller']['oneSellerID'];
        
        Log::info('startDate: ' . $startDate . ' EndDate: ' . $endDate . ' NFC-e: ' . $data['nfce'] . ' Nota Manual: ' . $data['nm'] . ' sellerID: ' . $seller . ' allUsers: ' . $data['seller']['allSellers']);

        if($seller && !$data['seller']['allSellers'])
        {
            Log::info('Vai buscar apenas do vendedor: ' . $seller);
            $pdvs = PDV::where(function ($q) use ($data){
                        $q->where('is_nfce_nm', $data['nfce'])
                          ->orWhere('is_nfce_nm', $data['nm']);
                    })
                    ->where('finished', 1)
                    ->where('canceled', 0)
                    ->where('user_id', $seller)
                    ->whereBetween('issue_date', [$startDate, $endDate])
            ->get();
            
        } else {
            Log::info('Vai buscar de todos os vendedores');
            $pdvs = PDV::where(function ($q) use ($data){
                        $q->where('is_nfce_nm', $data['nfce'])
                            ->orWhere('is_nfce_nm', $data['nm']);
                    })
                    ->where('finished', 1)
                    ->where('canceled', 0)
                    ->whereBetween('issue_date', [$startDate, $endDate])
            ->get();

        }
        
        Log::info($pdvs);

        return $pdvs;
    }

}