<template>
    <div v-if="loged">
        <HomePage />
        
    </div>

    <div v-if="!loged">
        <span>loged: {{ loged }}</span>
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
                loged: false,
                
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
                        this.loged = LocalStorage.getItem("loged")
                        
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
            
            if(this.widthScreen <= 1080)
            {   
                this.sidebarActive = false   
            }
            this.checkAuth()
        }
    }

</script>

<style>

    
</style>