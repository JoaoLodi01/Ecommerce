<template>
    <div 
        class="text-xl ml-14 mt-10"
        v-if="showStart"
    >
        <h1>Primeiros passos</h1>
        
        <div>
            <div class="flex">
                <CompleteOrNo :label="completeIssuer" class="mt-0.5"/><router-link to='/'>Completar cadastro do emitente</router-link>
                
            </div>

            <div class="flex">
                <CompleteOrNo :label="completeConfigPDV" class="mt-0.5"/><router-link to=''>Configurações PDV</router-link>

            </div>

            <div class="flex">
                <CompleteOrNo :label="completeConfigCustomer" class="mt-0.5"/><router-link to=''>Configurações Clientes</router-link>

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
            }
        }
    }
</script>