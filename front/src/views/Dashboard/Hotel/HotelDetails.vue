<template>
  <header class="bg-gray-700 text-white text-sm">    
    <div class="flex justify-between p-2">
      <h1 class="ml-2">Bem vindo a sua área do Hotel!</h1>
      <div class="flex">
          <h3 class="ml-2">Acesse sua conta</h3> 
          <h3 class="ml-2"><button @click="showConfig">Configurações</button></h3> 
      </div>
      
    </div>

    <div class="m-2 pb-2">
      <h3 class="ml-2">Contamos com um total de: {{ hotel.number_of_rooms || 0 }} quartos </h3>
    </div>
  </header>
  <Config
    v-if="show"
    @close="show = false"
    
  />
</template>

<script>
  import axios from 'axios';
  import Config from '@/views/components/Config.vue';

  export default {
    data(){
      return {
        hotel: {},
        api_hotel: process.env.VUE_APP_API_URL_HOTEL,
        show: false

      }
    },

    methods: {
      async getHotel(){
        try {
          const response = await axios.get(`${this.api_hotel}/hotel/all`)
          if(response.data.success === true)
          {
            this.hotel = response.data.all.hotel
            
          }

          if(response.data.success === false){
            console.log(response.data)

          }

        } catch (error) {
          if(error.response.data.message === 'Hotel não encontrado')
          {
            alert(error.response.data.message)
            alert('Por favor faça o cadastro do mesmo')
            this.$router.push('/hotel/create')

          }

          console.error('Erro ao carregar o hotel', error.response)
          console.error('rota', this.api_hotel)
 
        }
      },
      showConfig(){
        console.log('Abriu')
        this.show = true
      }
    },

    components: {
      Config
    },
    mounted(){
      this.getHotel()
    }
  }

</script>