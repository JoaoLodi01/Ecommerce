<template>
    <Sidebar
        @isActive="isActive = $event"
    />
    <div class="flex" v-if="loged" :class="{
        'top-10 right-14': widthScreen <= 1080,
        'ml-12 mr-4': widthScreen <= 1080,
        'ml-56': widthScreen > 1080,
        
    }">
        <router-view></router-view>
        
    </div>
    
</template>

<script>
    import { LocalStorage } from 'quasar';
    import { api } from 'src/boot/axios';
    import Sidebar from 'src/components/Sidebar.vue';

    export default {
        data()
        {
            return {
                loged: false,
                widthScreen: 0
            }

        },
        components: {
            Sidebar
        },

        methods: {
            async logout()
            {
                const token = LocalStorage.getItem("auth_token")
                console.log('token: ', token)
                try {
                    const response = await api.post('/auth/logout', {
                        headers: {
                            'Authorization': `Bearer ${token}`
                            
                        }
                    })

                    console.log('Response.logout', response)
                    if(response.data.success)
                    {
                        LocalStorage.remove("auth_token")
                        this.$router.push('/login')
                    }
                } catch (error) {
                    
                }
            },
            
            async checkAuth(){      
                try {
                    const logedLocal = LocalStorage.getItem("loged")
                    this.loged = logedLocal
                    const token = LocalStorage.getItem("auth_token");
                    if(token)
                    {
                        const response = await api.get('/auth/me', {
                            headers: {
                                'Authorization': `Bearer ${token}`
                                
                            }
                        })
                        
                    } else {
                        console.log('Token não encontrado')
                        LocalStorage.remove("auth_token")
                        this.$router.push('/')

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
            this.checkAuth()

        }
    }

</script>