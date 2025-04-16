<template>
    <div
        class="ml-14"
    >
        <div class="flex justify-between">
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
                color="grey"
                
            />

            <q-checkbox 
                left-label 
                v-model="configs.saleNegativeorReset" 
                :label="'Permitir venda com estoque negativo ou zerado'"
                color="grey"
                
            />

            <q-checkbox 
                left-label 
                v-model="configs.supervisorPasswordDeleteItem" 
                :label="'Exigir senha do supervisor para excluir item'"
                color="grey"

            />

            <q-checkbox 
                left-label
                v-model="configs.supervisorPasswordCancelSale"
                :label="'Exigir senha do supervisor para cancelar a venda'"
                color="grey"
                
            />

            <q-select 
                v-model="configs.searchOptionProduct" 
                :options="searchOptionProducts" 
                label="Busca de produtos" 
                filled 
                color="grey"
                
            />

            <q-select 
                v-model="configs.searchOptionCustomer" 
                :options="searchOptionCustomers" 
                label="Busca de clientes" 
                filled 
                color="grey"
                
            />
            
            <div>
                <q-btn label="Salvar" type="submit" color="grey" :disable="configs.searchOptionProduct === null"/>
                <q-btn label="Padrão" type="reset" color="black" flat class="q-ml-sm" />
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

                    }, 1000)
                },

                searchOptionProducts: [
                    'Cód barras',
                    'Cód barras interno',
                    'Cód barras & Cód barras interno',
                    'Padrão (cód.barras ou cód.produto)'

                ],

                searchOptionCustomers: [
                    'CPF ou Cód cliente',
                    'CNPJ ou Cód cliente',
                    'CNPJ, CPF ou Cód cliente',
                    'Padrão (cód.cliente ou nome)'
                    
                ]
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
                
            }
        },

        methods: {
            async getConfig()
            {
                this.showLoading('Carregando as')
                const response = await api.get('/config/all-configs');
                const data = response.data.configPDV[0]
                
                this.configs = {
                    nmFinaly: data.nm_finaly === 1 ? true : false,
                    saleNegativeorReset: data.sale_negative_or_reset === 1 ? true : false,
                    searchOptionProduct: data.filter_search,
                    searchOptionCustomer: data.filter_search_customer,
                    supervisorPasswordDeleteItem: data.supervisor_password_delete_item === 1 ? true : false,
                    supervisorPasswordCancelSale: data.supervisor_password_cancel_sale === 1 ? true : false,
                    
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
                    supervisorPasswordCancelSale: this.configs.supervisorPasswordCancelSale,
                    supervisorPasswordDeleteItem: this.configs.supervisorPasswordDeleteItem
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