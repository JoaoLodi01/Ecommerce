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
        v-if="filtredProducts.length > 0 && search.name !== ''" 
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
    import { LocalStorage } from "quasar";
    import { ref, onMounted, defineProps, defineEmits } from "vue";

    type TConfig = {
        saleNegativeorReset: boolean,
        filter: string
    }

    type TSearch = {
        name: string
    }
    
    interface IFilterProduct
    {
        product_cod: number,
        product: string,
        amount: number,
        sale_price: number,
    }

    const emits = defineEmits<{
        (e: 'update:selectProducts', value: object)

    }>();

    const props = defineProps<{
        witdhScreen: number
        
    }>(); 

    let products = ref<IFilterProduct[]>([]);
    let filtredProducts = ref<IFilterProduct[]>([]);
    let productsData = ref<IFilterProduct[]>([]);
    
    let search = ref<TSearch>({
        name: ''

    });

    let configs = ref<TConfig>({
        saleNegativeorReset: false,
        filter: ''

    });

    const issuerID = ref<number>(LocalStorage.getItem("issuer_id"));

    const getConfig = async () => {
        const res = await api.get(`/config/all-configs/${issuerID.value}`);

        const config = res.data.data.pdv[0]

        configs.value = {
            filter: config.filter_search,
            saleNegativeorReset: config.sale_negative_or_reset >= 1 ? true : false,

        };
    };

    const getProducts = async () => 
    {
        if(search.value.name.length >= 4 || search.value.name.length >= 1)
        {
            const res = await api.post(`/ecommerce/products/search`,{
                filter: configs.value.filter,
                search: search.value.name,
                issuer_id: issuerID.value

            });

            console.log('Res: ', res.data.data);

            filtredProducts.value = res.data.data

        };
    };
    
    const setProduct = (product: IFilterProduct) => 
    {
        if(product.amount <= 0 && configs.value.saleNegativeorReset)
        {
            alert('Venda com estoque negativo/zerado bloqueada!')
            search.value.name = ''
            
        } else {
            productsData.value.push({
                ...product,
                amount: 1
            });

            console.log('productsData.value: ', productsData.value);
            
            emits('update:selectProducts', productsData.value);
            
            //productsData.value = [];
            filtredProducts.value = [];
            search.value.name = '';

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