<template>
    <header class="">
        <h2>Todos os quartos</h2>
        <button><a href="/hotel">Voltar</a></button>

    </header>
    
    <div>
        <div v-for="(room, id) in rooms" :key="id">
            <div v-if="showRooms">
                Preço por noite: {{ room.price_for_night }} |
                Capacidade do quarto: {{ room.capacity }} | 
                Número do quarto: {{ room.number_room }} |
                <button @click="showPayMent(id)">Reservar</button>
            </div>
        </div>
    </div>

    <PaymentsForm
        v-if="show"
        :show="this.show"
        :type-operation="'reservation'"
        :idRoom="idRoom"
        
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
                showRooms: true,
                idRoom: null,
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

            showPayMent(id){
                this.idRoom = id + 1
                this.show = !this.show
                this.showRooms = false

            }
        },

        mounted() {
            this.getRooms()

        }
    }
</script>