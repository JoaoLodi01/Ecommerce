<template>
    <router-view></router-view>
</template>

<script>
    import { LocalStorage } from 'quasar';
    import { api } from './boot/axios';
    
    export default {
        methods: {
            async checkAuth(){      
                const token = LocalStorage.getItem("auth_token");
                if(token)
                {
                    const response = await api.get('/auth/me', {
                        headers: {
                            'Authorization': `Bearer ${token}`
                            
                        }
                    })
                    console.log('Response.data', response.data)
                    
                } 

                console.log('Token não encontrado')
            }

        },

        mounted(){
            this.checkAuth()
        }
    }

</script>