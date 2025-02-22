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

                <button type="submit"> {{ typeOperation === 'reservation' ? "Concluir Reserva" : "Emitir Venda" }} </button>
                
            </form>
            <button @click="cancelOperation()">Cancelar</button>
            <h3>Total: R$ {{ totalOperation }}</h3>

            <div class="" v-if="isLoanding">
                <h2>Carregando...</h2>
            </div>    

            <div class="" v-if="errorMessage">
                {{ errorMessage.message }} <br>
                Valor pago: R$ {{ errorMessage.amount_paid }} <br>
                Total faltante: R$ {{ errorMessage.remaining }}

            </div>
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
            errorMessage: null,
            isLoanding: false,
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
            this.errorMessage = null
            switch (this.typeOperation) {
                case 'reservation':
                    console.log('Começou reserva')
                    const response = await axios.post(`${this.api}/hotel/stay/reservation`, {
                        paymentsValues: this.paymentsValues,
                        roomID: this.idRoom

                    });
                    this.errorMessage = response.data
                    this.isLoanding = !this.isLoanding
                    console.log('Retorno response', response)

                    break;
            
                case 'saleNFCe':
                    console.log('Começou venda NFCe')
                    break

                case 'saleNM':
                    console.log('Começou venda NM')
                    break

                default:
                    console.log('Operation not defined',  this.typeOperation)
                    break;
            }
            
        },
        cancelOperation(){
            this.$emit("close")

        }
    },
    mounted(){
        this.getPayments();
        
    },
}
</script>
