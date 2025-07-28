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
                    <span @click="login" class="cursor-pointer hover:text-gray-300">Entrar</span>

                </div>
            </div>
        </header>
    </div>
</template>

<script setup lang="ts">
    import { LocalStorage } from 'quasar';
    import { ref } from 'vue';
    import { useRouter } from 'vue-router';

    const token = ref<string>(LocalStorage.getItem("auth_token"));
    const expireStr = ref(LocalStorage.getItem("expire"));
    const router = useRouter();

    const login = async () =>
    {
        if(token.value && expireStr.value)
        {
            router.replace({
                name: 'Companies'
            });
        } else {
            router.replace({
                name: 'Login'
            });

        };
            
    };
    
</script>