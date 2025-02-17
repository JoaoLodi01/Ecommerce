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
                                @input="finalizeSale(payment.id)"
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
            api: process.env.VUE_APP_API_URL_ECOMMERCE,
        };
    },

    props: {
        show: {
            type: Boolean,
            required: true
            
        },
        total: {
            type: Number,
            required: true

        }
    },
    
    methods: {
        async getPayments() {
            try {
                const response = await axios.get(`http://192.168.98.32:8001/api/payments/all`);
                this.payments = response.data;
            } catch (error) {

            }
        },

        async finalizeSale(id) {
            console.log('ID forma pagamento:', id)
            
            for (let index = 0; index < this.paymentsValues.length; index++) {
                const element = this.paymentsValues[index];
                console.log(element)
            }
            
        }
    },
    mounted(){
        this.getPayments();
    },
}
</script>
