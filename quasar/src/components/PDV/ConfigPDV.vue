<template>
    <div
        class="ml-14"
    >
        <div class="flex">
            <h1>Configurações</h1>
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

            <q-checkbox 
                left-label 
                v-model="configs.supervisorPasswordDeleteItem" 
                :label="'Exigir senha do supervisor para excluir item'"
                label="Orange" 
            />

            <q-checkbox 
                left-label
                v-model="configs.supervisorPasswordCancelSale"
                :label="'Exigir senha do supervisor para cancelar a venda'"
                label="Orange" 
            />

            <q-select 
                v-model="configs.searchOptionProduct" 
                :options="searchOptionProducts" 
                label="Busca de produtos" 
                filled 
            />

            <q-select 
                v-model="configs.searchOptionCustomer" 
                :options="searchOptionCustomers" 
                label="Busca de clientes" 
                filled 
            />
            
            <div>
                <q-btn label="Salvar" type="submit" color="primary" :disable="configs.searchOptionProduct === null"/>
                <q-btn label="Padrão" type="reset" color="primary" flat class="q-ml-sm" />
            </div>
        </q-form>
    </div>

</template>
<script>
    import { api } from 'src/boot/axios'
    import { useQuasar } from 'quasar';
    import { onBeforeUnmount } from 'vue';

    export default {
        setup()
        {
            const $q = useQuasar()
            let timer

            onBeforeUnmount(() => {
                if(timer !== void 0)
                {
                    clearTimeout(timer)
                    $q.loading.hide()

                }
            })
            return {
                showLoading (messageValue) {
                    $q.loading.show({
                        message: `${messageValue} configurações ...`
                    })

                    timer = setTimeout(() => {
                        $q.loading.hide()
                        timer = void 0

                    }, 2000)
                }
            }
        },
        
        data()
        {
            return {
                configs: {
                    searchOptionProduct: null,
                    searchOptionCustomer: null,
                    saleNegativeorReset: false,
                    supervisorPasswordDeleteItem: false,
                    supervisorPasswordCancelSale: false,
                    nmFinaly: true,
                   
                },
                
                searchOptionProducts: [
                    'Cód barras',
                    'Cód barras interno',
                    'Cód barras & Cód barras interno',
                    'Padrão (cód.barras ou cód.produto)'

                ],

                searchOptionCustomers: [
                    'Padrão (cód.cliente ou nome)',
                    'CPF ou Cód cliente',
                    'CNPJ ou Cód cliente',
                    'CNPJ, CPF ou Cód cliente',
                    
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
                    searchOptionProduct: data.filter_search,
                    searchOptionCustomer: data.filter_search_customer,
                    supervisorPasswordDeleteItem: data.filter_search_customer,
                    supervisorPasswordCancelSale: data.filter_search_customer,
                    
                }
            },
        
            async onSubmit()
            {
                this.showLoading('Salvando')

                const response = await api.put('/config/config-pdv/update-config', {
                    searchOptionProduct: this.configs.searchOptionProduct,
                    searchOptionCustomers: this.configs.searchOptionCustomer,
                    nmFinaly: this.configs.nmFinaly,
                    saleNegativeorReset: this.configs.saleNegativeorReset,

                })

                const data = response.data                

                if(data.success)
                {
                    alert('Configurações gravadas com sucesso!')
                    this.onClose()
                }
            },

            onReset()
            {
                this.showLoading('Restaurando')
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