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
                                    step="0.01"
                                />
                            </td>
                        </tr>
                    </tbody>
                </table>

<<<<<<< HEAD
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
                                placeholder="0.00"
                                step="0.01"
                            />
                        </td>
                    </tr>
                </tbody>
            </table>
=======
                <button type="submit"> {{ typeOperation === 'reservation' ? "Concluir Reserva" : "Emitir Venda" }} </button>
                
            </form>
            <button @click="cancelOperation()">Cancelar</button>
            <h3>Total: R$ {{ totalOperation }}</h3>
>>>>>>> 802d3bb03fc86b4e442dcac5d0aa85d99a734f11

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
    emits: ['close'],
    props: {
        show: {
            type: Boolean,
        },

        typeOperation: {
            type: String,
            required: true
    
        },
        room_id: {
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
                console.log(response.data)
                this.payments = response.data;
                
            } catch (error) {
                console.error('Erro no getPayments', error)
                
            }
        },
        
        async finalizeSale() {
            this.isLoanding = true
            switch (this.typeOperation) {
                case 'reservation':
                    console.log('Começou reserva')
                    console.log('Dados de envio', {
                        customer_id: 1,
                        payments_values: this.paymentsValues,
                        room_id: this.room_id,
                        
                    })

                    const response = await axios.post(`${this.api}/hotel/stay/reservation`, {
                        customer_id: 1,
                        payments_values: this.paymentsValues,
                        room_id: this.room_id

                    });

                    this.message = response.data.message ? response.data.message : response.data.errorMessage
                    
                    this.isLoanding = !this.isLoanding

                    const reservation = response.data
                    if(reservation.bigger === true)
                    {
                        this.bigger = true
                        this.extraAmount = reservation.extraAmount
                    }

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

        generateCredit(option, extraAmount)
        {
            console.log(`Deseja gerar crédito no valor de: R$ ${extraAmount}?`, option)
            if(option === true && extraAmount )
            {
                console.log('Quis');   
            } 
            
            if(option === false && !extraAmount) {
                console.log('Não quis');
                this.closeOperation()
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