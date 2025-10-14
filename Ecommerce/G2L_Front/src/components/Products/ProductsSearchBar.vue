<template>
    <div class="">
        <q-input
            id="searchBar"
            v-model="search.name"
            :dense="true"
            borderless
            class="bg-white rounded-lg p-2 border-b-white"
            placeholder="Pesquisar produto ..."
            :class="{
                'w-[95vh]': props.locale === 'pdv',
                'mr-[5.4rem]': props.locale === 'pdv'
            }"
        >
            <template v-slot:append v-if="props.locale !== 'pdv'">
                <q-icon name="search" />
            </template>
        </q-input>
    </div>
    
    <ul 
        class="fixed z-50 p-3 bg-white border border-gray-300 mt-1 transition-transform"
        v-if="filtredProducts.length > 0 && search.name !== '' && props.locale === 'pdv'" 
    >
        <li
            v-for="product in filtredProducts"
            :key="product.product_code"
            @click="setProduct(product)"
            class="p-2 hover:bg-gray-200 cursor-pointer"
            
        >
            <span>{{ product.product_code }}</span> -
            <span>{{ product.product }}</span> -
            <span>Qtde: {{ product.amount }}</span> -
            <span>R$ {{ product.sale_price }} </span>

        </li>
    </ul>
    <ul
        class="fixed z-50 p-3 bg-white border border-gray-300 mt-1 transition-transform"
        v-if="filtredProducts.length === 0 && search.name !== '' && props.locale === 'pdv'"
    >
        <li>
            <span>Produto não encontrado!</span>
            
        </li>
    </ul>
</template>

<script setup lang="ts">
    import { api } from "src/boot/axios"
    import { LocalStorage, useQuasar } from "quasar";
    import { ref, onMounted } from "vue";
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
    const issuerID = ref<number>(LocalStorage.getItem("issuer_id"));

    let filtredProducts = ref<IProducts[]>([]);

    const productsData = ref<IProducts>({
        id: 0,
        product_code: 0,
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

    let amout = ref<number>(1);

    const getProducts = async () =>
    {
        const isPDV = props.locale === 'pdv';
        const isMultiple = search.value.name.split('').includes('*');
        const newAmount = Number(search.value.name.replace(',', '.').split('*')[0]);
        
        amout.value = isMultiple ? newAmount : 1;
        const nameLength = search.value.name.length;

        if(nameLength >= 4 || nameLength >= 1)
        {   
            const res = await api.post(`/ecommerce/products/search`,{
                filter: isPDV ? configs.value.filter : props.momentFilter,
                search: isMultiple && search.value.name.split('*')[1].length >= 1 ? search.value.name.split('*')[1] : search.value.name,
                issuer_id: issuerID.value

            });

            const data = res.data.data;
            
            return isPDV ? filtredProducts.value = data : emits('returnCod', data.map((p: IProducts) => { return p. product_code; }));

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
                const emitProduct = {...productsData.value = { 
                    id: product.id,
                    product_code: product.product_code, 
                    product: product.product, 
                    active: product.active,
                    barcode: 0,
                    barcode_internal: 0,
                    cfop: product.cfop,
                    csosncst: product.csosncst,
                    amount: amout.value,
                    sale_price: Number(product.sale_price)
                    
                }};
                
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
        document.addEventListener('keydown', (event: KeyboardEvent) => {
            if(event.key === 'Enter' && filtredProducts.value.length > 0)
            {
                setProduct(filtredProducts.value[0]);
                
            };
        });
    });
               
</script>

<style>
    #searchBar {
        outline: none !important;
        
    }
</style>