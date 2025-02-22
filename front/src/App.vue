<template>
  <router-link to="/"></router-link>
  <router-view></router-view>
  
</template>

<script>
  import axios from 'axios';

  
  export default {
    data(){
      return {
        api: process.env.VUE_APP_API_URL,
      }
    },
    methods: {
      async getIP()
      {      
        try {
          const response = await axios.get(`${this.api}/get-ip`);

          console.log('Aqui', response)
          
        } catch (error) {
          console.error('Erro no getIP', this.api)
          
        }
      }
    },
    mounted(){ 
      this.getIP()
    }
  }
</script>
