<template>
    <div class="mr-20 text-center">
        <input
            v-model="productsData.name"
            @input="getProducts()"
            @keydown.enter="setProduct()"
            placeholder="Buscar..."
            class="border-none outline-none ml-2 mt-1 mb-1 w-96"
        />
        <ul v-if="filteredProducts.length" class="border border-gray-300 rounded mt-1">
            <li
                v-for="product in filterProducts"
                :key="product.id"
                @click="setProduct(product)"
                class="p-2 hover:bg-gray-200 cursor-pointer">

                {{ product.name }}
            </li>
        </ul>
    </div>
</template>

<script>
import { api } from "boot/axios"

    export default {
        data()
        {
            return {
                products: [],
                filteredProducts: [],
                productsData: {
                    id: '',
                    name: ''
                },
            }
        },
        
        methods: {
            async getProducts(){
                const response = await api.get(`/products/all`);
                this.products = response.data;
                this.filterProducts();
            },

            filterProducts(){
                this.filteredProducts = this.products.filter(product => 
                    product.name.toLowerCase().includes(this.productsData.name.toLowerCase())
                );
            },

            setProduct(product){
                this.productsData.id = product.id;
                this.productsData.name = product.name;
                this.filteredProducts = [];
            },
        }
    }
</script>