<template>
    <div 
        v-if="showQRCode"
        class="fixed inset-0 z-50 flex items-center justify-center bg-opacity-40 backdrop-blur-sm"
    >
        <QRCode
            :total_amount="totalPaymentPIX"
            :issuer_id="issuerID"
            @close="handlePIX"
            @discount="discountTotalByPIX($event)"
            class="relative left-[20rem] top-5 z-50 w-[20rem]"
            
        />
    </div>

    <div 
        v-if="showInstallments"
        class="fixed inset-0 z-50 flex items-center justify-center bg-opacity-40 backdrop-blur-sm"
    >
        <RegisterReceive
            :total_amount="totalOperation"
            :width-screen="witdhScreen"
            :pdv="true"
            class="border border-gray-500 rounded-md"    
        />

    </div>
    
    <q-card 
        class="absolute w-[100vh] left-[18rem] mr-14 border border-black mt-5 mb-5 p-6 bg-white shadow-md rounded"
        v-if="!showQRCode && !showInstallments && showPayMentForms"

    >
        <q-card-section>
            <div class="text-h6">Formas de Pagamento</div>

        </q-card-section>

        <q-separator />
    
        <q-card-section>
            <q-form @submit.prevent="confirmPayMent">
                <q-list bordered separator class="bg-white text-black rounded-borders">
                    <q-item v-for="(payment, i) in paymentsForms" :key="i">
                        <q-item-section>
                            <q-icon
                                v-if="payment.tipo_lancamento === 'Receber'"
                                name="mdi-credit-card-outline"
                                color="primary"
                                class="q-mr-sm"
                            />
                            <q-icon
                                v-else-if="payment.tipo_lancamento === 'Caixa'"
                                name="mdi-cash-register"
                                color="green"
                                class="q-mr-sm"
                            />
                            {{ payment.especie }}
                        </q-item-section>
        
                        <q-item-section side>
                            <q-input
                                @input="calculateValueInformed"
                                v-model="paymentsValues[i]"
                                input-class="text-right"
                                class="w-24"
                                dense
                                outlined
                                placeholder="0,00"
                                mask="##,##"
                                fill-mask="0"
                                reverse-fill-mask

                            />
                        </q-item-section>
                </q-item>
            </q-list>
                <q-card-section class="bg-white text-black rounded-borders">
                    <div class="row q-gutter-sm mb-2">
                        <q-chip color="red-6" text-color="white">
                            Valor faltante: R$
                            {{
                                Number(props.totalOperation.toFixed(2)) - calculateValueInformed
                            }}
                        </q-chip>

                        <q-chip color="green-7" text-color="white">
                            Valor pago: R$ {{ calculateValueInformed }}
                        </q-chip>

                        <q-chip color="blue-6" text-color="white">
                            Troco: R$ {{  }}
                        </q-chip>
                    </div>

                    <q-banner class="bg-gray-300 q-mb-sm rounded-xl">
                        <div class="text-subtitle2 font-semibold">
                            Total: R$ {{ totalOperation.toFixed(2) }}
                        </div>
                    </q-banner>

                </q-card-section>
                <div class="q-mt-md relative left-32">
                    <q-btn
                        label="Cancelar"
                        class="ml-52 mr-5"
                        color="negative"
                        @click="cancelOperation"

                    />

                    <q-btn
                        :label="typeOperation === 'reservation' ? 'Concluir Reserva' : 'Finalizar Venda'"
                        color="primary"
                        type="submit"

                    />

                </div>
            </q-form>
    
        </q-card-section>
    
        <q-separator />
    
        <q-dialog v-model="bigger">
            <q-card>
            <q-card-section>
                <div class="text-h6">
                Pagamento maior que o valor
                </div>
                <div class="q-mt-sm">
                Deseja gerar crédito de <strong>R$ {{ extraAmount }}</strong>?
                </div>
            </q-card-section>
            <q-card-actions align="right">
                <q-btn flat label="Não" @click="" />
                <q-btn color="primary" label="Sim" @click="" />
            </q-card-actions>
            </q-card>
        </q-dialog>
    
        <q-card-section v-if="message">
            <q-banner dense class="bg-yellow-9 text-white rounded-xl">
                {{ message }}

            </q-banner>
        </q-card-section>

    </q-card>
    <div v-if="!showInstallments && !showPayMentForms && !showQRCode">
        <LoandingPage
            @show-page="showPayMentForms = $event"
            :text="'Carregando formas de pagamento ...'"
        />
    </div>
</template>

<script setup lang="ts">
    import { api } from "src/boot/axios";
    import { ref, defineProps, defineEmits, onMounted, computed, warn } from 'vue';
    import { LocalStorage, useQuasar  } from "quasar";
    import RegisterReceive from './Register/Financial/RegisterReceive.vue';
    import QRCode from './PDV/QRCode/QRCode.vue';
    import LoandingPage from 'src/components/Loanding/LoandingPage.vue';

    const $q = useQuasar();
    
    let showPayMentForms = ref<boolean>(false);
    let generatedInstallments = ref<boolean>(false);
    let message = ref<string>('');
    let showInstallments = ref<boolean>(false);
    let showQRCode = ref<boolean>(false);
    let bigger = ref<boolean>(false);
    let extraAmount = ref<number>(0); // troco

    let show = ref<boolean>(false);
    
    // Pagamentos \\
    let hasPIX = ref<boolean>(false);
    let totalPaymentPIX = ref<number>(0);

    let paymentsValues = ref([]);

    let paymentsForms = ref<IPaymentForm[]>([]);
    
    // -------------------- \\
    
    const issuerID = ref<number>(LocalStorage.getItem("issuer_id"));
    const user_id = ref<number>(LocalStorage.getItem("user_id"));
    
    const emits = defineEmits<{
        (e: 'close', value: boolean),
        (e: 'resetTotal', value: number),
        (e: 'update:selectProducts', value: true),
        (e: 'resetPDVID', value: number)
        
    }>();
    
    const props = defineProps<{
        // Para o ecommerce
        pdvID: number,
        
        // Para o hotel
        roomID: number,
        
        witdhScreen: number,
        
        typeOperation: string,
        
        totalOperation: number
        
    }>();

    function formatNumber(strNumber: string ): number
    {
        return Number(strNumber.replace(',', '.') || 0);
        
    }

    const handleInstallments = (installments) =>
    {
        installments = installments;
        generatedInstallments.value = true;
        showInstallments.value = false;
        //finalizeSale();

    };

    const confirmPayMent = async () =>
    {           
        paymentsValues.value.map((pay, i) => {
            const species = paymentsForms.value[i];

            if(species.tipo_lancamento === 'Receber')
            {
                showInstallments.value = true;
                
            };

            if(species.pix_key !== null && species.payments_form_type === 'PIX')
            {
                console.log('Tem PIX');
                totalPaymentPIX.value = formatNumber(pay);
                showQRCode.value = true;
                
            };
        });

        let totalNotFormated = paymentsValues.value.reduce((sum, acc) => { 
            return sum + acc;

        });

        let total = totalNotFormated.replace(',', '.') || 0;

        if(total)
        {
            console.log('Total pago: ', paymentsValues.value);
            console.log(`Teve pix ou receber? ${showInstallments.value} | ${showQRCode.value}`);

            
            const res = await api.put('/ecommerce/pdv/finalize-sale', {
                issuer_id: issuerID.value,
                user_id: user_id.value,
                type_operation: props.typeOperation,
                change: 0,
                payments_values: paymentsValues.value.map(v => parseFloat(v.replace(',', '.'))),
                pdv_id: props.pdvID,
                installments: null

            });

            console.log('Resultado da venda:', res.data);
            if(res.data.success)
            {
                $q.notify({
                    color: 'green',
                    message: res.data.data,
                    timeout: 2000,
                    position: 'top'

                });

                //finallySale();
            };
            
        } else {
            //console.log('Total a ser pago: ', props.totalOperation - total);
        };
    }; // Vai conferir os valores pagos e gerenciar o que precisa ser feito, PIX ou receber...

    const handlePIX = () =>
    {
        showQRCode.value = false;
        hasPIX.value = true;

    };

    const discountTotalByPIX = (event: number) =>
    {
        let totalOperation = props.totalOperation;
        totalOperation -= event;

    };
    
    const calculateValueInformed = computed(() =>
    {
        let total = paymentsValues.value.reduce((sum, value) => 
        {
            const str = String(value);
            const num = parseFloat(str.replace(',', '.')) || 0;
            
            return sum + num;
            
        }, 0);

        return total.toFixed(2);

    }); 

    const finallySale = () =>
    {
        emits("close", true);
        emits("resetPDVID", 0);
        emits('resetTotal', 0);
        emits('update:selectProducts', true);
    };

    const cancelOperation = () =>
    {
        emits("close", true);
        emits("resetPDVID", null);
        emits('resetTotal', 0);
    
    };

    const getPayments = async () =>
    {
        const res = await api.get(`/species/all/${issuerID.value}`);
        paymentsForms.value = res.data.all // Chama as formas de pagamento;

    };

    onMounted(() => {
        console.log('Total a ser pago: ', props.totalOperation);
        getPayments();
        
    })

    /*
    const finalizeSale = async () =>
    {
        showLoading();
        message.value = '';

        if (installments && this.installments.length > 0) 
        {
            console.log('Parcelas geradas:', this.installments);
        }

        const paymentsReceive = paymentsForms.filter((payment, index) => {
            console.log('Vaio cnferir se tem alguma espécie do RECEBER');
            return payment.tipo_lancamento === 'Receber' && parseFloat(this.paymentsValues[index]) > 0;

        }); // Busca pelo RECEBER

        const paymentPIX = this.paymentsForms.filter((payment, i) =>{
            console.log('Vai conferir se tem alguma espécie do PIX');
            return payment.pix_key !== '' && payment.payments_form_type === 'PIX' && parseFloat(this.paymentsValues[i]) > 0;

        }); // Busca pelo PIX

        if (paymentsReceive.length > 0 && !this.generatedInstallments) {
            console.log(`tem ${paymentsReceive.length} espécies do RECEBER`)
            this.paymentsReceive = paymentsReceive;
            this.paymentsValues = this.paymentsValues;
            this.showInstallments = true;
            return;
        }

        if (paymentPIX.length > 0 && !this.paymentInPIX ) {
            console.log(`tem ${paymentsReceive.length} espécies PIXs`)
            this.paymentPIX = paymentPIX;
            this.paymentsValues = this.paymentsValues;
            this.showQRCode = true;
            return;
        }

        switch (this.typeOperation) 
        {
            case 'reservation':
                const generateCredit = this.calculeCredit(this.paymentsValues);
                
                this.isLoanding = !this.isLoanding
                
                const response = await api.post('/hotel/stay/reservation', {
                    customer_id: 1,
                    installments: this.installments,
                    payments_values: this.paymentsValues,
                    room_id: this.roomID,
                    generate_credit: generateCredit
                    
                });
                
                const reservation = response.data
                
                this.message = reservation.message ? reservation.message : reservation.errorMessage
            
                break;

            case 'nfce':
                console.log('Issuer_id no LocalStorage ( venda NFC-e ): ', LocalStorage.getItem("issuer_id"))
                const response_nfce = await api.put('/ecommerce/pdv/finalize-sale', {
                    issuer_id: this.issuer_id,
                    user_id: this.user_id,
                    type_operation: 'nfce',
                    change: this.calculateValueChange.change,
                    payments_values: this.paymentsValues.map(v => parseFloat(v.replace(',', '.'))),
                    pdv_id: this.pdvID,
                    installments: this.installments

                })
                console.log(response_nfce);

                if(response_nfce.data.success)
                {
                    this.cancelOperation()
                    emits('update:selectProducts', []);
                    LocalStorage.removeItem("pdvID");

                } else {
                    LocalStorage.removeItem("pdvID");
                    console.error('Erro durante a finalização da venda: ', response_nfce.data, ' novo PDV ID: ', LocalStorage.getItem("pdvID"));

                };

                break

            case 'nm':
                console.log('Issuer_id no LocalStorage ( venda NM ): ', LocalStorage.getItem("issuer_id"))
                if(this.pdvID)
                {
                    const response_nm = await api.put('/ecommerce/pdv/finalize-sale', {
                        issuer_id: this.issuer_id,
                        user_id: this.user_id,
                        type_operation: 'nm',
                        change: this.calculateValueChange.change,
                        payments_values: this.paymentsValues.map(v => parseFloat(v.replace(',', '.'))),
                        pdv_id: this.pdvID,
                        installments: this.installments
                        
                    }, {
                        headers: {
                            Accept: 'application/json'
                        }
                    });

                    if(response_nm.data.success)
                    {
                        this.cancelOperation()
                        emits('update:selectProducts', []);
                        LocalStorage.removeItem("pdvID")
                        console.log(response_nm.data);    
                    
                    } else {
                        LocalStorage.removeItem("pdvID")
                        console.error('Erro durante a finalização da venda: ', response_nm.data, ' novo PDV ID: ', LocalStorage.getItem("pdvID"))
                        console.error(response_nm);
                        
                    };
                    
                } else {
                    alert('ID da venda ausente');

                };

                break

            default:
                console.log('Operation not defined',  this.typeOperation)
                break;
        }
    };

    computed: {
        ,

        calculateValueChange()
        {
            let total = this.paymentsValues.reduce((sum, value) => {
                const num = parseFloat(value.replace(',', '.')) || 0;
                return num + sum 
            }, 0);

            if(total && total > 0 && total > this.totalOperation)
            {
                return {
                    change: total - this.totalOperation

                };

            }
            
            return {
                change: 0
            };
        }
    },

    methods: {
        

        handlePIX()
        {
            this.paymentInPIX = true
            this.finalizeSale();
            
        },        

        calculeCredit(paymentsValues = [])
        {
            let total = 0;
            paymentsValues.forEach(values => {
                total += values;

            });

            let extraAmount = this.totalOperation - total;
            
            if(total > this.totalOperation)
            {   
                let option = confirm(`Deseja gerar crédito no valor de: R$ ${extraAmount}?`);
                return option;
            } 
        },

        cancelOperation(){            
            emits("close")
            emits("resetPDVID", null)
            emits('resetTotal', 0);
   
        },

        closeOperation(){
            emits("close")
            
        },
    },
    mounted(){
        this.getPayments();
        console.log('this.pdvID', this.pdvID)
    },*/

</script>

<style>
    @media (min-width: 1080px) {
        .payment{ 
            max-width: 32rem;
                
        }
    }
    .payment{
        max-width: 32rem;
        
    }

</style>