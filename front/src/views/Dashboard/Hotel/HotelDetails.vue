<template>
  <header class="bg-gray-700 text-white text-sm">    
    <div class="flex justify-between p-2">
      <h1 class="ml-2">Bem vindo a sua área do Hotel!</h1>
      <div class="flex">
          <h3 class="ml-2">Acesse sua conta</h3> 
          <h3 class="ml-2"><button @click="showConfig">Configurações</button></h3> 
          <h3 class="ml-2"><button><a href="/">Voltar</a></button></h3>
          
      </div>
    </div>

    <div class="m-2 pb-2">
      <h3 class="ml-2" v-if="isLoanding">Carregando...</h3>
      <h3 class="ml-2" v-if="!isLoanding">Contamos com um total de: {{ hotel.number_of_rooms }} quartos </h3>

    </div>
  </header>

  <button><a href="/hotel/rooms">Conferir quartos</a></button>
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
        api: process.env.VUE_APP_API_URL,
        show: false,
        isLoanding: true,

      }
    },

    methods: {
      async getHotel(){
        try {
          const response = await axios.get(`${this.api}/hotel/all`)
          if(response.data.success === true)
          {
            this.hotel = response.data.all.hotel
            this.isLoanding = false
            
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
      this.getHotel()
    }
  }

</script>