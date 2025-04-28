<template>
    <div 
        class="text-xl ml-36 mt-10"
        v-if="showStart">

        <div class="rounded-lg mb-10 p-2 flex items-center gap-4 text-3xl">
            <div class="font-semibold">
                <h2>Bem Vindo!</h2>
            </div>

            <div class="text-gray-400">
                <h4>Primeiros passos para o uso do site!</h4>
            </div>
        </div>

        <div class="w-full max-w-3xl">
            <div class="flex bg-white rounded-lg gap-4 mb-6 p-3 shadow-md">
                <CompleteOrNo :label="completeIssuer" class="mt-0.5"/>
                <router-link :to="`/${issuer_name}/companie-data`">
                    <span class="text-blue-500 font-semibold">
                        Passo 1:
                    </span>    
                    Completar cadastro do emitente
                </router-link>
            </div>

            <div class="flex bg-white rounded-lg gap-4 mb-6 p-3 shadow-md">
                <CompleteOrNo :label="completeConfigPDV" class="mt-0.5"/>
                <router-link to=''>
                    <span class="text-blue-500 font-semibold">
                        Passo 2:
                    </span> 
                    Cadastrar produtos e Clientes
                </router-link>
            </div>

            <div class="flex bg-white rounded-lg gap-4 mb-6 p-3 shadow-md">
                <CompleteOrNo :label="completeConfigPDV" class="mt-0.5"/>
                <router-link to=''>
                    <span class="text-blue-500 font-semibold">
                        Passo 3:
                    </span> 
                    Configurações PDV
                </router-link>
            </div>

            <div class="flex bg-white rounded-lg gap-4 mb-6 p-3 shadow-md">
                <CompleteOrNo :label="completeConfigCustomer" class="mt-0.5"/>
                <router-link to=''>
                    <span class="text-blue-500 font-semibold">
                        Passo 4:
                    </span>
                    Configurações Clientes
                </router-link>
            </div>
        </div>
    </div>
</template>

<script>
    import CompleteOrNo from 'src/components/Start/CompleteOrNo.vue';
    export default {
        components: {
            CompleteOrNo
        },
        data()
        {
            return {
                showStart: true,
                completeIssuer: false,
                completeConfigPDV: false,
                completeConfigCustomer: false,
                
                issuer_name: ''
            }
        },

        mounted()
        {
            this.issuer_name = this.$route.params.name
        }
    }
</script>