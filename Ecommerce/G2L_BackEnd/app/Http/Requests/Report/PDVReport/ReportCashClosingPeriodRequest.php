<?php

namespace App\Http\Requests\Report\PDVReport;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Auth;

class ReportCashClosingPeriodRequest extends FormRequest
{
    public function authorize(): bool
    {
        return Auth::check();
    }

    public function rules(): array
    {
        return [
            'start' => ['required', 'date'],
            'end' => ['required', 'date'],
            'nfce' => ['nullable', 'required_without:nm'],
            'nm' => ['nullable', 'required_without:nfce'],
            'seller' => ['required']
        ];
    }
}