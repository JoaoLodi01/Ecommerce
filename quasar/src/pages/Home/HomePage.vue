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
                    <span class="cursor-pointer hover:text-gray-300" @click="login()">Entrar</span>

                    <router-link class="cursor-pointer hover:text-gray-300" to="/register-owner">Criar conta</router-link>
                </div>
            </div>
        </header>
    </div>
</template>

<script setup>
    import { LocalStorage } from 'quasar';
    import { api } from 'src/boot/axios';
    import { ref } from 'vue';

    const token = ref(LocalStorage.getItem("auth_token"));
    
    const login = async () => {
        try {
            const res = await api.get('/auth/me', {
                headers: {
                    'Authorization': `Bearer ${token.value}`

                }
            })

            res.data.success == true ? location = '/companies' : alert(res.data);

        } catch (error) {
            console.error('Erro:', error.response);
            location = '/login';
            
        }
    }
</script>