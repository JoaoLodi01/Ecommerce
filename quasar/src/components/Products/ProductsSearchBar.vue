<template>
    <input
        v-model="search.name"
        @input="getProducts()"
        placeholder="Buscar..." 
        class="outline-none rounded-md mt-1 mb-1 p-1.5"
        id="searchBar"
        :disabled="!configs.fillter"
    />
    
    <ul 
        v-if="filteredProducts.length > 0 && search.name !== ''" 
        class="fixed z-50 p-3 bg-white border border-gray-300 mt-1 transition-transform"
    >
        <li
            v-for="product in filteredProducts"
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

<script>
    import { api } from "boot/axios"
import { LocalStorage } from "quasar";
    import { toRaw } from "vue";

    export default {
        mounted()
        {
            const getConfig = async () => {
                const response = await api.get(`/config/all-configs/${LocalStorage.getItem("issuer_id")}`);
                this.configs = {
                    fillter: response.data.configPDV[0].filter_search,
                    saleNegativeorReset: response.data.configPDV[0].sale_negative_or_reset >= 1 ? true : false,
                }

            }
            getConfig()
            
        },

        data()
        {
            return {
                products: [],
                filteredProducts: [],
                productsData: [],
                
                search: {
                    name: ''
                },

                configs: {
                    saleNegativeorReset: false,
                    fillter: ''
                },

                issuer_id: LocalStorage.getItem("issuer_id")
            }
        },

        methods: {
            async getProducts(){
                try {

                    if(this.search.name.length >= 4 || this.search.name.length >= 1)
                    {
                        const response = await api.post(`/ecommerce/products/search`,{
                            fillter: this.configs.fillter,
                            search: this.search.name,
                            issuer_id: this.issuer_id
                        });

                        this.products = toRaw(response.data);
                        this.filterProducts();

                    }
                    
                } catch (error) {
                    console.error('erro getProducts', error)
                }
            },

            filterProducts(){
                this.filteredProducts = this.products.filter(product => 
                    product.product.toLowerCase()
                    
                );
                
            },

            setProduct(product){
                if(product.amount <= 0 && this.configs.saleNegativeorReset)
                {
                    alert('Venda com estoque negativo/zerado bloqueada!')
                    this.search.name = ''
                    
                } else {
                    this.productsData.push({
                        ...product, 
                        amount: 1
                    })

                    this.$emit('update:selectProducts', this.productsData);
                    
                    this.productsData = []
                    this.filteredProducts = []
                    this.search.name = ''

                }
                
            },
        },
        props: {
            witdhScreen: {
                tpye: Number,
                required: true
            }
        }
    }
</script>

<style>
    #searchBar{ 
        width: 100vh;
    }

</style>