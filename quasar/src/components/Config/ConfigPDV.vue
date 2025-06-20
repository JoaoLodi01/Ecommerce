<template>
    <div
        class="ml-14 bg-white p-5 mt-6 rounded-lg cointainer-config"
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
                        color="grey"
                        
                    />

                    <q-checkbox 
                        v-model="configs.saleNegativeorReset" 
                        :label="'Permitir venda com estoque negativo ou zerado'"
                        color="grey"
                        
                    />

                    <q-checkbox 
                        v-model="configs.supervisorPasswordDeleteItem" 
                        :label="'Exigir senha do supervisor para excluir item'"
                        color="grey"

                    />

                    <q-checkbox 
                        v-model="configs.supervisorPasswordCancelSale"
                        :label="'Exigir senha do supervisor para cancelar a venda'"
                        color="grey"
                        
                    />

                    <q-checkbox 
                        v-model="configs.groupLikeItens"
                        :label="'Agrupar itens iguais'"
                        color="grey"
                        
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
                        filled
                        color="grey"
                        
                    />

                    <q-select 
                        v-model="configs.searchOptionCustomer" 
                        :options="searchOptionCustomers" 
                        :dense="true"
                        label="Busca de clientes" 
                        filled 
                        color="grey"
                        
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
                    filled 
                    color="grey"
                    
                />
                
            </div>
        
        </div>
            
            <div class="ml-5">
                <q-btn label="Salvar" type="submit" color="grey" :disable="configs.searchOptionProduct === null"/>
                <q-btn label="Padrão" type="reset" color="black" flat class="q-ml-sm" />
            </div>
        </q-form>
    </div>

</template>
<script setup lang="ts">
    import { api } from 'src/boot/axios'
    import { LocalStorage, useQuasar } from 'quasar';
    import { ref, onMounted, defineEmits } from 'vue';

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
        'Padrão (cód.barras ou cód.produto)'

    ]);

    const searchOptionCustomers = ref<string[]>([
        'CPF ou Cód cliente',
        'CNPJ ou Cód cliente',
        'CNPJ, CPF ou Cód cliente',
        'Padrão (cód.cliente ou nome)'
        
    ]);

    const $q = useQuasar();
    let timer: unknown;

    let configs = ref<IConfig>({
        searchOptionProduct: null,
        searchOptionCustomer: null,
        saleNegativeorReset: false,
        supervisorPasswordDeleteItem: false,
        supervisorPasswordCancelSale: false,
        groupLikeItens: false,
        permitEditFields: null,
        nmFinaly: true
    
    });
    
    const issuerID = ref<number>(LocalStorage.getItem("issuer_id"));

    const showLoading = (messageValue: string) =>
    {
        $q.loading.show({
            message: `${messageValue} configurações ...`

        });

        timer = setTimeout(() => {
            $q.loading.hide();
            timer = void 0;

        }, 1000);
    };

    const getConfig = async() =>
    {
        showLoading('Carregando as');

        const res = await api.get(`/config/all-configs/${issuerID.value}`);

        const data = res.data.data.pdv[0];

        configs.value = {
            nmFinaly: data.nm_finaly === 1 ? true : false,
            saleNegativeorReset: data.sale_negative_or_reset === 1 ? true : false,
            searchOptionProduct: data.filter_search,
            searchOptionCustomer: data.filter_search_customer,
            supervisorPasswordDeleteItem: data.supervisor_password_delete_item === 1 ? true : false,
            supervisorPasswordCancelSale: data.supervisor_password_cancel_sale === 1 ? true : false,
            permitEditFields: editFields.value[0],
            groupLikeItens: false
            
        };
    };
        
    const onSubmit = async () =>
    {
        showLoading('Salvando as');
        console.log(typeof issuerID.value)
        const res = await api.put(`/config/config-pdv/update-config/${issuerID.value}`, {
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
            alert('Configurações gravadas com sucesso!');
            onClose();

        };
    };

    const onReset = () =>
    {
        showLoading('Restaurando ...');
        getConfig();

    };

    const onClose = () =>
    {
        emits('close', false);

    };

    onMounted(() =>
    {
        getConfig();
        document.addEventListener('keydown', (event: TEvent) => {
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