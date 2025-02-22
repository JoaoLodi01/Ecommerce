<template>
    <div>
        <h1>Area do usuário</h1>
        <h3 class="ml-2"><button @click="showConfig">Configurações</button></h3> 
    </div>

    <div class="">
        <h3>
            Total de crédito disponível: R$ {{ 30 }}

        </h3>

        <h3>
            Limite de gastos no serviço de quarto: R$ {{ form.room_service_limit }}
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
                form: {
                    address_by_cep: false,
                    room_service_limit: 0,
                    partial_registration: false,

                    

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
                    
                    this.form = {
                        address_by_cep: !!config.address_by_cep,
                        room_service_limit: Number(config.room_service_limit),
                        partial_registration: !!config.partial_registration

                    }

                } catch (error) {
                    console.log('Erro no getConfig()', error)
                }
            },

            async getCustomerDetails()
            {
                try {
                    //const response 
                    
                } catch (error) {
                    
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