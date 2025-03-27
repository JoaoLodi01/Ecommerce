<template>
    <div class="bg-slate-600 text-white rounded-lg m-auto p-2 w-2/6">
        <h1 class="text-center">Configurações do Hotel</h1>
        <form @submit.prevent="saveConfig()" class="">
            <label for="address_by_cep">Endereço pelo CEP</label>
            <input
                class="ml-1"
                type="checkbox" 
                name="address_by_cep"
                id="address_by_cep"
                v-model="this.form.address_by_cep"

            />

            <br>

            <label for="room_service_limit">Valor limite para serviço de quarto R$ </label>
            <input
                class="border border-l-teal-100 rounded-sm w-20 text-black"
                type="text" 
                name="room_service_limit"
                id="room_service_limit"
                v-model.number="this.form.room_service_limit"
            />

            <br>

            <label for="partial_registration">Registros parciais</label>
            <input
                class="ml-1"
                type="checkbox" 
                name="partial_registration"
                id="partial_registration"
                v-model="this.form.partial_registration"
            />

            <br>

            <button type="submit">Salvar</button>
            <button class="ml-5" @click="closeModal()">Fechar</button>
        </form>
        
    </div>
</template>

<script>
    import axios from 'axios';
    
    export default {
        name: "Config",
        data(){
            return{
                form: {
                    address_by_cep: false,
                    room_service_limit: 0,
                    partial_registration: false,

                },
                api: process.env.VUE_APP_API_URL
            }
        },
        
        methods: {
            async getConfig(){
                try {
                    const response = await axios.get(`${this.api}/config/config-hotel/get-config`);
                    const config = response.data.config
    
                    config.forEach(element => {
                        this.form = {
                            address_by_cep: !!element.address_by_cep,
                            room_service_limit: Number(element.room_service_limit),
                            partial_registration: !!element.partial_registration

                        }

                    });

                } catch (error) {
                    console.log('Erro no getConfig()', error)
                }
            },

            async saveConfig(){
                try {
                    const configs = {
                        address_by_cep: this.form.address_by_cep ? 1 : 0,
                        room_service_limit: Number(this.form.room_service_limit),
                        partial_registration: this.form.partial_registration ? 1 : 0,

                    };
                
                    const response = await axios.put(`${this.api}/config/config-hotel/set-config`, configs)

                    console.log(response)

                    if(response.data.success === true)
                    {
                        alert('Configurações gravadas com sucesso!')
                        this.$emit("close")
                    }
                    
                } catch (error) {
                    console.error('Erro no saveConfig()', error)
                }
                
            },
            closeModal(){
                this.$emit("close")
            }
            
        },

        mounted(){
            this.getConfig()
            
        }
    }
</script>