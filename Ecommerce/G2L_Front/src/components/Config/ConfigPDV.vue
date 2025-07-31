<template>
    <LoandingPage
        v-show="!showPage"
        @show-page="showPage = $event"
        :text="textLoanding"
    />

    <div
        class="ml-14 bg-white p-5 mt-6 rounded-lg cointainer-config"
        v-if="showPage"
    >
        <div class="flex justify-between">
            <h1 class="ml-4 border-b border-black text-base">Configurações</h1>
            <q-btn 
                icon="close" 
                label="Voltar" 
                @click="onClose()"
                class="h-4 mt-auto mb-auto ml-5 "
            />
            
        </div>

        <q-form
            @submit="onSubmit()"
            @reset="onReset()"
            class="q-gutter-md mt-5"
        >
            <div 
                class="shadow-lg border bg-white rounded-lg mb-2 p-2"
            >
                <p class="ml-4 border-b border-black text-lg">Gerais</p>
                <div class="grid grid-cols-3 gap-4 p-2">
                    <q-checkbox 
                        v-model="configs.nmFinaly" 
                        :label="'Permitir venda sem emissão fiscal ( Nota Manual )'"
                        color="primary"
                        
                    />

                    <q-checkbox 
                        v-model="configs.saleNegativeorReset" 
                        :label="'Permitir venda com estoque negativo ou zerado'"
                        color="primary"
                        
                    />

                    <q-checkbox 
                        v-model="configs.supervisorPasswordDeleteItem" 
                        :label="'Exigir senha do supervisor para excluir item'"
                        color="primary"

                    />

                    <q-checkbox 
                        v-model="configs.supervisorPasswordCancelSale"
                        :label="'Exigir senha do supervisor para cancelar a venda'"
                        color="primary"
                        
                    />

                </div>    
            </div>            

            <div 
                class="shadow-lg border bg-white rounded-lg mb-2 p-2"
            >
                <p class="ml-4 mb-2 border-b border-black text-lg">Busca</p>
                <div class="grid grid-cols-3 gap-4 p-2 mb-2">
                    <q-select 
                        v-model="configs.searchOptionProduct" 
                        :options="searchOptionProducts" 
                        :dense="true"
                        label="Busca de produtos" 
                        class="ml-2"
                        color="primary"
                        
                    />

                    <q-select 
                        v-model="configs.searchOptionCustomer" 
                        :options="searchOptionCustomers" 
                        :dense="true"
                        label="Busca de clientes" 
                        class="ml-2"
                        color="primary"
                        
                    />
                    
                </div>
            </div>
            
            <div 
                class="shadow-lg border bg-white rounded-lg mb-2 p-2"
            >
                <p class="ml-4 mb-2 border-b border-black text-lg">Alterações</p>
                <div class="grid grid-cols-3 gap-4 p-2 mb-2">
                <q-select 
                    v-model="configs.permitEditFields" 
                    :options="editFields" 
                    label="Campos" 
                    class="ml-2"
                    color="primary"
                    
                />
                
            </div>
        
        </div>
            
            <div class="ml-5">
                <q-btn
                    label="Salvar" 
                    type="submit" 
                    :style="`background-color: ${buttonColor}; color: ${textColor}`"
                    :disable="configs.searchOptionProduct === null"
                />
                <q-btn  
                    label="Padrão" 
                    type="reset" 
                    color="black" 
                    flat 
                    class="q-ml-sm"
                    
                /> 
            </div>
        </q-form>
    </div>

</template>
<script setup lang="ts">
    import { api } from 'src/boot/axios'
    import { LocalStorage, useQuasar } from 'quasar';
    import { ref, onMounted } from 'vue';
    import LoandingPage from '../Loanding/LoandingPage.vue';

    const emits = defineEmits<{
        (e: 'close', value: boolean)

    }>();

    const editFields = ref<string[]>([
        'Permitir alterar Qtde e Val Unitário e calcular o total',
        'Permitir alterar o valor unitário e calcular o total',

    ]);

    const searchOptionProducts = ref<string[]>([
        'Cód barras',
        'Cód barras interno',
        'Cód barras & Cód barras interno',
        'Padrão (nome do produto, cód.barras ou cód.produto)'

    ]);

    const searchOptionCustomers = ref<string[]>([
        'CPF ou Cód cliente',
        'CNPJ ou Cód cliente',
        'CNPJ, CPF ou Cód cliente',
        'Padrão (cód.cliente ou nome)'
        
    ]);

    const $q = useQuasar();
    
    const configs = ref<IConfig>({
        searchOptionProduct: null,
        searchOptionCustomer: null,
        saleNegativeorReset: false,
        supervisorPasswordDeleteItem: false,
        supervisorPasswordCancelSale: false,
        permitEditFields: null,
        nmFinaly: true
        
    });
    
    const issuerID = ref<number>(LocalStorage.getItem("issuer_id"));
    const buttonColor = LocalStorage.getItem("buttonColor");
    const textColor = LocalStorage.getItem("textColor");
    
    let showPage = ref<boolean>(false);
    let textLoanding = ref<string>('');

    const getConfig = async() =>
    {
        const res = await api.get(`/configs/all-configs/${issuerID.value}`);

        const data = res.data.data.pdv;
        
        if(res.data.success)
        {
            configs.value = {
                nmFinaly: data.nm_finaly === 1 ? true : false,
                saleNegativeorReset: data.sale_negative_or_reset === 1 ? true : false,
                searchOptionProduct: data.filter_search,
                searchOptionCustomer: data.filter_search_customer,
                supervisorPasswordDeleteItem: data.supervisor_password_delete_item === 1 ? true : false,
                supervisorPasswordCancelSale: data.supervisor_password_cancel_sale === 1 ? true : false,
                permitEditFields: editFields.value[0],
                
            };
            showPage.value = true;
        };
    };
        
    const onSubmit = async () =>
    {
        showPage.value = false;
        textLoanding.value = 'Salvando configurações do PDV ...';
        const res = await api.put(`/configs/pdv/update-config/${issuerID.value}`, {
            searchOptionProduct: configs.value.searchOptionProduct,
            searchOptionCustomers: configs.value.searchOptionCustomer,
            nmFinaly: configs.value.nmFinaly,
            saleNegativeorReset: configs.value.saleNegativeorReset,
            supervisorPasswordCancelSale: configs.value.supervisorPasswordCancelSale,
            supervisorPasswordDeleteItem: configs.value.supervisorPasswordDeleteItem,
            issuer_id: issuerID.value

        });

        const data = res.data;
        
        if(data.success)
        {
            $q.notify({
                color: 'green',
                message: 'Configurações alteradas com sucesso!',
                position: 'top',
                timeout: 2000
                
            });
            showPage.value = true;
            onClose();

        };
    };

    const onReset = () =>
    {
        getConfig();

    };

    const onClose = () =>
    {
        emits('close', false);

    };

    onMounted(() =>
    {
        textLoanding.value = 'Carregnado configucações do PDV ... '
        getConfig();
        document.addEventListener('keydown', (event: KeyboardEvent) => {
            const keyName = event.key;
            if(keyName === 'Escape')
            {
                onClose();
                
            } else {
                return;

            };
        }); 
    });
    
</script>

<style>
    .cointainer-config{
        max-width: 100%;
    }
</style>