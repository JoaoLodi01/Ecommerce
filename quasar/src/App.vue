<template>
    <Sidebar
        @isActive="isActive = $event"
    />
    <div class="relative flex" v-if="loged" :class="{
        'top-10 right-14': widthScreen <= 1080,
        'ml-12 mr-4': widthScreen <= 1080,
        'ml-60': widthScreen > 1080,
        
    }">

     <router-view />
        
    </div>
        
    <div>
        
        <Login
            v-if="!loged"
        />
  
    </div>
  </template>
  

<script>
    import { LocalStorage } from 'quasar';
    import { api } from './boot/axios';
    import Sidebar from './components/Sidebar.vue';
    import Login from './pages/Login/Login.vue';
    
    export default {
        data(){
            return {
                loged: false,
                sidebarActive: false,
                widthScreen: 0
            }
        },

        components: {
            Sidebar,
            Login
        },
       
        methods: {
            async checkAuth(){      
                try {
                    const token = LocalStorage.getItem("auth_token");
                    if(token)
                    {
                        const response = await api.get('/auth/me', {
                            headers: {
                                'Authorization': `Bearer ${token}`
                                
                            }
                        })
                        this.loged = true         
                        
                    } else {
                        console.log('Token não encontrado')
                        LocalStorage.remove("auth_token")
                        this.$router.push('/login')

                    }
                    
                } catch (error) {
                    console.error('Erro no checkAuth App.vue', error.response)
                    if(error.response.status)
                    {
                        LocalStorage.remove("auth_token")
                    }   
                }
            }

        },

        mounted(){
            this.widthScreen += screen.width
            console.log('isActive', this.isActive)
            if(this.widthScreen <= 1080)
            {   
                this.sidebarActive = false   
            }
            this.checkAuth()
        }
    }

</script>

