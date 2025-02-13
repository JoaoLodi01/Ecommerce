<template>
    <div class="payments-container">
        <h1>Formas de Pagamento</h1>

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
                    <td><input
                        type="number"
                        v-model="paymentValues[index]"
                        placeholder="0.00"/>
                    </td>
                </tr>
            </tbody>
        </table>

        <button @click="finalizeSale">Emitir Venda</button>
    </div>
</template>

<script>
import axios from 'axios';

export default {
    data(){
        return {
            payments: [],
            paymentsValues: [],
        };
    },
    mounted(){
        this.getPayments();
    },
    methods: {
        async getPayments() {
            try {
                const response = await axios.get(`${this.api}/payments/all`);
                this.payments = response.data;
            } catch (error) {

            }
        },

        async finalizeSale() {
            try {
               const response = await axios.post(`${this.api}/nfce/create`)
            } catch (error) {
                
            }
        }
    }
}
</script>