<template>
  <router-view></router-view>
  
</template>

<script>  
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
          //const response = await.post(`${this.api}/get-ip`);
        } catch (error) {
          
        }
      }
    },
    mounted(){ 

    }
  }
</script>
