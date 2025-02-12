<?php

namespace App\Http\Controllers;

use App\Http\Requests\PayMentMethodRequest;
use Illuminate\Http\Client\Request;
use MercadoPago\Client\Common\RequestOptions;
use MercadoPago\Client\Payment\PaymentClient;
use MercadoPago\Exceptions\MPApiException;
use MercadoPago\MercadoPagoConfig;

class PayMentController extends Controller
{
    public function payMentMercadoPago(PayMentMethodRequest $request)
    {
        try {
            //MercadoPagoConfig::setAccessToken(env('MERCADO_PAGO_ACCESS_TOKEN'));
            MercadoPagoConfig::setRuntimeEnviroment(MercadoPagoConfig::LOCAL);

            $client = new PaymentClient();

            $request = [
                "transaction_amount" => 100,
                "token" => "5031433215406351",
                "description" => "description",
                "installments" => 1,
                "payment_method_id" => "mastercard",
                "payer" => [
                    "email" => "user@test.com",
                ]
            ];

            $request_options = new RequestOptions();
            $request_options->setCustomHeaders(["X-Idempotency-Key: <SOME_UNIQUE_VALUE>"]);

            $payment = $client->create($request, $request_options);
            return response()->json($payment->id);

        } catch (MPApiException $e) {
            return response()->json([
                "Status code" => $e->getApiResponse()->getStatusCode() . "\n",
                "error" => $e->getApiResponse()->getContent()
                
            ]);

        } catch (\Exception $e) {
            echo $e->getMessage();
        }
    }

    public function payMent(PayMentMethodRequest $request)
    {
        $data = $request->validated();
        $amount = (float) $data;

    }
}