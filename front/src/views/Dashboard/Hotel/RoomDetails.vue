<template>
    <header class="bg-gray-700 text-white text-sm">    
        <div class="flex justify-between p-2">
            <h2>Todos os quartos</h2>
            <button><a href="/hotel">Voltar</a></button>
        </div>
    
    </header>
    
    <div  
        class="flex flex-grow m-2  rounded-lg"
        v-if="showRooms"
    >
        <div
            v-for="(room, id) in rooms" 
            :key="id"
            class=" bg-slate-800 text-white p-4"
        >
            <div
                
                class="text-center"
            >
                Preço por noite: R$ {{ room.price_for_night }}
                Capacidade do quarto: {{ room.capacity }} 
                Número do quarto: {{ room.number_room }} 
                Status do quarto: {{ room.reserved ? 'Quarto reservado.' : 'Quarto disponível' }}
                <div v-if="room.reserved">
                </div>
                <div v-else>
                    <button 
                        @click="showPayMent(room.id, room.price_for_night)"
                        class="bg-indigo-700 text-white rounded-lg p-1 hover:bg-indigo-500"
                    >
                        Reservar
                    </button>
                </div>
            </div>
        </div>
    </div>

    <PaymentsForm
        v-if="show"
        :show="show"
        type-operation="reservation"
        :idRoom="idRoom"
        :totalOperation="totalOperation"
        @close="cancelOperation"
        
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
                totalOperation: 0,
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
                    this.rooms = response.data.all
                    
                } catch (error) {
                    console.error('Erro no getRooms', error)   

                }
            },

            async showPayMent(id, price_for_night){
                try {
                    const response = await axios.post(`${this.api}/hotel/stay/reservation`, {
                        paymentsValues: 0,
                        room_id: 0,
                        customer_id: 2

                    });
                    
                    console.log(response)
                    this.idRoom = id + 1
                    this.totalOperation = price_for_night
                    this.show = !this.show
                    this.showRooms = false

                } catch (error) {
                    alert(error.response.data.message ?? error.response.data)
                    
                } 
            },
            cancelOperation(){
                this.show = false;
                this.showRooms = true;

            },
            notifiyRoomReserved(){
                alert('Esse quarto já está ocupado')
            }
        },

        mounted() {
            this.getRooms()

        }
    }
</script>