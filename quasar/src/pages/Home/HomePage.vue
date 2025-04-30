<template>
    <div class="text-xl">
        <header class="bg-slate-600 text-white flex shadow-2xl">

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