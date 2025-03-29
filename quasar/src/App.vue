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
                    console.log('Puxou aqui 36, this.loged:', this.loged)
                    const token = LocalStorage.getItem("auth_token");
                    console.log(token)
                    console.log(LocalStorage.getItem("auth_token") !== null || '' ? LocalStorage.getItem("loged") : false)
                    if(token)
                    {
                        console.log('Puxou aqui 42')
                        const response = await api.get('/auth/me', {
                            headers: {
                                'Authorization': `Bearer ${token}`
                                
                            }
                        })
                        
                        LocalStorage.setItem("loged", true)
                        
                    } else {
                        console.log('Puxou aqui 51')
                        console.log('Token não encontrado')
                        LocalStorage.remove("auth_token")
                        this.$router.push('/start')

                    }
                    
                } catch (error) {
                    console.log('Puxou aqui 60')
                    console.error('Erro no checkAuth App.vue', error.response.data || error)
                    
                    if(error.response.status)
                    {
                        LocalStorage.remove("auth_token")
                    }   
                }
            }

        },

        mounted(){
            console.log('Puxou aqui 73, this.loged:', this.loged)
            this.widthScreen += screen.width
            console.log(this.loged, ' token', LocalStorage.getItem("auth_token"))
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