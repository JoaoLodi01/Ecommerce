<?php

$cashRegisters = [];
                Log::info($payment);
                Log::info('Teve mais de uma especie informada');
                Log::info('Quantia formsPayment: ' . count($formsPayment));
                for ($i= 0; $i < count($forms); $i++) {
                    Log::info('Contador for i: ' . $i);
                    Log::info('ID: ' . $formsPayment[$i]['id']);

                    for ($t=0; $t < count($payment); $t++) { 
                        Log::info($payment[$t] > 0);
                        if($payment[$t] > 0)
                        {
                            Log::info('Contador for t: ' . $t);
                            Log::info('valores payment ' . $payment[$t]);   
                            $cashRegisters[] = array(
                                'description' => 'Reserva de Hotel',
                                'cliente_id' => $customer->id,
                                'cliente' => $customer->name,
                                'especie_id' => $formsPayment[$i]['id'],
                                'especie' => $formsPayment[$i]['especie'],
                                'data_hora_cadastro' => $currantDate->format('Y-m-d'),
                                'valor_entrada' => $payment[$i],
                                'valor_saida' => 0,
                                'saldo_real' => 0,
                                'user_id' => 1,
                                'seller' => 'aa',
                                'origem' => 'Reserva Hotel'
                
                            );    

                            Log::info('Dados: ');
                            Log::info($cashRegisters);
                            
                        }
                    }
                }