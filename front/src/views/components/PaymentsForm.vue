<template>
    <div class="payments-container">
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
                            <td>{{ payment.descricao }}</td>
                            <td>
                                <input
                                    type="number"
                                    v-model="paymentsValues[index]"
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
        
        async finalizeSale() {
            switch (this.typeOperation) {
                case 'reservation':
                    console.log('Começou reserva')
                    const response = await axios.post(`${this.api}/hotel/stay/reservation`, {
                        paymentsValues: this.paymentsValues,
                        roomID: this.idRoom

                    });
                    
                    console.log('Retorno response', response)

                    break;
            
                case 'saleNFCe':
                    console.log('Começou venda NFCe')
                    break

                case 'saleNFCe':
                    console.log('Começou venda NM')
                    break
                default:
                    console.log('Operation not defined')
                    break;
            }
            
        }
    },
    mounted(){
        console.log('Quarto reservado', this.idRoom)
        this.getPayments();
        
    },
}
</script>
