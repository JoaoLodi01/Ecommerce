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
        const response = await axios.get(`${this.api}/get-ip`);
      }
    },
    mounted(){ 
      this.getIP()
    }
  }
</script>
