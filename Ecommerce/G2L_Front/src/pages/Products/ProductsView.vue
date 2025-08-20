<template>
    <div v-show="_loanding">
        <LoandingPage
            @show-page="showPage($event)"
            :text="'Carregando produtos ...'"
        />

    </div>
    <div v-show="!_loanding">
        <div    
            :class="{
                'mt-10 p-6 ml-16 mb-5 bg-white rounded-lg shadow-lg w-[150vh]': widthScreen > 1366,
                'mt-10 ml-14 mr-6 mb-5 bg-white rounded-lg shadow-lg w-[120vh]': widthScreen <= 1680
                
            }"  
        >
            <div class="flex justify-between">
                <h1 class="text-3xl font-semibold m-5">{{ titleByOperation }}</h1>
                
                <div 
                    :class="{
                        'mt-5': widthScreen > 1366,
                        'mt-5 mr-5': widthScreen <= 1366
                    }"
                >
                    <q-btn
                        v-if="showProducts"
                        @click="productManagement('create', 0, 0)"
                        class="font-semibold rounded-lg hover:bg-blue-400 transition"
                        :style="`background-color: ${buttonColor}; color: ${textColor ?? '#fff'}`"

                    >
                        <span v-if="widthScreen <= 1080" > Novo produto </span>
                        <span v-else>Cadastrar um novo produto</span>
                        
                    </q-btn>
                    
                    <q-btn 
                        v-else
                        @click="closeRegister()"
                        class="bg-gray-800 text-white font-semibold rounded-lg hover:bg-gray-500 transition"
                    >
                        <span>Voltar</span>
                        
                    </q-btn>
                </div>
            </div>
            
            <div 
                class="mt-2 ml-2 flex"
                v-if="showProducts" 

            >
                <q-btn 
                    :style="`background-color: ${buttonColor}; color: ${buttonColor === '#ffffff' ? '#000' : '#ffffff'}`"
                    class="mr-5"
                    title="Opções"
                    
                >
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M9.594 3.94c.09-.542.56-.94 1.11-.94h2.593c.55 0 1.02.398 1.11.94l.213 1.281c.063.374.313.686.645.87.074.04.147.083.22.127.325.196.72.257 1.075.124l1.217-.456a1.125 1.125 0 0 1 1.37.49l1.296 2.247a1.125 1.125 0 0 1-.26 1.431l-1.003.827c-.293.241-.438.613-.43.992a7.723 7.723 0 0 1 0 .255c-.008.378.137.75.43.991l1.004.827c.424.35.534.955.26 1.43l-1.298 2.247a1.125 1.125 0 0 1-1.369.491l-1.217-.456c-.355-.133-.75-.072-1.076.124a6.47 6.47 0 0 1-.22.128c-.331.183-.581.495-.644.869l-.213 1.281c-.09.543-.56.94-1.11.94h-2.594c-.55 0-1.019-.398-1.11-.94l-.213-1.281c-.062-.374-.312-.686-.644-.87a6.52 6.52 0 0 1-.22-.127c-.325-.196-.72-.257-1.076-.124l-1.217.456a1.125 1.125 0 0 1-1.369-.49l-1.297-2.247a1.125 1.125 0 0 1 .26-1.431l1.004-.827c.292-.24.437-.613.43-.991a6.932 6.932 0 0 1 0-.255c.007-.38-.138-.751-.43-.992l-1.004-.827a1.125 1.125 0 0 1-.26-1.43l1.297-2.247a1.125 1.125 0 0 1 1.37-.491l1.216.456c.356.133.751.072 1.076-.124.072-.044.146-.086.22-.128.332-.183.582-.495.644-.869l.214-1.28Z" />
                    <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
                    </svg>            
                    
                </q-btn>

                <q-btn 
                    :style="`background-color: ${buttonColor}; color: ${buttonColor === '#ffffff' ? '#000' : '#ffffff'}`"
                    title="Relatórios"
                    @click="showReportProducts = true" 
                >
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6 ">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M9 12h3.75M9 15h3.75M9 18h3.75m3 .75H18a2.25 2.25 0 0 0 2.25-2.25V6.108c0-1.135-.845-2.098-1.976-2.192a48.424 48.424 0 0 0-1.123-.08m-5.801 0c-.065.21-.1.433-.1.664 0 .414.336.75.75.75h4.5a.75.75 0 0 0 .75-.75 2.25 2.25 0 0 0-.1-.664m-5.8 0A2.251 2.251 0 0 1 13.5 2.25H15c1.012 0 1.867.668 2.15 1.586m-5.8 0c-.376.023-.75.05-1.124.08C9.095 4.01 8.25 4.973 8.25 6.108V8.25m0 0H4.875c-.621 0-1.125.504-1.125 1.125v11.25c0 .621.504 1.125 1.125 1.125h9.75c.621 0 1.125-.504 1.125-1.125V9.375c0-.621-.504-1.125-1.125-1.125H8.25ZM6.75 12h.008v.008H6.75V12Zm0 3h.008v.008H6.75V15Zm0 3h.008v.008H6.75V18Z" />
                    </svg>

                </q-btn>

                <q-btn 
                    :style="`background-color: ${buttonColor}; color: ${buttonColor === '#ffffff' ? '#000' : '#ffffff'}`"
                    class="ml-5"
                    title="Importar produtos"
                    @click="showImportFiles = true"
                >
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M12 16.5V9.75m0 0 3 3m-3-3-3 3M6.75 19.5a4.5 4.5 0 0 1-1.41-8.775 5.25 5.25 0 0 1 10.233-2.33 3 3 0 0 1 3.758 3.848A3.752 3.752 0 0 1 18 19.5H6.75Z" />
                    </svg>
                </q-btn>
                
                <q-btn 
                    :style="`background-color: ${buttonColor}; color: ${buttonColor === '#ffffff' ? '#000' : '#ffffff'}`"
                    class="ml-5"
                    title="Baixa arquivo de importação"
                    @click="downloadDefaultFile"
                >
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 14.25v-2.625a3.375 3.375 0 0 0-3.375-3.375h-1.5A1.125 1.125 0 0 1 13.5 7.125v-1.5a3.375 3.375 0 0 0-3.375-3.375H8.25m.75 12 3 3m0 0 3-3m-3 3v-6m-1.5-9H5.625c-.621 0-1.125.504-1.125 1.125v17.25c0 .621.504 1.125 1.125 1.125h12.75c.621 0 1.125-.504 1.125-1.125V11.25a9 9 0 0 0-9-9Z" />
                    </svg>
                </q-btn>

                <div class="ml-auto">
                    <q-option-group
                        v-model="searchFilter"
                        type="radio"
                        toggle
                        class="flex"
                        :options="[
                            {label: 'Todos', value: 'all'},
                            {label: 'Ativos', value: 'active'},
                            {label: 'Inativos', value: 'disabled'},
                        ]"
                    />                
                </div>
            </div>
        </div>
    </div>

    <div
        class="ml-16 p-1 mb-2 flex justify-between w-[150vh]"
        v-if="showProducts"
    >
        <ProductsSearchBar
            :witdh-screen=widthScreen
            :locale="'products'"
            :moment-filter="searchBarFilter"
            @return-cod="filterProducts($event)"
            @get-all="getProducts()"
            
        />
    
        <q-select 
            v-model="searchBarFilter" 
            :options="searchOptionProducts"
            label="Filtro de busca" 
            class="p-1.5 ml-2 bg-white rounded"
        />
    </div>
  
    <div 
        class="products-grid grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-5 gap-4 mb-2" 
        :class="{
            'ml-16 w-[150vh]': widthScreen > 1366,
            'ml-12': widthScreen <= 1366
        }"    
    >
        <div
            v-if="showProducts"
            v-for="product in products" :key="product.id"
            class="relative overflow-x-auto overflow-y-auto bg-white p-6 shadow-lg rounded-lg border border-gray-200 transition-transform hover:-translate-y-3 cursor-pointer"
        >
            <div 
                @click="productManagement('update', product.active, product.product_code)"
                
            >
                <div class="text-sm text-gray-500 mb-2">
                    <span class="font-semibold">ID:</span> {{ product.product_code }}
                </div>

                <div class="text-sm text-gray-500 mb-2">
                    <span class="font-semibold">Produto:</span> {{ product.product }}
                </div>

                <div class="text-sm text-gray-500 mb-2">
                    <span class="font-semibold">Cód barras:</span> {{ product.barcode ?? 'Sem cód informado' }}
                </div>

                <div class="text-sm text-gray-500 mb-4">
                    <span class="font-semibold">Cód barras interno:</span> {{ product.barcode_internal ?? 'Sem cód informado' }}

                </div>

                <div class="text-sm text-gray-500 mb-2">
                    <span class="font-semibold">Quantidade:</span> {{ product.amount }}
                </div>

                <div class="text-sm text-gray-500 mb-4">
                    <span class="font-semibold">Preço de Venda:</span> R$ {{ Number(product.sale_price).toFixed(2) || '0.00' }}
                </div>

            </div>

            <!-- Ações -->
            <div class="flex space-x-2">
                <q-btn
                    @click="productManagement('update', product.active, product.product_code)"
                    class="px-4 py-2 mr-2 rounded-lg transition"
                    :disabled=!product.active
                    :class="{
                        'text-gray-400 bg-slate-500': !product.active,
                        'text-blue-500 bg-blue-100 hover:bg-blue-200': product.active,
                    }"
                >
                    Editar
                </q-btn>
                <q-btn
                    @click="showConfirmFn('products/disable', product.id)"
                    class="px-4 py-2 rounded-lg transition"
                    :disabled=!product.active
                    :class="{
                        'text-gray-400 bg-slate-500': !product.active,
                        'text-red-500 bg-red-100 hover:bg-red-200': product.active,
                    }"
                    v-if="product.active"
                >
                    Desativar
                </q-btn>
                <q-btn
                    v-if="!product.active"
                    class="px-4 py-2 rounded-lg transition"
                    :class="{
                        'text-gray-400 bg-slate-500': !product.active
                    }"
                    @click="showConfirmFn('products/active', product.product_code)"
                    
                >
                    Ativar
                </q-btn>
            </div>
        </div>
    </div>

    <div v-if="!showProducts">
        <ProductManagement
            v-if="showProductManagement"
            @close="closeReload($event)"
            :widthScreen="widthScreen"
            :operation="operation"
            :product-cod="productCodSelected"
            
        />    
    </div>

    <ReportProduct
        v-if="showReportProducts"
        @close="showReportProducts = !showReportProducts"
    />

    <ConfirmPage
        v-if="showConfirm"
        @confirm="handleOperation($event)"
        :operation="typeOperation"
    />

    <ImportFiles
        v-show="showImportFiles"
        @close="closeReload($event)"
        :operation="'importProducts'"

    />
</template>

<script setup lang="ts">
    import { LocalStorage, useQuasar } from 'quasar';
    import { ref, onMounted, watch, reactive } from 'vue';
    import { api } from 'src/boot/axios';
    import ProductManagement from 'src/components/Register/Products/ProductManagement.vue';
    import ReportProduct from 'src/components/Reports/Products/ReportProduct.vue';
    import LoandingPage from 'src/components/Loanding/LoandingPage.vue';
    import ProductsSearchBar from 'src/components/Products/ProductsSearchBar.vue';
    import ConfirmPage from 'src/components/Confirm/ConfirmPage.vue';
    import ImportFiles from 'src/components/Files/ImportFiles.vue';

    const $q = useQuasar();
    const buttonColor = ref<string>(LocalStorage.getItem("buttonColor"));
    const textColor = ref<string>(LocalStorage.getItem("textColor"));
    const searchFilter = ref<'all' | 'active' | 'disabled' >('all');
    
    const searchOptionProducts = ref<string[]>([
        'Cód barras',
        'Cód barras interno',
        'Cód barras & Cód barras interno',
        'Padrão (nome do produto, cód.barras ou cód.produto)'

    ]);
    
    const titles = reactive({
        'create': 'Novo produto',
        'update': 'Editar produto'
        
    });

    let _loanding = ref<boolean>(true);
    let allProducts = ref<IProducts[]>([]);
    let products = ref<IProducts[]>([]);
    let searchBarFilter = ref<string>('Padrão (nome do produto, cód.barras ou cód.produto)');

    let showProducts = ref<boolean>(false);

    let showProductManagement = ref<boolean>(false);
    let operation = ref<string>('');
    let titleByOperation = ref<string>('Produtos');
    let productCodSelected = ref<number>(0);
    
    let showReportProducts = ref<boolean>(false);
    let showImportFiles = ref<boolean>(false);
    let widthScreen = ref<number>(0);
    let showConfirm = ref<boolean>(false);
    let typeOperation = ref<string>('');
    
    watch(searchFilter, async(newOption) =>{
        if(newOption === 'active')
        {
            products.value = allProducts.value.filter(p => p.active === 1);

        } else if(newOption === 'disabled')
        {
            products.value = allProducts.value.filter(p => p.active === 0);
            
        } else {
            products.value = [...allProducts.value];

        };
    });

    const showPage = (event: boolean) =>
    {
        showProducts.value = event;
        _loanding.value = !event;
    };

    const getProducts = async () => 
    {
        console.log('Chamou aqui');
        const res = await api.get(`/ecommerce/products/all/${LocalStorage.getItem("issuer_id")}`);
        allProducts.value = res.data.data;
        products.value = [...allProducts.value];

    };

    const showConfirmFn = (operation: string, productID_: number) => 
    {
        typeOperation.value = operation;
        LocalStorage.setItem("productID", productID_);
        operation !== 'products/active' ? showConfirm.value = true : handleOperation([{'operation': operation, 'value': true}]);
    
    };

    const handleOperation = async (event: TEmit[]|boolean) =>
    {
        const operation = event[0]['operation'];
        const value = event[0]['value'];
    
        if(!value)
        {
            $q.notify({ color: 'red', message: 'Operação cancelada!', position: 'top', timeout: 2000 }); 

            showConfirm.value = false;
            LocalStorage.remove("productID");

            return;
        } else {
            const res = await api.put(`/ecommerce/${operation}/${LocalStorage.getItem("issuer_id")}/${LocalStorage.getItem("productID")}`);
            const data = res.data;

            if(data.success)
            {
                $q.notify({
                    color: 'green',
                    message: data.message,
                    position: 'top',
                    timeout: 2000

                });

                showConfirm.value = false;
                const product = products.value.find(c => c.product_code === LocalStorage.getItem("productID"));
                if(product)
                {
                    product.active = operation === 'products/active' ? 1 : 0;
                    LocalStorage.remove("productID");
                } else {
                    $q.notify({
                        color: 'red',
                        message: 'Erro desconhecido, contate um adminstrador!',
                        position: 'top',
                        timeout: 2000

                    });
                };
            }
        };
    };
    
    const filterProducts = (productCods: number[]) =>
    {
        products.value = allProducts.value.filter((p: IProducts) => productCods.includes(p.product_code));
    };

 
    const productManagement = (action: string, active: number, productCod: number) =>
    {
        console.log(action)
        if(action === 'update' && active === 0)
        {
            $q.notify({
                color: 'red-4',
                message: 'Impossível alterar produto desativado!',
                timeout: 2000,
                position: 'top'
                
            });  
            
            return;
        } else {
            operation.value = action;
            titleByOperation.value = titles[action];
            productCodSelected.value = productCod;
            
            showProductManagement.value = true;
            showProducts.value = false;
            showReportProducts.value = false;
        };        
        
    };

    const closeRegister = () => 
    {
        titleByOperation.value = 'Produtos';
        showProducts.value = true;
        showProductManagement.value = false;
        showReportProducts.value = false;
        getProducts();

    };

    const closeReload = (event: boolean) =>
    {
        titleByOperation.value = 'Produtos';
        showProducts.value = event;
        showProductManagement.value = false;
        showReportProducts.value = false;
        showImportFiles.value = false;
        getProducts();

    };        

    const downloadDefaultFile = async () =>
    {
        const res = await api.get('ecommerce/products/download/default-file', {
            responseType: 'blob'

        });

        console.log(res);

        const url = window.URL.createObjectURL(
            new Blob([res.data], { 
                type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' 
            }
        ));
        
        const link = document.createElement('a');

        link.href = url;
        link.setAttribute('download', `Padrão_Importação.xlsx`);
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);

    };

    onMounted(() => {
        getProducts();
        widthScreen.value = screen.width;

    });
</script>

<style>
    .products-grid {
        padding: 5px;
    }

    .div1 {
        width: 100%;
    }

    .search{
        bottom: 3.3rem;

    }
</style>