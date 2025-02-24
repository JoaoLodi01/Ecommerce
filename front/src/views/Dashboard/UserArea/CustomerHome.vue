<template>
    <div>
        <h1>Area do usuário</h1>
        <h3 class="ml-2"><button @click="showConfig">Configurações</button></h3> 
    </div>

    <div class="">
        <h3>
            Total de crédito disponível: R$ {{ customer.current_credit }}
            Validade: {{ customer.validate }}
        </h3>

        <h3>
            Limite de gastos no serviço de quarto: R$ {{ configs.room_service_limit }}
        </h3>
    </div>

    <Config
        v-if="show"
        @close="show = false"
    
    />

    <h3 class="ml-2"><button><a href="/hotel">Voltar</a></button></h3>
</template>

<script>
    import Config from '@/views/components/Config.vue';
    import axios from 'axios';

    export default {

        data(){
            return {
                configs: {
                    address_by_cep: false,
                    room_service_limit: 0,
                    partial_registration: false

                },
                customer: {
                    current_credit: 0,
                    validate: null,  
                },
                api: process.env.VUE_APP_API_URL,
                show: false
            }
        },

        methods: {
            async getConfig(){
                try {
                    const response = await axios.get(`${this.api}/config/config-hotel/get-config`);
                    const config = response.data.config
                    
                    config.forEach(element => {
                        this.configs = {
                            address_by_cep: !!element.address_by_cep,
                            room_service_limit: Number(element.room_service_limit),
                            partial_registration: !!element.partial_registration

                        }

                    });
                    
                } catch (error) {
                    console.error('Erro no getConfig()', error)
                }
            },

            async getCustomerDetails()
            {
                try {
                    const response = await axios.get(`${this.api}/customers/1`);
                    const credit = response.data.customer.join_credit
                    credit.forEach(element => {
                        this.customer = {
                            current_credit: Number(element.current_credit),
                            validate: Date(element.validate)
                        }
                    })
                    
                } catch (error) {
                    console.error('Erro no getCustomerDetails', error)
                    
                }
            },

            showConfig(){
                this.show = true

            }

        },
        
        components: {
            Config
        },

        mounted(){
            this.getConfig()
            this.getCustomerDetails()

        }
    }
</script>