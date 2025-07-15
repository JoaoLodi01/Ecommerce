<template>
    <input
        v-model="search.name"
        @input="getProducts()"
        placeholder="Buscar..." 
        class="outline-none rounded-md mt-1 mb-1 p-1.5"
        id="searchBar"
        :disabled="!configs.filter"

    />        
    
    <ul 
        v-if="filtredProducts.length > 0 && search.name !== '' && props.locale === 'pdv'" 
        class="fixed z-50 p-3 bg-white border border-gray-300 mt-1 transition-transform"
    >
        <li
            v-for="product in filtredProducts"
            :key="product.product_cod"
            @click="setProduct(product)"
            class="p-2 hover:bg-gray-200 cursor-pointer"
            
        >
            <span>{{ product.product_cod }}</span> -
            <span>{{ product.product }}</span> -
            <span>Qtde: {{ product.amount }}</span> -
            <span>R$ {{ product.sale_price }} </span>

        </li>
    </ul>
    
</template>

<script setup lang="ts">
    import { api } from "src/boot/axios"
    import { LocalStorage, useQuasar } from "quasar";
    import { ref, onMounted, defineProps, defineEmits } from "vue";
    import camelcaseKeys from "camelcase-keys";

    type TConfig = {
        saleNegativeorReset: boolean,
        filter: string
    }

    type TSearch = {
        name: string
    }
    
     const emits = defineEmits<{
        (e: 'update:selectProducts', value: object),
        (e: 'returnCod', value: number[]),
        (e: 'getAll', value: void)

    }>();

    const props = defineProps<{
        witdhScreen: number,
        locale?: string,
        momentFilter?: string
        
    }>(); 

    const $q = useQuasar();

    let filtredProducts = ref<IProducts[]>([]);

    const productsData = ref<IProducts>({
        id: 0,
        product_cod: 0,
        active: 0,
        barcode: 0,
        barcode_internal: 0,
        product: '',
        cfop: 0,
        csosncst: 0,
        amount: 0,
        sale_price: 0

    });
    
    let search = ref<TSearch>({
        name: ''

    });

    let configs = ref<TConfig>({
        saleNegativeorReset: false,
        filter: ''

    });

    const issuerID = ref<number>(LocalStorage.getItem("issuer_id"));

    const getProducts = async () =>
    {
        const isPDV = props.locale === 'pdv';
        const nameLength = search.value.name.length;

        if(nameLength >= 4 || nameLength >= 1)
        {
            const res = await api.post(`/ecommerce/products/search`,{
                filter: isPDV ? configs.value.filter : props.momentFilter,
                search: search.value.name,
                issuer_id: issuerID.value

            });

            const data = res.data.data;
            
            return isPDV ? filtredProducts.value = data : emits('returnCod', data.map((p: IProducts) => { return p. product_cod; }));

        } else {
            emits('getAll');
        };
    };

    const setProduct = (product: IProducts) => 
    {
        if(product.amount <= 0 && configs.value.saleNegativeorReset)
        {
            $q.notify({
                color: 'red',
                message: 'Venda com estoque negativo/zerado bloqueada!',
                position: 'top',
                timeout: 2000

            });
            
            search.value.name = ''
            
        } else {
            if(product.active)
            {
            console.log(product.active)
                const emitProduct = {...productsData.value = { 
                    id: product.id,
                    product_cod: product.product_cod, 
                    product: product.product, 
                    active: product.active,
                    barcode: 0,
                    barcode_internal: 0,
                    cfop: product.cfop,
                    csosncst: product.csosncst,
                    amount: 1,
                    sale_price: product.sale_price
                    
                }};
                
                console.log('emitProduct: ', emitProduct)
                emits('update:selectProducts', emitProduct);
                
                filtredProducts.value = [];
                search.value.name = '';

            } else {
                $q.notify({
                    color: 'red',
                    message: 'Venda com estoque negativo/zerado bloqueada!',
                    position: 'top',
                    timeout: 2000

                });

                search.value.name = ''
                
            };
        };  
    };

    const getConfig = async () => {
        const res = await api.get(`/configs/all-configs/${issuerID.value}`);
        
        const config = camelcaseKeys(res.data.data.pdv, { deep: true });

        configs.value = {
            filter: config.filterSearch,
            saleNegativeorReset: config.saleNegativeOrReset >= 1 ? true : false,

        };
    };

    onMounted(() => {
        getConfig();

    });
               
</script>

<style>
    #searchBar{ 
        width: 100vh;
    }

</style>