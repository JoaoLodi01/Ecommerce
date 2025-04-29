<template>
    <div class="text-xl">
        <header class="bg-slate-600 text-white mb-5 flex shadow-2xl">
            <h1 class="ml-5">Bem vindo</h1>
            <div class="ml-20 mb-auto mt-auto">
                <span class="mr-10 cursor-pointer hover:text-gray-300">Funcionalidades</span>
                
                <span class="mr-10 cursor-pointer hover:text-gray-300">Fale conosco</span>

            </div>

            <div class="flex border border-black mb-auto mt-auto">
                <div class="mr-5">
                    <router-link class="cursor-pointer hover:text-gray-300" to="/login">Entrar</router-link>

                </div>
                
                <div>
                    <router-link class="cursor-pointer hover:text-gray-300" to="/register-owner">Criar conta</router-link>
                </div>
            </div>
        </header>
    </div>
</template>