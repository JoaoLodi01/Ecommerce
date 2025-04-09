<template>
    <div v-if="loged">
        <HomePage />
        
    </div>

    <div v-if="!loged" class="mt-48">
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
                        console.log('Falo que n ta deslogado aqui')
                        LocalStorage.remove("auth_token")
                        LocalStorage.setItem("loged", false) 
                        if(this.$route.name !== 'ForgotPassowrd')
                        {
                            this.$router.push('/start')
                        }

                    }
                    
                } catch (error) {
                    console.error('Erro no checkAuth App.vue', error.status)
                    
                    if(error.response.status === 401)           
                    {
                        LocalStorage.remove("auth_token")
                        this.$router.push('/start')
                        window.location.reload()
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