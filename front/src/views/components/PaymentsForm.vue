<template>
    <div class="payments-container bg-slate-600">
        <h1>Formas de Pagamento</h1>
        <div>
            <form @submit.prevent="finalizeSale">
                <table>
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

                <button type="submit"> {{ typeOperation === 'reservation' ? "Concluir Reserva" : "Finalizar Venda" }} </button>
                
            </form>
            <button @click="cancelOperation()">Cancelar</button>
            <h3>Total: R$ {{ totalOperation }}</h3>

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
        saleID: {
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
            try {
                switch (this.typeOperation) {
                case 'reservation':
                    const generateCredit = this.calculeCredit(this.paymentsValues);

                    this.isLoanding = !this.isLoanding
                    
                    const response = await axios.post(`${this.api}/hotel/stay/reservation`, {
                        customer_id: 1,
                        payments_values: this.paymentsValues,
                        roomID: this.roomID,
                        generateCredit: generateCredit
                    });

                    const reservation = response.data
                    
                    this.message = reservation.message ? reservation.message : reservation.errorMessage
                
                    break;

                case 'saleNFCe':
                    //const response = await axios.put(`${this.api}/ecommerce/pdv/finalize-sale/`)
                    console.log('Começou venda NFCe')
                    break

                case 'saleNM':
                    console.log('Começou venda NM')
                    break

                default:
                    console.log('Operation not defined',  this.typeOperation)
                    break;
                }
                
            } catch (error) {
                
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