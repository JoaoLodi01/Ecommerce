<template>
    <div 
        class="error-container relative bg-yellow-400 text-white p-5 text-center rounded-lg transition-transform translate-y-4"

    >
        <div 
            class="flex justify-center"
            
        >
            <svg 
                xmlns="http://www.w3.org/2000/svg" 
                fill="none" 
                viewBox="0 0 24 24" 
                stroke-width="1.5" 
                stroke="currentColor" 
                class="size-6 mt-auto mb-auto"
            >
                <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m9-.75a9 9 0 1 1-18 0 9 9 0 0 1 18 0Zm-9 3.75h.008v.008H12v-.008Z" />
            </svg>
    
            <h3 class="ml-4">Erros encontrados durante a emissão da NFC-e [{{ errors.length }}]</h3>
        
        </div>

        <div title="A venda será guardada" class="flex justify-center">
            <span @click="close('now')" class="bg-white p-1 rounded-lg cursor-pointer mt-auto mb-auto mr-10 text-black hover:text-slate-400">Conferir relatório de erros</span>
            <span @click="close('after')" class="bg-white p-1 rounded-lg cursor-pointer mt-auto mb-auto text-yellow-600 hover:text-yellow-400">Conferir depois</span>

        </div>
    </div>
</template>

<script>
    export default {
        methods: {

            close(choose)
            {
                this.$emit('close', choose)
            }

        },

        props: {
            errors: {
                required: true
            }
        },

        emits: [
            'close'
        ]

    }
</script>

<style>
    .error-container{
        left: 34rem;
        bottom: 5rem;
    }

</style>