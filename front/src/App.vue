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
    
    },
    mounted(){ 
      const response = axios.get(`${this.api}/get-ip`);

    }
  }
</script>
