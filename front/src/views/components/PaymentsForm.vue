<template>
    <div class="payments-container bg-slate-600 text-white">
        <h1>Formas de Pagamento</h1>
        <div>
            <form @submit.prevent="finalizeSale">
                <table class="text-black">
                    <thead>
                        <tr>
                            <th>Formas de pagamento</th>
                            <th>Valores</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="(payment, index) in payments" :key="payment.id">
                            <td>{{ payment.especie }}</td>
                            <td>
                                <input
                                    type="number"
                                    v-model="paymentsValues[index]"
                                    placeholder="0.00"
                                    
                                />
                            </td>
                        </tr>
                    </tbody>
                </table>
                <div class="ml-16 mt-2 bg-slate-600 w-max flex rounded-lg">
                    <button class="bg-slate-500 text-white rounded-lg px-2 mt-2 mb-2 mr-2 ml-2" type="submit"> {{ typeOperation === 'reservation' ? "Concluir Reserva" : "Finalizar Venda" }} </button>
                    <button @click="cancelOperation()" class="bg-slate-500 text-white rounded-lg px-2 mt-2 mb-2 mr-2">Cancelar</button>
                    <h3 class="bg-slate-500 text-white rounded-lg px-2 mt-2 mb-2 mr-2">Total: R$ {{ totalOperation }}</h3>
                </div>
            </form>
            

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
            message: null,
            isLoanding: false,
            bigger: false,
            extraAmount: 0,
            api: process.env.VUE_APP_API_URL,

        };
        
    },
    emits: [
        'close'
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
                        paymentsValues: this.paymentsValues
                    })

                    console.log(response_nfce.data)
                    break

                case 'saleNM':
                    console.log('Começou venda NM')
                    const response_nm = await axios.put(`${this.api}/ecommerce/pdv/finalize-sale/${this.pdvID}`, {
                        typeOperation: this.typeOperation,
                        paymentsValues: this.paymentsValues

                    })
                
                    console.log(response_nm.data)                    
                    break

                default:
                    console.log('Operation not defined',  this.typeOperation)
                    break;
                }
                
            } catch (error) {
                console.error('Error: ', error)
            }
            
        },

        calculeCredit(paymentsValues = [])
        {
            let total = 0;
            paymentsValues.forEach(values => {
                total += values;

            });

            let extraAmount = this.totalOperation - total;
            console.log('Valor do quarto: R$', this.totalOperation);
            console.log('Total pago: R$', total);
            if(total > this.totalOperation)
            {   
                console.log('Passou o valor do quarto: R$', this.totalOperation);
                let option = confirm(`Deseja gerar crédito no valor de: R$ ${extraAmount}?`);
                return option;
            } 
        },

        cancelOperation(){
            
            this.$emit("close")

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