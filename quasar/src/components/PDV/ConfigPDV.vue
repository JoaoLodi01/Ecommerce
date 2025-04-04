<template>
    <div
        class="ml-14"
    >
        <div class="flex">
            <h1>Configuarações</h1>
            <q-btn 
                icon="close" 
                label="Voltar" 
                @click="onClose" 
                class="h-4 mt-auto mb-auto ml-5"
            />
        </div>

        <q-form
            @submit="onSubmit"
            @reset="onReset"
            class="q-gutter-md"
        >

            <q-checkbox 
                left-label 
                v-model="configs.nmFinaly" 
                :label="'Permitir venda sem emissão fiscal ( Nota Manual )'"
                label="Orange" 
            />

            <q-checkbox 
                left-label 
                v-model="configs.saleNegativeorReset" 
                :label="'Permitir venda com estoque negativo ou zerado'"
                label="Orange" 
            />

            <q-select 
                v-model="configs.searchOption" 
                :options="searchOptions" 
                label="Busca" 
                filled 
            />
            
            <div>
                <q-btn label="Salvar" type="submit" color="primary"/>
                <q-btn label="Padrão" type="reset" color="primary" flat class="q-ml-sm" />
            </div>
        </q-form>
    </div>

</template>
<script>
    import { api } from 'src/boot/axios'

    export default {
        data()
        {
            return {
                configs: {
                    searchOption: null,
                    nmFinaly: true,
                    saleNegativeorReset: false,
                   
                },
                searchOptions: [
                    'Cód barras',
                    'Cód barras interno'
                ]
            }
        },

        methods: {
            async getConfig()
            {
                const response = await api.get('/config/all-configs');
                const data = response.data.configPDV[0]
                
                this.configs = {
                    nmFinaly: data.nm_finaly === 1 ? true : false,
                    saleNegativeorReset: data.sale_negative_or_reset === 1 ? true : false,
                    searchOption: data.filter_search
                }

            },
        
            async onSubmit()
            {
                const response = await api.put('/config/config-pdv/update-config', this.configs)
                const data = response.data

                if(data.success)
                {
                       
                }
            },

            onReset()
            {
                this.getConfig()
            },

            onClose()
            {
                this.$emit("close", false)
            }
        },

        emits: [
            'close'
        ],
        
        mounted()
        {
            this.getConfig()
            
        }
    }
</script>