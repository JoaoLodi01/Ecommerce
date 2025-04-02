<template>
  <div class="px-20 h-max w-full">
        <div>
            <h1 class="text-3xl font-semibold mb-6 pt-2">Produtos</h1>
            <div class="ml-2 mb-5">
                <ReportProduct/>

            </div>
            
            <button 
                v-if="showProducts"
                @click="openRegister()"
                class="w-72 py-2 absolute right-0 top-2 bg-gray-800 text-white font-semibold rounded-lg hover:bg-gray-500 transition">
                <span>Cadastrar um novo produto</span>
                
            </button>

            <button 
                v-else
                @click="closeRegister()"
                class="w-72 py-2 absolute right-0 top-2 bg-gray-800 text-white font-semibold rounded-lg hover:bg-gray-500 transition"
            >
                <span>Voltar</span>
            </button>
        </div>
    </div>
    <div>
    <!-- GRID PRODUTOS -->
      <div class="products-grid grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 mb-8 ml-20" v-if="showProducts">
        <div 
          v-for="(product, id) in products" :key="product.id" 
          class="bg-white p-6 shadow-lg rounded-lg border border-gray-200 transition-transform hover:-translate-y-3 cursor-pointer"
          @click="editProduct(id)"
        >

          <div class="text-sm text-gray-500 mb-2">
            <span class="font-semibold">ID:</span> {{ product.id }}
          </div>

          <div class="text-sm text-gray-500 mb-2">
            <span class="font-semibold">Produto:</span> {{ product.product }}
          </div>  

          <div class="text-sm text-gray-500 mb-2">
            <span class="font-semibold">Quantidade:</span> {{ product.amount }}
          </div>

          <div class="text-sm text-gray-500 mb-4">
            <span class="font-semibold">Preço de Venda:</span> R$ {{ Number(product.sale_price).toFixed(2) || '0.00' }}
          </div>

          <!-- Ações -->
          <div class="flex space-x-2">
                <button
                    @click="editProduct(product.id, product.name)"
                    class="px-4 py-2 rounded-lg  transition"
                    :disabled=!product.active
                    :class="{
                        'text-gray-400 bg-slate-500': !product.active,
                        'text-blue-500 bg-blue-100 hover:bg-blue-200': product.active,
                    }"    
                >
                    Editar
                </button>
                <button
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
                </button>
                <button
                    v-else
                    class="px-4 py-2 rounded-lg transition"
                    :class="{
                        'text-gray-400 bg-slate-500': !product.active
                    }"
                    @click="activeproduct(product.id)"
                >   
                    Ativar
                </button>
            </div>
        </div>
      </div>
     
  </div>
</template>

<script>
    import { api } from 'src/boot/axios';
    import ReportProduct from 'src/components/Reports/Products/ReportProduct.vue';

    export default {
        data() {
            return {
                products: [],
                showProducts: true,
                showRegisterProduct: false,

            };
        },

        methods: {
            async getProducts() {
                const response = await api.get(`/ecommerce/products/all`);
                this.products = response.data.data;
                
            },

            async deleteproduct(id) {
                const product = await api.delete(`/ecommerce/${id}/deactivate`)  
                window.location.reload()
            },

            toggleRegisterProductVisibility(){
                this.showRegisterProduct = !this.showRegisterProduct;
                this.showProducts = !this.showProducts;
            },

            editProduct(productID) {
                this.showRegisterProduct = !this.showRegisterProduct;

            },
        },

        mounted() {
            this.getProducts();
        },

        components: {
            ReportProduct
        }
    };

</script>

<style>
    .products-grid {
        width: 83%;
        padding: 5px;
    }
</style>