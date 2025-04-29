<template>
    <div 
        class="text-xl ml-14 mt-10"
        v-if="showStart"
    >
        <h1>Primeiros passos</h1>
        
        <div>
            <div class="flex">
                <CompleteOrNo :label="completeIssuer" class="mt-0.5"/><router-link :to="`/${issuer_name}/companie-data`">Completar cadastro do emitente</router-link>
                
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
    import { LocalStorage } from 'quasar';
    import { api } from 'src/boot/axios';
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

        methods: {
            async completed()
            {
                const response = await api.get(`/first-stpes/${LocalStorage.getItem("issuer_id")}`)
                const data = response.data.first_steps
                this.completeIssuer = data.complete_issuer === 1 ? true : false;
                this.completeConfigPDV = data.complete_pdv === 1 ? true : false;
                this.completeConfigCustomer = data.complete_customers === 1 ? true : false;
                
            }
        },

        mounted()
        {
            this.issuer_name = this.$route.params.name
            
            this.completed()
        }
    }
</script>