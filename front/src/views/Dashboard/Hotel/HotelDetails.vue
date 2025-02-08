<template>
  <header class=" bg-gray-700 text-white text-sm">
    
    <div class="flex justify-between items-center p-2">
      <h1 class="ml-2">Bem vindo a sua área do Hotel!</h1>
      <h3 class="ml-2">Acesse sua conta</h3> 
    
    </div>
    <div class="m-2 pb-2">
      <h3 class="ml-2">Contamos com um total de: {{ 30 }} quartos </h3>
    </div>
  </header>
</template>

<script>
  import axios from 'axios';

  export default {
    data(){
      return {
        api_hotel: process.env.VUE_APP_API_URL_HOTEL

      }
    },

    methods: {
      async getHotel(){
        try {
          const response = await axios.get(`${this.api_hotel}/hotel/all`)
          if(response.data.success === true)
          {
            console.log('Sucesso')
            console.log(response.data.all.hotel)
            
          }

          //console.log(response.data)

        } catch (error) {
          console.error('Erro ao carregar o hotel', error.response.data)
          alert(error.response.data.message)
          
          
        }

      }

    },

    mounted(){
      this.getHotel()
    }
  }

</script>