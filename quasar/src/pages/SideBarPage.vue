<template>
    <Sidebar
        @toggleSidebar="sidebarActiveWatch($event)"  
    />

    <div class="flex transition" id="q-app" :class="{
        'top-10 left-0': widthScreen <= 1080,
        'ml-52': widthScreen > 1080,
        'mr-44': widthScreen > 1080 && widthScreen < 1600,
        'transform -translate-x-24': !sidebarActive && widthScreen > 1080,
        
    }">   
        <router-view></router-view>
      
    </div>
    
</template>

<script>
    import Sidebar from 'src/components/Sidebar.vue';

    export default {
        data()
        {
            return {
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
                         
        },
        mounted(){
            this.widthScreen += screen.width
            
            if(this.$route.path === '/login')
            {
                this.$router.push('/')
                
            }
        }
    }

</script>