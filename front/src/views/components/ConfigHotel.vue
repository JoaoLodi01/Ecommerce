<template>
    <div>
        <h1>Config Hotel</h1>
        <form @submit.prevent="saveConfig">
            <label for="address_by_cep">Endereço pelo CEP</label>
            <input
                type="checkbox" 
                name="address_by_cep"
                id="address_by_cep"
                v-model="this.form.address_by_cep"
            />

            <label for="room_service_limit">Limites de serviço de quarto R$ </label>
            <input
                type="number" 
                name="room_service_limit"
                id="room_service_limit"
                v-model="this.form.room_service_limit"
            />


            <label for="partial_registration">Registros parciais</label>
            <input
                type="checkbox" 
                name="partial_registration"
                id="partial_registration"
                v-model="this.form.partial_registration"
            />

            <button type="submit">Salvar</button>
        </form>
        
    </div>
</template>

<script>
    import axios from 'axios';
    import { toRaw } from 'vue';
    
    export default {
        name: "ConfigHotel",
        data(){
            return{
                form: {
                    address_by_cep: false,
                    room_service_limit: 0,
                    partial_registration: false,

                },
                configs: [],
                api_Hotel: process.env.VUE_APP_API_URL_HOTEL
            }
        },
        methods: {
            async saveConfig(){
                const form = new FormData;
                const rawForm = toRaw(this.form)

                form.append("address_by_cep", this.form.address_by_cep)
                form.append("room_service_limit", this.form.room_service_limit)
                form.append("partial_registration", this.form.partial_registration)
              
                const response = await axios.put(`${this.api_Hotel}/config-hotel/set-config`, rawForm)

                console.log(response)

                if(response.data.success === true)
                {
                    alert('Configurações gravadas com sucesso!')
                    this.$router.push('/hotel')
                }
            }
        },

        props: {
            show: {
                type: Boolean,
                required: true
            }
        }

    }
</script>