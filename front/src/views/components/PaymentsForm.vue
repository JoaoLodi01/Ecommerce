<template>
    <div class="payments-container bg-slate-600">
        <h1>Formas de Pagamento</h1>

        <form @submit.prevent="finalizeSale">
            <table class="border border-red-500"">
                <thead>
                    <tr>
                        <th>Formas de pagamento</th>
                        <th>Valores</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(payment, index) in payments" :key="payment.id">
                        <td>{{ payment.descricao }}</td>
                        <td>
                            <input
                                type="number"
                                v-model="paymentsValues[index]"
                                @input="getValues(payment.id)"
                                placeholder="0.00"
                                step="0.01"
                            />
                        </td>
                    </tr>
                </tbody>
            </table>

            <button type="submit">Emitir Venda</button>
        </form>
    </div>
</template>

<script>
import axios from 'axios';

export default {
    data(){
        return {
            payments: [],
            paymentsValues: [],
            valorVenda: 0,
            valorPago: 0,
            api: process.env.VUE_APP_API_URL,

        };
    },

    props: {
        show: {
            type: Boolean,
        },

        typeOperation: {
            type: String,
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
        
        async getValues(id){
            //this.valorPago += this.paymentsValues;
            const response = await axios.post(`${this.api}/hotel/stay/reservation`, this.paymentsValues);
            console.log('Total pago', response)

        },  
        async finalizeSale() {
            console.log('ID forma pagamento:')    
            
        }
    },
    mounted(){
        this.getPayments();
        
    },
}
</script>
