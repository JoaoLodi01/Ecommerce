<template>
    <QRCode
        v-if="showQRCode"
        :total_amount="totalOperation"
        :issuer_id="this.issuer_id"
        @close="handlePIX"
        class="relative left-[43rem] z-50 -bottom-44 w-[20rem]"
        
    />
    
    <q-card 
        class="relative left-[45rem] mr-14 border border-black mt-5 mb-5 p-6 bg-white shadow-md rounded" 
        :class="{
            '-top-[46rem]': showQRCode,
            'top-1': !showQRCode
        }"
    >
        <q-card-section>
            <div class="text-h6">Formas de Pagamento</div>
        </q-card-section>

        <q-separator />
    
        <q-card-section>
            <q-form @submit.prevent="finalizeSale">
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
                <q-item >
                    
                </q-item>
            </q-list>
                <div class="q-mt-md">
                    <q-btn
                        label="Cancelar"
                        class="ml-52 mr-5"
                        color="negative"
                        @click="cancelOperation"
                    />
                    <q-btn
                        :label="typeOperation === 'reservation' ? 'Concluir Reserva' : 'Finalizar Venda'"
                        color="primary"
                        @click="showLoading()"
                        type="submit"
                    />
                </div>
            </q-form>
        </q-card-section>
    
        <q-separator />
    
        <q-card-section class="bg-white text-black rounded-borders">
            <div class="row q-gutter-sm mb-2">
                <q-chip color="red-6" text-color="white">
                    Valor faltante: R$
                    {{
                    totalOperation.toFixed(2) - calculateValueInformed.total.toFixed(2) > 0
                        ? (totalOperation - calculateValueInformed.total).toFixed(2)
                        : '0.00'
                    }}
                </q-chip>

                <q-chip color="green-7" text-color="white">
                    Valor pago: R$ {{ calculateValueInformed.total.toFixed(2) }}
                </q-chip>

                <q-chip color="blue-6" text-color="white">
                    Troco: R$ {{ calculateValueChange.change.toFixed(2) }}
                </q-chip>
            </div>

            <q-banner class="bg-gray-300 q-mb-sm rounded-xl">
                <div class="text-subtitle2 font-semibold">
                    Total: R$ {{ totalOperation.toFixed(2) }}
                </div>
            </q-banner>

        </q-card-section>
    
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
                <q-btn flat label="Não" @click="generateCredit(false)" />
                <q-btn color="primary" label="Sim" @click="generateCredit(true, extraAmount)" />
            </q-card-actions>
            </q-card>
        </q-dialog>
    
        <q-card-section v-if="message">
            <q-banner dense class="bg-yellow-9 text-white rounded-xl">
                {{ message }}
            </q-banner>
        </q-card-section>

        <Installments
            v-if="showInstallments"
            v-model:show="showInstallments"
            :payments="paymentsReceive"
            :total-amount="totalOperation"
            @installments-saved="handleInstallments"

        />
    </q-card>
</template>

<script>
import { api } from "src/boot/axios";
import { onBeforeUnmount } from 'vue';
import { LocalStorage, useQuasar  } from "quasar";
import Installments from "./PDV/Installments.vue";
import QRCode from "./PDV/QRCode/QRCode.vue";

export default {
    setup(){
            const $q = useQuasar()
            let timer
            onBeforeUnmount(() => {
                if(timer !== void 0) {
                    clearTimeout(timer)
                    $q.loading.hide()

                }
            })

            return { 
                showLoading () {
                    $q.loading.show({
                        message: 'Conferindo pagamento  ...'
                    })

                    timer = setTimeout(() => {
                        $q.loading.hide()
                        timer = void 0
                    }, 3000)
                }
            }
        },  
    data(){
        return {
            generatedInstallments: false,
            paymentInPIX: false,
            paymentsReceive: [],
            paymentPIX: [],
            paymentsValues: [],
            paymentsForms: [],
            valueInformed: [],
            message: null,
            showInstallments: false,
            showQRCode: false,
            bigger: false,
            extraAmount: 0,
            issuer_id: LocalStorage.getItem("issuer_id"),
            user_id: LocalStorage.getItem("user_id")

        };
        
    },

    emits: [
        'close',
        'resetTotal',
        'update:selectProducts',
        'resetPDVID'      

    ],

    components: {
        Installments,
        QRCode
    },

    props: {
        // Para o ecommerce
        pdvID: {
            type: Number
        },

        // Para o hotel
        roomID: { 
            type: Number

        },

        witdhScreen: {
            type: Number,
            required: true
        },

        typeOperation: {
            type: String,
            required: true
    
        },

        totalOperation: {
            type: Number,
            required: true
        }
    },

    computed: {
        calculateValueInformed()
        {
            let total = this.paymentsValues.reduce((sum, value) => {
                
                const num = parseFloat(value.replace(',', '.')) || 0;
                return sum + num
            }, 0);

            return {
                total: total
            };
        },

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
        handleInstallments(installments) {
            this.installments = installments;
            this.generatedInstallments = true;
            this.showInstallments = false;
            this.finalizeSale();
        },

        handlePIX()
        {
            this.paymentInPIX = true
            this.finalizeSale();
            
        },

        async getPayments() {
            try {
                const response = await api.get(`/species/all/${LocalStorage.getItem("issuer_id")}`);
                console.log(response.data)
                this.paymentsForms = response.data.all;
                
            } catch (error) {
                console.error('Erro no getPayments', error)
                
            }
        },
        
        async finalizeSale() {
            this.message = ''

            if (this.installments && this.installments.length > 0) {
                console.log('Parcelas geradas:', this.installments);
            }

            const paymentsReceive = this.paymentsForms.filter((payment, index) => {
                console.log('Vai conferir se tem alguma espécie do RECEBER')
                return payment.tipo_lancamento === 'Receber' && parseFloat(this.paymentsValues[index]) > 0;
            }) // Busca pelo RECEBER

            const paymentPIX = this.paymentsForms.filter((payment, i) =>{
                console.log('Vai conferir se tem alguma espécie do PIX')
                return payment.pix_key !== '' && payment.payments_form_type === 'PIX' && parseFloat(this.paymentsValues[i]) > 0
            }) // Busca pelo PIX

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

            console.log('pdvID: ', this.pdvID)
            try {
                switch (this.typeOperation) {
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
                            this.$emit('update:selectProducts', []);
                            LocalStorage.removeItem("pdvID")

                        } else {
                            LocalStorage.removeItem("pdvID")
                            console.log('Erro durante a finalização da venda: ', response_nfce.data, ' novo PDV ID: ', LocalStorage.getItem("pdvID"))

                        }

                        break

                    case 'nm':
                        console.log('Issuer_id no LocalStorage ( venda NM ): ', LocalStorage.getItem("issuer_id"))
                        const response_nm = await api.put('/ecommerce/pdv/finalize-sale', {
                            issuer_id: this.issuer_id,
                            user_id: this.user_id,
                            type_operation: 'nm',
                            change: this.calculateValueChange.change,
                            payments_values: this.paymentsValues.map(v => parseFloat(v.replace(',', '.'))),
                            pdv_id: this.pdvID,
                            installments: this.installments
                            
                        })

                        console.log(response_nm);
                        if(response_nm.data.success)
                        {
                            this.cancelOperation()
                            this.$emit('update:selectProducts', []);
                            LocalStorage.removeItem("pdvID")
                        } else {
                            LocalStorage.removeItem("pdvID")
                            console.log('Erro durante a finalização da venda: ', response_nm.data, ' novo PDV ID: ', LocalStorage.getItem("pdvID"))
                        }

                        break

                    default:
                        console.log('Operation not defined',  this.typeOperation)
                        break;
                    }
                
            } catch (error) {
                console.error('Error: ', error)
                
                if(error.response)
                {
                    this.message = error.response.data.message
          
                }  
            }
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
            this.$emit("close")
            this.$emit("resetPDVID", null)
            this.$emit('resetTotal', 0);
   
        },

        closeOperation(){
            this.$emit("close")
            
        },
    },
    mounted(){
        this.getPayments();
        console.log('this.pdvID', this.pdvID)
    },
}
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