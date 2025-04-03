<template>
    <div
        class="px-20 h-max w-full"
        :class="{
            'relative top-12 right-5': widthScreen <= 1080
        }"  
    >
        <div>
            <h1 class="text-3xl font-semibold mb-6 pt-2">Produtos</h1>
            <div 
                class="mb-5"
                :class="{
                    'ml-2': widthScreen > 1080
                }"
            >
                <ReportProduct
                    :widthScreen="widthScreen"
                    v-if="!showRegisterProduct"
                />

            </div>
            
            <button 
                v-if="showProducts"
                @click="openRegister()"
                :class="{
                    'w-44 p-1 mr-5': widthScreen <= 1080
                    
                }"
                class="w-72 py-2 absolute right-0 top-2 bg-gray-800 text-white font-semibold rounded-lg hover:bg-gray-500 transition"
            >
                <span v-if="widthScreen <= 1080">Novo produto</span>
                <span v-else>Cadastrar um novo produto</span>
                
            </button>

            <button 
                v-else
                @click="closeRegister()"
                :class="{
                    'w-44 p-1 mr-5': widthScreen <= 1080
                }"
                class="w-72 py-2 absolute right-0 top-2 bg-gray-800 text-white font-semibold rounded-lg hover:bg-gray-500 transition"
            >
                <span>Voltar</span>
            </button>
        </div>
    </div>

    <div>
    <!-- GRID PRODUTOS -->
      <div 
        class="products-grid grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 mb-8 ml-20" 
        v-if="showProducts"
        :class="{
            'relative right-7 top-10': widthScreen <= 1080
        }" 
    >
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
            <q-btn
                @click="editProduct(product.id, product.name)"
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
                v-else
                class="px-4 py-2 rounded-lg transition"
                :class="{
                    'text-gray-400 bg-slate-500': !product.active
                }"
                @click="activeproduct(product.id)"
            >   
                Ativar
            </q-btn>
        </div>
    </div>
    </div>
      <div class="mb-8" v-if="!showProducts">
            <RegisterProduct
                v-if="showRegisterProduct"
                :widthScreen="widthScreen"
            />
      </div>
  </div>
</template>

<script>
    import { api } from 'src/boot/axios';
    import RegisterProduct from 'src/components/Register/RegisterProduct.vue';
    import ReportProduct from 'src/components/Reports/Products/ReportProduct.vue';

    export default {
        data() {
            return {
                products: [],
                showProducts: true,
                showRegisterProduct: false,
                widthScreen: 0

            };
        },

        methods: {
            async getProducts() {
                const response = await api.get(`/ecommerce/products/all`);
                this.products = response.data.data;
                
            },

            async deleteproduct(id) {
                const product = await api.delete(`/ecommerce/${id}/deactivate`)  
                console.log(product)
                window.location.reload()
            },

            openRegister()
            {
                this.showRegisterProduct = true
                this.showProducts = false

            },

            closeRegister()
            {
                this.showRegisterProduct = false 
                this.showProducts = true
            },

            toggleRegisterProductVisibility(){
                this.showRegisterProduct = !this.showRegisterProduct;
                this.showProducts = !this.showProducts;
            },

            editProduct(productID) {
                this.showRegisterProduct = false
                this.showProducts = false

            },
        },

        mounted() {
            this.getProducts();
            this.widthScreen += screen.width

        },

        components: {
            RegisterProduct,
            ReportProduct
        }
    };

</script>

<style>
    .products-grid {
        width: 100%;
        padding: 5px;
    }
</style>