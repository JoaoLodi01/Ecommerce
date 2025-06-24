<template>
    <div 
        :class="{
            'mt-10 p-6 ml-20 mb-5 bg-white rounded-lg shadow-lg w-[160vh]': widthScreen > 1366,
            'mt-10 ml-14 mr-6 mb-5 bg-white rounded-lg shadow-lg w-[120vh]': widthScreen <= 1366
            
        }"  
    >
        <div
            class="flex"
            :class="{
                'div1': widthScreen > 1080
            }">

            <h1 class="text-3xl font-semibold m-5">Produtos</h1>

            <div
                class="mt-auto mb-auto"
                :class="{
                    'ml-auto': widthScreen > 1366
                }"
            >
                <q-btn
                    v-if="showProducts"
                    @click="openRegister()"
                    class="bg-blue-500 hover:bg-blue-400 text-white font-semibold rounded-lg"
                >
                    <span v-if="widthScreen <= 1080">Novo produto</span>
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
        <div v-if="widthScreen > 1080" class="mt-2 ml-2">
            <ReportProduct
                :widthScreen="widthScreen"
                v-if="showReportProducts"
            />

        </div>
        
        <div
            v-else
            class="ml-5"
        >
            <q-btn
                v-if="showReportProducts"
                @click="openReportProductsMini()"
                color="grey"
            >
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M9 12h3.75M9 15h3.75M9 18h3.75m3 .75H18a2.25 2.25 0 0 0 2.25-2.25V6.108c0-1.135-.845-2.098-1.976-2.192a48.424 48.424 0 0 0-1.123-.08m-5.801 0c-.065.21-.1.433-.1.664 0 .414.336.75.75.75h4.5a.75.75 0 0 0 .75-.75 2.25 2.25 0 0 0-.1-.664m-5.8 0A2.251 2.251 0 0 1 13.5 2.25H15c1.012 0 1.867.668 2.15 1.586m-5.8 0c-.376.023-.75.05-1.124.08C9.095 4.01 8.25 4.973 8.25 6.108V8.25m0 0H4.875c-.621 0-1.125.504-1.125 1.125v11.25c0 .621.504 1.125 1.125 1.125h9.75c.621 0 1.125-.504 1.125-1.125V9.375c0-.621-.504-1.125-1.125-1.125H8.25ZM6.75 12h.008v.008H6.75V12Zm0 3h.008v.008H6.75V15Zm0 3h.008v.008H6.75V18Z" />
                </svg>
                <svg v-if="showReportProductsMini" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-5 ml-2">
                    <path stroke-linecap="round" stroke-linejoin="round" d="m19.5 8.25-7.5 7.5-7.5-7.5" />
                </svg>
                <svg v-else xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-5 ml-2">
                    <path stroke-linecap="round" stroke-linejoin="round" d="m4.5 15.75 7.5-7.5 7.5 7.5" />
                </svg>
            </q-btn>

            <div class="mt-4">
                <ReportProduct
                    v-if="showReportProductsMini"
                    :widthScreen="widthScreen"
                />
               
            </div>
        </div>
    </div>

    <div
        class="products-grid grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-5 gap-4 ml-20 mt-6"
        v-if="showProducts && products && products.length > 0"
        :class="{
            'relative right-7 top-10': widthScreen <= 1080
        }"
    >
        <div
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
                    @click="deleteproduct(product.id)"
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
                    @click="activeProduct(product.product_cod)"
                >
                    Ativar
                </q-btn>
            </div>
        </div>
    </div>

    <div v-if="!showProducts" class="ml-24">
        <RegisterProduct
            v-if="showRegisterProduct"
            :widthScreen="widthScreen"
            @close="closeReload($event)"
        />

        <UpdateProduct
            v-if="showUpdateProduct"
            :widthScreen="widthScreen"
            :productName="productName"
            :productID="productID"
            @close="closeReload($event)"
        />
    </div>
</template>

<script setup lang="ts">
    import { LocalStorage } from 'quasar';
    import { ref, onMounted } from 'vue';
    import { api } from 'src/boot/axios';
    import RegisterProduct from 'src/components/Register/Products/RegisterProduct.vue';
    import UpdateProduct from 'src/components/Register/Products/UpdateProduct.vue';
    import ReportProduct from 'src/components/Reports/Products/ReportProduct.vue';

    let products = ref<IProducts[]>([]);
    let showProducts = ref<boolean>(true);
    let showReportProducts = ref<boolean>(true);
    let showUpdateProduct = ref<boolean>(false);
    let showRegisterProduct = ref<boolean>(false);
    let showReportProductsMini = ref<boolean>(false);
    let widthScreen = ref<number>(0);
    let productName = ref<string>('');
    let productID = ref<number>(0);

    const getProducts = async () => 
    {
        const res = await api.get(`/ecommerce/products/all/${LocalStorage.getItem("issuer_id")}`);
        products.value = res.data.data;

    };

    const activeProduct = async (id: number) => 
    {
        await api.put(`/ecommerce/products/${id}/active`);
    };

    const deleteproduct = async (id: number) => 
    {
        await api.put(`/ecommerce/products/${id}/deactivate`);  
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
        showRegisterProduct.value = false;
        showProducts.value = true;
        showReportProducts.value = true;
        getProducts();
    };

    const toggleRegisterProductVisibility = () =>
    {
        showRegisterProduct.value = !showRegisterProduct.value;
        showProducts.value = !showProducts.value;
    };

    const openReportProductsMini = () =>
    {
        showReportProductsMini.value = !showReportProductsMini.value
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
        showReportProducts.value = true;
        showUpdateProduct.value = event;
        showRegisterProduct.value = event;
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

