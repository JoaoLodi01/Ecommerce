<template>
    <div class="text-xl">
        <header class="bg-[#242D34] text-white flex shadow-2xl p-4">
            <h1 class="text-3xl font-bold mr-10 ml-4 flex items-center">Bem vindo!</h1>

            <div class="flex items-center p-5 space-x-10">
                <div class="space-x-10">
                    <span class="cursor-pointer hover:text-gray-300">Funcionalidades</span>
                        
                    <span class="cursor-pointer hover:text-gray-300">Fale conosco</span>
                </div>

                <div class="flex space-x-10">
                    <router-link class="cursor-pointer hover:text-gray-300" to="/login">Entrar</router-link>

                    <router-link class="cursor-pointer hover:text-gray-300" to="/register-owner">Criar conta</router-link>
                </div>
            </div>
        </header>
    </div>
</template>

<script setup lang="ts">
    import { LocalStorage } from 'quasar';
    import { ref } from 'vue';

    const token = ref(LocalStorage.getItem("auth_token"));
    
    
</script>