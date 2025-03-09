<template>
  <div class="bg-gray-700 text-white text-sm w-full">    
    <div class="flex justify-between p-2">
      <h1 class="ml-2">Bem vindo a sua área do Hotel!</h1>
      <div class="flex">
          <h3 class="ml-2"><button><a href="/user-area">Acesse sua conta</a></button></h3> 
          
          <h3 class="ml-2"><button><a href="/">Voltar</a></button></h3>
          
      </div>
    </div>

    <div class="m-2 pb-2">
      <h3 class="ml-2" v-if="isLoanding">Carregando...</h3>
      <h3 class="ml-2" v-if="!isLoanding">Contamos com um total de: {{ hotel.number_of_rooms }} quartos </h3>

    </div>
  </div>
  <!--REFAZER essa essa view-->
  <button><a href="/hotel/rooms">Conferir quartos</a></button>
</template>

<script>
  import axios from 'axios';
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
      

    },

    mounted(){
      this.getHotel()
    }
  }

</script>