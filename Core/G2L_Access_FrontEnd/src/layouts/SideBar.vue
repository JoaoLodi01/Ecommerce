<template>
    <div class="h-screen">
        <div 
            :class="{
                'bg-[#2b91ff] text-white text-base h-screen fixed top-0 left-0 w-36': openSideBar,
                '': !openSideBar,
            }"
        >
            <div class="p-4">
                <div 
                    class="mb-4 cursor-pointer p-2" 
                    @click="toggleLeftDrawer"
                >
                    <div 
                        class="border w-6 mb-1"
                        :class="{
                            'border-white': openSideBar,
                            'border-black': !openSideBar,
                        }"
                    ></div>

                    <div 
                        class="border w-6 mb-1"
                        :class="{
                            'border-white': openSideBar,
                            'border-black': !openSideBar,
                        }"
                    ></div>

                    <div 
                        class="border w-6 mb-1"
                        :class="{
                            'border-white': openSideBar,
                            'border-black': !openSideBar,
                        }"
                    ></div>
                </div>

                <div v-if="openSideBar">
                    <div class="mb-12">
                        <span>Usuário logado</span>
                        <br>
                        <span>{{ LocalStorage.getItem("user") }}</span>
                    </div>

                    <div class="border-b mb-4">
                        <router-link to="/home/customers">Clientes</router-link>
                    </div>
                    
                    <div class="border-b">
                        <router-link to="/home/receive">Recebimentos</router-link>
                        
                    </div>
                </div>
            </div>  
        </div>

        <div 
            :class="{
                'ml-24': openSideBar,
                'mr-12': !openSideBar,
            }"
        >
            <router-view />

        </div>
    </div>
</template>

<script setup lang="ts">
    import { LocalStorage } from 'quasar';
    import { ref } from 'vue';
    
    let openSideBar = ref<boolean>(true);

    const toggleLeftDrawer = () =>
    {
        openSideBar.value = !openSideBar.value;   
    };
</script>
