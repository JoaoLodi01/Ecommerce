<template>
    <header class="">
        <h2>Todos os quartos</h2>

    </header>
    <div>
        <div>

        </div>
        <button @click="showPayMent">Reservar</button>
    </div>

    <PaymentsForm
        v-if="show"
        :show="this.show"
    />
</template>

<script>
import PaymentsForm from '@/views/components/PaymentsForm.vue';
import axios from 'axios';

    export default {
        data(){
            return {
                rooms: [],
                show: false,
                api: process.env.VUE_APP_API_URL_HOTEL
            }
        },
        components: {
            PaymentsForm

        },
        methods: {
            async getRooms() {
                try {
                    const response = await axios.get(`${this.api}/stay/rooms`)
                    console.log(response.data.all)
                    
                } catch (error) {
                    console.error('Erro no getRooms', error)   

                }
            },

            showPayMent(){
                this.show = !this.show

            }
        },

        mounted() {
            this.getRooms()

        }
    }
</script>