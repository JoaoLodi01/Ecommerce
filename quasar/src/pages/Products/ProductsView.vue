<template>
    <div v-if="_loanding">
        <LoandingPage
            @show-page="showPage($event)"
            :text="'Carregando produtos ...'"
            
        />
    </div>
    
    <div    
        v-if="!_loanding"
        :class="{
            'mt-10 p-6 ml-20 mb-5 bg-white rounded-lg shadow-lg w-[160vh]': widthScreen > 1366,
            'mt-10 ml-4 mr-4 mb-5 p-2 bg-white rounded-lg shadow-lg w-[200vh]': widthScreen <= 1680
            
        }"  
    >
        <div
            class="flex justify-between "
            
        >
            <h1 v-if="!showRegisterProduct && !showUpdateProduct" class="text-3xl font-semibold m-5">Produtos</h1>
            <h1 v-if="showRegisterProduct" class="text-3xl font-semibold m-5">Novo produto</h1>
            <h1 v-if="showUpdateProduct" class="text-3xl font-semibold m-5">Edição do produto</h1>
            
            <div 
                :class="{
                    'mt-5': widthScreen > 1366,
                    'mt-5 mr-2': widthScreen <= 1366
                }"
            >
                <q-btn
                    v-if="showProducts"
                    @click="openRegister()"
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
            v-if="showProducts" class="mt-2 ml-2 flex"

        >
            <q-btn 
                :style="`background-color: ${buttonColor}; color: ${buttonColor === '#ffffff' ? '#000' : '#ffffff'}`"
                title="Relatórios"
                @click="showReportProducts = true" 
            >
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6 ">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M9 12h3.75M9 15h3.75M9 18h3.75m3 .75H18a2.25 2.25 0 0 0 2.25-2.25V6.108c0-1.135-.845-2.098-1.976-2.192a48.424 48.424 0 0 0-1.123-.08m-5.801 0c-.065.21-.1.433-.1.664 0 .414.336.75.75.75h4.5a.75.75 0 0 0 .75-.75 2.25 2.25 0 0 0-.1-.664m-5.8 0A2.251 2.251 0 0 1 13.5 2.25H15c1.012 0 1.867.668 2.15 1.586m-5.8 0c-.376.023-.75.05-1.124.08C9.095 4.01 8.25 4.973 8.25 6.108V8.25m0 0H4.875c-.621 0-1.125.504-1.125 1.125v11.25c0 .621.504 1.125 1.125 1.125h9.75c.621 0 1.125-.504 1.125-1.125V9.375c0-.621-.504-1.125-1.125-1.125H8.25ZM6.75 12h.008v.008H6.75V12Zm0 3h.008v.008H6.75V15Zm0 3h.008v.008H6.75V18Z" />
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

    <div
        class="ml-20 p-2 flex"
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
            class="p-1 ml-4"
            filled 
        />
    </div>
  
    <div 
        class="products-grid grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-5 gap-4" 
        :class="{
            'ml-20 w-[120vh]': widthScreen > 1366,
            'ml-2': widthScreen <= 1366
        }"    
    >
        <div
            v-if="showProducts"
            v-for="product in products" :key="product.id"
            class="relative overflow-x-auto max-h-96 overflow-y-auto bg-white p-6 shadow-lg rounded-lg border border-gray-200 transition-transform hover:-translate-y-3 cursor-pointer"
        >
            <div 
                @click="editProduct(product.product, product.id)"
            >
                <div class="text-sm text-gray-500 mb-2">
                    <span class="font-semibold">ID:</span> {{ product.product_cod }}
                </div>

                <div class="text-sm text-gray-500 mb-2">
                    <span class="font-semibold">Produto:</span> {{ product.product }}
                </div>

                <div class="text-sm text-gray-500 mb-2">
                    <span class="font-semibold">Cód barras:</span> {{ product.barcode }}
                </div>

                <div class="text-sm text-gray-500 mb-4">
                    <span class="font-semibold">Cód barras interno:</span> {{ product.barcode_internal }}

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
                    @click="editProduct(product.product, product.product_cod)"
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
                    @click="showConfirmFn('active', product.product_cod)"
                >
                    Ativar
                </q-btn>
            </div>
        </div>
    </div>

    <div v-if="!showProducts">
        <RegisterProduct
            v-if="showRegisterProduct"
            @close="closeReload($event)"
            :widthScreen="widthScreen"
            
        />

        <UpdateProduct
            v-if="showUpdateProduct"
            :productID="productID"
            :productName="productName"
            :widthScreen="widthScreen"
            @close="closeReload($event)"

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
</template>

<script setup lang="ts">
    import { LocalStorage, useQuasar } from 'quasar';
    import { ref, onMounted, watch } from 'vue';
    import { api } from 'src/boot/axios';
    import RegisterProduct from 'src/components/Register/Products/RegisterProduct.vue';
    import UpdateProduct from 'src/components/Register/Products/UpdateProduct.vue';
    import ReportProduct from 'src/components/Reports/Products/ReportProduct.vue';
    import LoandingPage from 'src/components/Loanding/LoandingPage.vue';
    import ProductsSearchBar from 'src/components/Products/ProductsSearchBar.vue';
    import ConfirmPage from 'src/components/Confirm/ConfirmPage.vue';

    const $q = useQuasar();
    const buttonColor = LocalStorage.getItem("buttonColor");
    const textColor = LocalStorage.getItem("textColor");
    const searchFilter = ref<'all' | 'active' | 'disabled' >('all');
    
    const searchOptionProducts = ref<string[]>([
        'Cód barras',
        'Cód barras interno',
        'Cód barras & Cód barras interno',
        'Padrão (nome do produto, cód.barras ou cód.produto)'

    ]);

    let _loanding = ref<boolean>(true);
    let allProducts = ref<IProducts[]>([]);
    let products = ref<IProducts[]>([]);
    let searchBarFilter = ref<string>('Padrão (nome do produto, cód.barras ou cód.produto)');
    let showProducts = ref<boolean>(false);
    let showReportProducts = ref<boolean>(false);
    let showUpdateProduct = ref<boolean>(false);
    let showRegisterProduct = ref<boolean>(false);
    let showReportProductsMini = ref<boolean>(false);
    let widthScreen = ref<number>(0);
    let productName = ref<string>('');
    let showConfirm = ref<boolean>(false);
    let typeOperation = ref<string>('');
    let productID = ref<number>(0);

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
        const res = await api.get(`/ecommerce/products/all/${LocalStorage.getItem("issuer_id")}`);
        allProducts.value = res.data.data;
        products.value = [...allProducts.value];

    };

    const showConfirmFn = (operation: string, productID: number) => 
    {
        showConfirm.value = true;
        typeOperation.value = operation;
        LocalStorage.setItem("productID", productID);
    
    };

    const handleOperation = async (event: TEmit[]) =>
    {
        const operation = event[0]['operation'];
        const value = event[0]['value'];
        console.log(operation);
        if(!value) $q.notify({ color: 'red', message: 'Operação cancelada!', position: 'top', timeout: 2000 });

        showConfirm.value = false;
        LocalStorage.remove("productID");
        const res = await api.put(`/ecommerce/products//${operation}`);
        /*
        if(res.data.success)
        {
            $q.notify({
                color: `green`,
                message: res.data.message,
                timeout: 2000,
                position: 'top'
                
            });

            const product = products.value.find(c => c.product_cod === id);
            if(product)
            {
                product.active = action === 'active' ? 1 : 0;
                
            };
        };*/
    };
    
    const filterProducts = (productCods: number[]) =>
    {
        products.value = allProducts.value.filter((p: IProducts) => productCods.includes(p.product_cod));
    };

    const openRegister = () =>
    {
        showRegisterProduct.value = true;
        showUpdateProduct.value = false;
        showProducts.value = false;
        showReportProducts.value = false;
        showReportProductsMini.value = false;
        
    };

    const closeRegister = () => 
    {
        showProducts.value = true;
        showRegisterProduct.value = false;
        showUpdateProduct.value = false;
        showReportProducts.value = false;
        getProducts();
    };

    const editProduct = (name: string, id: number) =>
    {
        productName.value = name;
        productID.value = id;
        showUpdateProduct.value = true;
        showRegisterProduct.value = false;
        showProducts.value = false;
        showReportProducts.value = false;

    };

    const closeReload = (event: boolean) =>
    {
        showRegisterProduct.value = event;
        showReportProducts.value = false;
        showUpdateProduct.value = false;
        getProducts();
    };        

    onMounted(() => {
        getProducts();
        widthScreen.value = screen.width;

    });
</script>

<style>
    .products-grid {
        width: 100%;
        padding: 5px;
    }

    .div1 {
        width: 100%;
    }

    .search{
        bottom: 3.3rem;

    }
</style>