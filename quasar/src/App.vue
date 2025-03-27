<template>
    <Sidebar/>
</template>

<script>
    import { LocalStorage } from 'quasar';
    import { api } from './boot/axios';
    import Sidebar from './components/Sidebar.vue';
    
    export default {
        components: {
            Sidebar
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
                        
                        console.log('Response.data App.vue', response.data)
                        
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
            this.checkAuth()
        }
    }

</script>