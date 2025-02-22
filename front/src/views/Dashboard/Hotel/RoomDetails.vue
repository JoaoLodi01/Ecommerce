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
                <div v-if="!reserved">
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
        :room_id="room_id"
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
                room_id: null,
                totalOperation: 0,
                reserved: null,
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

            async checkReserved(){
                const response = await axios.post(`${this.api}/hotel/stay/check-reservation`, {
                    customer_id: 2
                });

                if(response.data.customer !== null)
                {
                    alert('Vaga ativa')
                    this.reserved = true
                }
            },

            showPayMent(room_id, price_for_night){
                this.room_id = room_id
                this.totalOperation = price_for_night
                this.show = !this.show
                this.showRooms = false

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
            this.checkReserved()

        }
    }
</script>