<template>
    <button><a href="/login">Login</a></button>
    <button @click="logout">Sair</button>
    
</template>

<script>
    import { LocalStorage } from 'quasar';
import { api } from 'src/boot/axios';
    import Sidebar from 'src/components/Sidebar.vue';

    export default {
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
            }
        }
    }

</script>