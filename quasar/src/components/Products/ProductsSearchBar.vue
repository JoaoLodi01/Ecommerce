<template>
    <div class="mr-20 text-center">
        <input
            v-model="productsData.product"
            @input="getProducts()"
            @keydown.enter="setProduct(productsData)"
            placeholder="Buscar..."
            class="border-none outline-none ml-2 mt-1 mb-1 w-96"
<<<<<<< HEAD
            v-model="productData.name"
            placeholder="Buscar.."
=======
>>>>>>> a5cf082b9f9dd1d04ec1394362f5bce9b540ad48
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


    export default {
        data()
        {
            return {
<<<<<<< HEAD
                produtcData:{
                    id:'',
                    name: ''
                },

=======
                products: [],
                filteredProducts: [],
                productsData: {
                    id: '',
                    product: ''
                },
>>>>>>> a5cf082b9f9dd1d04ec1394362f5bce9b540ad48
            }
        },
        
        methods: {
<<<<<<< HEAD
            getProdutc
=======
            async getProducts(){
                try {
           
                    const response = await api.get(`/ecommerce/products/all`);

                    this.products = response.data.data;
                    console.log(this.products)
                    this.filterProducts();

                } catch (error) {
                    console.error('erro getProducts', error)
                }
            },

            filterProducts(){
                this.filteredProducts = this.products.filter(product => 
                    product.product.toLowerCase().includes(this.productsData.product.toLowerCase())
                );
                
            },

            setProduct(product){
                console.log('setProduct', product)
                this.productsData.id = product.id;
                this.productsData.product = product.product;
                this.filteredProducts = [];
                this.$emit('update:selectProducts', this.productsData);
            },
>>>>>>> a5cf082b9f9dd1d04ec1394362f5bce9b540ad48
        }
    }
</script>