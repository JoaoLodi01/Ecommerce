<template>
    <div v-if="loged">
        <HomePage />
        
    </div>

    <div v-if="!loged" class="mt-20">
        <Login />
    </div>
</template>

<script>
    import { LocalStorage } from 'quasar';
    import { api } from './boot/axios';
    import HomePage from './pages/SideBarPage.vue';
    import Login from './pages/Login/Login.vue';
    
    export default {
        data(){
            return {
                loged: LocalStorage.getItem("loged")
                
            }
        },

        components: {
            HomePage,
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
                        
                        LocalStorage.setItem("loged", true)
                        LocalStorage.setItem("user_name", response.data.user.name)
                    
                    } else {
                        
                        LocalStorage.remove("auth_token")
                        LocalStorage.setItem("loged", false)
                        
                        this.$router.push('/start')

                    }
                    
                } catch (error) {
                    console.error('Erro no checkAuth App.vue', error)
                    
                    if(error.response.status)
                    {
                        LocalStorage.remove("auth_token")
                    }   
                }
            }

        },

        mounted(){
            this.widthScreen += screen.width
            
            if(this.widthScreen <= 1080)
            {   
                this.sidebarActive = false   
            }
            this.checkAuth()
        }
    }

</script>