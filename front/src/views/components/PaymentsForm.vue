<template>
    <div class="payments-container">
        <h1>Formas de Pagamento</h1>

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
            required: true
            
        },

        typeOperation: {
            type: String,
            required: true
    
        },
        idRoom: {  
            type: Number
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
        
        getValues(id){
            console.log(`ID da forma de pagamento ${id}, valor pago: R$ ${this.paymentsValues}`)
            console.log('Total pago', this.valorPago)

            for (let i = 0; i < this.paymentsValues.length; i++) {
                const element = this.paymentsValues[i];
                return element

            }
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
