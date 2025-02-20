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
                api: process.env.VUE_APP_API_URL
            }
        },
        components: {
            PaymentsForm

        },
        methods: {
            async getRooms() {
                try {
                    const response = await axios.get(`${this.api}/hotel/stay/rooms`)
                    console.log(response.data.all ? response.data.all : response.data)
                    this.rooms = response.data.all
                    
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