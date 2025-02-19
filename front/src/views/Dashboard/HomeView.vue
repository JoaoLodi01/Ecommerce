<template>
  <h1>Página inicial</h1>
  <a href="/hotel">Hotel</a><br>
  <a href="/nfce">NFC-e</a>
</template>

<script>
  import axios from 'axios';

  
  export default {
    data(){
      return {
        api: process.env.VUE_APP_API_URL_HOTEL
        
      }
    },
    methods: {
      async getIP()
      {
        try {
          const response = await axios.get(`${this.api}/get-ip`);

          console.log(response)
        } catch (error) {
          console.error('Erro no getIP', error)
          
        }
      }
    },
    mounted(){ 
      this.getIP()
    }
  }
</script>
