<?php
// Lógica do cão pra fazer a separação de valores por espécies funcionar kkkkkkkkkk
// E funciona.
// Não ironicamente não teve GPT aqui
/*Log::info('-- Inicio do registro no caixa, RoomRepository.php, linha 200 --');
                Log::info('Possui mais de uma espécie informada: ' . count($formsPayment));
                $cashRegisters = [];
                for ($i=1; $i < count($payment); $i++) { // Percore todo o array enviado de valores
                    Log::info('$payment[$i] linha - 204: i = ' . $i);
                    Log::info($payment[$i]);
                    if($payment[$i] > 0)
                    {
                        foreach ($formsPayment as $form) 
                        {
                            Log::info('Vai pegar as posições maiores que zero, vezes: ' . $i);
                            Log::info('formsPayment linha 211 - : ');
                            Log::info('ID linha 212 - : ' . $form);
                        
                            $cashRegisters[] = array(
                                'description' => 'Reserva de Hotel',
                                'cliente_id' => $customer->id,
                                'cliente' => $customer->name,
                                'especie_id' => $form->id,
                                'especie' => $form->especie,
                                'data_hora_cadastro' => $currantDate->format('Y-m-d'),
                                'valor_entrada' => $payment[$form->id - 1],
                                'valor_saida' => 0,
                                'saldo_real' => 0,
                                'user_id' => 1,
                                'seller' => 'aa',
                                'origem' => 'Reserva Hotel'
                    
                            );                 
                        }
                    }                         
                }*/
                //$this->cashRegisterRepository->create($cashRegisters);