<?php

namespace App\Repositories\Eloquent\Config;

use App\Models\AditionalEmail;
use Illuminate\Support\Facades\DB;

class ConfigAditionalEmailRepository
{
    public function getAll(int $issuerID)
    {
        return AditionalEmail::where('issuer_id', $issuerID)->where('active', 1)->get();
    }

    public function create(string $mail, int $issuerID)
    {
        return DB::transaction(function() use ($mail, $issuerID) {
            $max = AditionalEmail::where('issuer_id', $issuerID)->max('aditional_email_code');
            
            return AditionalEmail::create([
                'issuer_id' => $issuerID,
                'aditional_email_code' => $max ? $max + 1 : 1,
                'mail' => $mail

            ]);
        });
    }
    
    public function delete(int $mailCode, int $issuerID)
    {
        return DB::transaction(function() use ($mailCode, $issuerID) {
            return AditionalEmail::where('issuer_id', $issuerID)->where('aditional_email_code', $mailCode)->update([
                'active' => 0
            ]);
        });
    }
}