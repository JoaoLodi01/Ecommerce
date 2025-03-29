<template>
    <div class="mr-20 text-center">
        <input
            v-model="search.name"
            @input="getProducts()"
            placeholder="Buscar..."
            class="border-none outline-none ml-2 mt-1 mb-1 w-96"
        />
        
        <ul v-if="filteredProducts.length > 2" class="border border-gray-300 rounded mt-1">
            <li
                v-for="product in filteredProducts"
                :key="product.id"
                @click="setProduct(product)"
                
                class="p-2 hover:bg-gray-200 cursor-pointer">

                {{ product.product }}
            </li>
        </ul>
    </div>
</template>

<script>
    import { api } from "boot/axios"
    import { toRaw } from "vue";

    export default {
        data()
        {
            return {
                products: [],
                filteredProducts: [],
                productsData: [],
                search: {
                    name: ''
                }
            }
        },

        methods: {
            async getProducts(){
                try {
                    const response = await api.post(`/ecommerce/products/search`, {
                        params: this.search.name

                    });

                    this.products = toRaw(response.data);
                    console.log('produtos', toRaw(this.products))
                    this.filterProducts();
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
                this.productsData.push({
                    ...product, 
                    amount: 1
                })
                console.log('setProduct', product, ' this.productsData', this.productsData)
                this.$emit('update:selectProducts', this.productsData);
                
                this.productsData = []
                this.filteredProducts = []
                this.search.name = ''
            },
        }
    }
</script>