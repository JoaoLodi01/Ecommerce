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

        async finalizeSale(id) {
            console.log('ID forma pagamento:', id)
            
            this.paymentsValues.forEach(value => {
                let valor = 0 
                valor += value
                return valor
            });
            /*try {
               const response = await axios.post(`${this.api}/nfce/create`)
            } catch (error) {
                
            }*/
        }
    }
}
</script>
<style>

table {
    width: 100%;
    border-collapse: collapse;
    margin: 20px 0;
    font-size: 16px;
    text-align: left;
}

th, td {
    padding: 10px;
    border: 1px solid #ddd;
}

th {
    background-color: #f4f4f4;
    font-weight: bold;
}

tr:nth-child(even) {
    background-color: #f9f9f9;
}

tr:hover {
    background-color: #f1f1f1;
}


</style>