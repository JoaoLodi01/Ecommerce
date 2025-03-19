<template>
    <div class="payment bg-slate-600 text-white m-auto ml-0 p-3">
        <h1>Formas de Pagamento</h1>
        <div class="flex">
            <form @submit.prevent="finalizeSale">
                <table class="text-black">
                    <tbody>
                        <tr
                            v-for="(payment, index) in payments" :key="payment.id"
                            class="bg-white border border-black focus:border-none"
                        >
                            <td> 
                                <svg
                                    xmlns="http://www.w3.org/2000/svg"
                                    viewBox="0 0 16 16"
                                    fill="currentColor"
                                    class="size-4 inline-flex"
                                    v-if="payment.tipo_lancamento == 'Receber' && payment.especie !== 'Boleto'"
                                    
                                >
                                    <path fill-rule="evenodd" d="M1 3a1 1 0 0 1 1-1h12a1 1 0 0 1 1 1v6a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V3Zm9 3a2 2 0 1 1-4 0 2 2 0 0 1 4 0Zm-6.25-.75a.75.75 0 1 0 0 1.5.75.75 0 0 0 0-1.5ZM11.5 6A.75.75 0 1 1 13 6a.75.75 0 0 1-1.5 0Z" clip-rule="evenodd" />
                                    <path d="M13 11.75a.75.75 0 0 0-1.5 0v.179c0 .15-.138.28-.306.255A65.277 65.277 0 0 0 1.75 11.5a.75.75 0 0 0 0 1.5c3.135 0 6.215.228 9.227.668A1.764 1.764 0 0 0 13 11.928v-.178Z" />
                                </svg>

                                <svg 
                                    xmlns="http://www.w3.org/2000/svg"
                                    fill="none"
                                    viewBox="0 0 24 24"
                                    stroke-width="1.5"
                                    stroke="currentColor" 
                                    class="size-4 inline-flex"
                                    v-if="payment.tipo_lancamento == 'Caixa'"
                                >
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M2.25 18.75a60.07 60.07 0 0 1 15.797 2.101c.727.198 1.453-.342 1.453-1.096V18.75M3.75 4.5v.75A.75.75 0 0 1 3 6h-.75m0 0v-.375c0-.621.504-1.125 1.125-1.125H20.25M2.25 6v9m18-10.5v.75c0 .414.336.75.75.75h.75m-1.5-1.5h.375c.621 0 1.125.504 1.125 1.125v9.75c0 .621-.504 1.125-1.125 1.125h-.375m1.5-1.5H21a.75.75 0 0 0-.75.75v.75m0 0H3.75m0 0h-.375a1.125 1.125 0 0 1-1.125-1.125V15m1.5 1.5v-.75A.75.75 0 0 0 3 15h-.75M15 10.5a3 3 0 1 1-6 0 3 3 0 0 1 6 0Zm3 0h.008v.008H18V10.5Zm-12 0h.008v.008H6V10.5Z" />
                                </svg>

                                <svg 
                                    xmlns="http://www.w3.org/2000/svg"
                                    viewBox="0 0 16 16"
                                    fill="currentColor" 
                                    class="size-4 inline-flex"
                                    v-if="payment.especie == 'Boleto'"
                                >
                                    <path fill-rule="evenodd" d="M1 4.5A1.5 1.5 0 0 1 2.5 3h11A1.5 1.5 0 0 1 15 4.5v1c0 .276-.227.494-.495.562a2 2 0 0 0 0 3.876c.268.068.495.286.495.562v1a1.5 1.5 0 0 1-1.5 1.5h-11A1.5 1.5 0 0 1 1 11.5v-1c0-.276.227-.494.495-.562a2 2 0 0 0 0-3.876C1.227 5.994 1 5.776 1 5.5v-1Zm9 1.25a.75.75 0 0 1 1.5 0v1a.75.75 0 0 1-1.5 0v-1Zm.75 2.75a.75.75 0 0 0-.75.75v1a.75.75 0 0 0 1.5 0v-1a.75.75 0 0 0-.75-.75Z" clip-rule="evenodd" />

                                </svg>
                                
                                {{ payment.especie }} 
                            
                            </td>
                            <td>
                                <input
                                    type="text"
                                    class="text-end w-20"
                                    v-model="paymentsValues[index]"
                                    placeholder="0,00"
                                />
                            </td>
                        </tr>
                    </tbody>
                </table>
                <div class="mt-2 bg-slate-600 w-max rounded-lg">
                    <button class="bg-slate-500 text-white rounded-lg px-2 mt-2 mb-2 mr-2 ml-2" type="submit"> {{ typeOperation === 'reservation' ? "Concluir Reserva" : "Finalizar Venda" }} </button>
                    <button @click="cancelOperation()" class="bg-slate-500 text-white rounded-lg px-2 mt-2 mb-2 mr-2">Cancelar</button>
                    
                </div>
            </form>     
              
            <div class="ml-3 w-full">
                <h3 class="flex justify-between bg-slate-500 text-white rounded-lg m-2 p-1">Total <span>R${{ totalOperation.toFixed(2) }}</span></h3>
                <h3 class="flex justify-between bg-slate-500 text-white rounded-lg m-2 p-0.5">Valor ausente <span>R$ {{ totalOperation.toFixed(2) - calculateValueInformed.total.toFixed(2) }}</span></h3>
                <h3 class="flex justify-between bg-slate-500 text-white rounded-lg m-2 p-0.5">Valor pago <span>R$ {{ calculateValueInformed.total.toFixed(2) }}</span></h3>
                <h3 class="flex justify-between bg-slate-500 text-white rounded-lg m-2 p-1">Troco <span>R$ {{ '0.00' }}</span></h3>
            </div>

            <div class="" v-if="isLoanding">
                <h2>Carregando...</h2>
            </div>    

            <div class="" v-if="message">
                {{ message }} <br>

            </div>
          
        </div>
    </div>

    <div v-if="bigger">
        <h3>Pagamento efetuado maior que o valor do quarto</h3>
        <h3>Deseja gerar crédito no valor de: R$ {{extraAmount }}?</h3>
        <button @click="generateCredit(true, extraAmount)">Sim</button>
        <button @click="generateCredit(false)">Não</button>
    </div>
</template>

<script>
import axios from 'axios';

export default {
    data(){
        return {
            payments: [],
            paymentsValues: [],
            valueInformed: [],
            message: null,
            isLoanding: false,
            bigger: false,
            extraAmount: 0,
            api: process.env.VUE_APP_API_URL,

        };
        
    },
    emits: [
        'close',
        'resetTotal',
        'success'

    ],

    props: {
        // Para o ecommerce
        pdvID: {
            type: Number
        },

        // Para o hotel
        roomID: { 
            type: Number

        },

        show: {
            type: Boolean,
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
                const num = parseFloat(value) || 0;
                return sum + num
            }, 0);

            return {
                total: total
            };
        },
    },

    methods: {
        async getPayments() {
            try {
                const response = await axios.get(`${this.api}/ecommerce/payments/all`);
                this.payments = response.data;
                
            } catch (error) {
                console.error('Erro no getPayments', error)
                
            }
        },
        
        async finalizeSale() {
            this.isLoanding = true
            console.log('pdvID', this.pdvID)

            try {
                switch (this.typeOperation) {
                    case 'reservation':
                        console.log('Começou reserva')
                        const generateCredit = this.calculeCredit(this.paymentsValues);
                        
                        this.isLoanding = !this.isLoanding
                        
                        const response = await axios.post(`${this.api}/hotel/stay/reservation`, {
                            customerID: 1,
                            paymentsValues: this.paymentsValues,
                            roomID: this.roomID,
                            generateCredit: generateCredit
                            
                        });
                        
                        const reservation = response.data
                        
                        this.message = reservation.message ? reservation.message : reservation.errorMessage
                    
                        break;

                    case 'saleNFCe':
                        console.log('Começou venda NFCe')
                        const response_nfce = await axios.put(`${this.api}/ecommerce/pdv/finalize-sale/${this.pdvID}`, {
                            typeOperation: this.typeOperation,
                            paymentsValues: this.paymentsValues,
                            pdvID: this.pdvID
                            
                        })

                        if(response_nfce.data.success === true)
                        {
                            this.cancelOperation()
                            this.$router.push({ name: 'PDV' })
                            
                        }

                        break

                    case 'saleNM':
                        console.log('Começou venda NM')
                        const response_nm = await axios.put(`${this.api}/ecommerce/pdv/finalize-sale/${this.pdvID}`, {
                            typeOperation: this.typeOperation,
                            paymentsValues: this.paymentsValues,
                            pdvID: this.pdvID

                        })
                        console.log(response_nm.data)
                        
                        if(response_nm.data.success === true)
                        {
                            this.cancelOperation()
                            this.$router.push({ name: 'PDV' })

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
                    this.isLoanding = !this.isLoanding
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
                console.log('Passou o valor do quarto: R$', this.totalOperation);
                let option = confirm(`Deseja gerar crédito no valor de: R$ ${extraAmount}?`);
                return option;
            } 
        },

        cancelOperation(){            
            this.$emit("close")
            this.$emit('resetTotal', 0);
            this.$emit('success', []);
        },

        closeOperation(){
            this.$emit("close")

        }
    },
    mounted(){
        this.getPayments();

    },
}
</script>

<style>
    .payment{
        max-width: 32rem;
        width: 32rem;
    }

</style>