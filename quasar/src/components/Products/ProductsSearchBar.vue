<template>
    <div class="mr-20">
        <input
            v-model="search.name"
            @input="getProducts()"
            placeholder="Buscar..."
            class="border-none outline-none ml-2 mt-1 mb-1 w-96"
        />
        
        <ul 
            v-if="filteredProducts.length > 0 && search.name !== ''" 
            class="fixed z-50 p-3 bg-white border border-gray-300 mt-1 transition-transform"
        >
            <li
                v-for="product in filteredProducts"
                :key="product.id"
                @click="setProduct(product)"
                
                class="p-2 hover:bg-gray-200 cursor-pointer">
                <span>{{ product.id }}</span> -
                <span> {{ product.product }}</span> -
                <span> Qtde: {{ product.amount }}</span>

            </li>
        </ul>
    </div>
</template>

<script>
    import { api } from "boot/axios"
    import { toRaw } from "vue";

    export default {
        mounted()
        {
            const getConfig = async () => {
                const response = await api.get('/config/all-configs');
                this.configs = {
                    fieldSearch: response.data.configPDV[0].filter_search,
                    saleNegativeorReset: response.data.configPDV[0].sale_negative_or_reset === 1 ? true : false,
                }

                console.log('this.configs 1', this.configs)
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
                    fieldSearch: ''
                }
            }
        },

        methods: {
            async getProducts(){
                try {

                    if(this.search.name.length >= 4 || this.search.name.length === 1)
                    {
                        const response = await api.post(`/ecommerce/products/search`, {
                            fillter: this.configs.fieldSearch,
                            search: this.search.name

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
        }
    }
</script>