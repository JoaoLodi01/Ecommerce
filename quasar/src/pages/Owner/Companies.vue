<template>
    <div class="text-center">
        <div class="head">
            <div class="">
                <router-link to="/" class="flex">   
                    <span class="mt-0.5 ml-2">Voltar</span>
                </router-link>
            </div>    
            <h1>Listagem das suas empresas</h1>
            
        </div>

        <div class="companies flex justify-center">
            <q-card class="w-80">
                <q-card-section>
                    <div class="text-h6 text-center">Adicionar uma nova empresa</div>
                </q-card-section>
                <q-card-section>
                    <div class="flex justify-center">
                        <svg 
                            xmlns="http://www.w3.org/2000/svg" 
                            fill="none" 
                            viewBox="0 0 24 24" 
                            stroke-width="1.5" 
                            stroke="currentColor" 
                            class="size-12"
                        >
                            <path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15" />
                        </svg>

                    </div>

                </q-card-section>
            </q-card>
        </div>
        
    </div>
</template>

<script>
import { LocalStorage } from 'quasar';

    export default {
        mounted()
        {
            console.log(`uuse_id: ${LocalStorage.getItem("uuse_id")} `)
        }
    }
</script> 