<template>
    <Sidebar
        @toggleSidebar="sidebarActiveWatch($event)"  
    />

    <div class="flex transition" id="q-app" :class="{
        'top-10 right-10': widthScreen <= 1080,
        'ml-52': widthScreen > 1080,
        'mr-44': widthScreen > 1080 && widthScreen < 1600,
        'transform -translate-x-24': !sidebarActive
        
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
                sidebarActive: true,
                widthScreen: 0
            }

        },
        components: {
            Sidebar
        },

        methods: {
            sidebarActiveWatch(event)
            {
                this.sidebarActive = event

            },
            
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
          
               
        },
        mounted(){
            this.widthScreen += screen.width
            
        }
    }

</script>