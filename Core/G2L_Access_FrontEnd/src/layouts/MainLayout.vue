<template>
    <div class="h-screen">
        <div 
            class="transition-transform duration-300 bg-[#2C363F] text-white text-base h-screen fixed top-0 left-0 z-40"
        >
            <div class="p-4">
                <div class="mb-12">
                    <span>Usuário logado</span>
                    <br>
                    <span>{{ LocalStorage.getItem("user") }}</span>
                </div>

                <div class="">
                    <span>Clientes</span>
                </div>
                
                <div class="">
                    <span>Recebimentos</span>
                </div>
            </div>  
        </div>
        <div class="ml-24">
            <router-view />

        </div>

    </div>
</template>

<script setup lang="ts">
    import { LocalStorage } from 'quasar';
import { ref } from 'vue';
    
    
    const leftDrawerOpen = ref(false);

    function toggleLeftDrawer () {
        leftDrawerOpen.value = !leftDrawerOpen.value;   
    }
</script>
