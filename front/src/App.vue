<template>
  <div class="absolute top-1">
    <Sidebar />
  </div>

  <div class="relative ml-56">
    <router-view></router-view>
  </div>
</template>

<script>
import axios from 'axios';
import Sidebar from './views/components/Sidebar.vue';

  
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
      
    },

    components: {
      Sidebar,
  },
  }
</script>
