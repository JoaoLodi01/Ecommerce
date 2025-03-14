<template>
  <div class="estoque-container px-20">
    <h1 class="text-3xl font-semibold mb-6 py-2">Estoque</h1>
        <button 
          @click="toggleRegisterProductVisibility"
          class="w-96 py-2 absolute right-2 top-2 bg-gray-800 text-white font-semibold rounded-lg hover:bg-gray-500 transition">
          <span v-if="!showRegisterProduct">Cadastrar</span>
          <span v-else>Voltar</span>
        </button>
    <!-- Grid de Produtos -->
      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 mb-8" v-if="showProducts">
        <div 
          v-for="(product, id) in products" :key="product.id" 
          class="bg-white p-6 shadow-lg rounded-lg border border-gray-200">
          <!-- Nome do produto -->
          <div class="text-sm text-gray-500 mb-2">
            <span class="font-semibold">Produto:</span> {{ product.produto}}
          </div>  

          <!-- ID do produto -->
          <div class="text-sm text-gray-500 mb-2">
            <span class="font-semibold">ID:</span> {{ product.id }}
          </div>

          <!-- Quantidade -->
          <div class="text-sm text-gray-500 mb-2">
            <span class="font-semibold">Quantidade:</span> {{ product.quantidade }}
          </div>

          <!-- Preço de Venda -->
          <div class="text-sm text-gray-500 mb-4">
            <span class="font-semibold">Preço de Venda:</span> R$ {{ Number(product.preco_venda).toFixed(2) || '0.00' }}
          </div>

          <!-- Ações -->
          <div class="flex space-x-2">
            <button 
              @click="editProduct(product)" 
              class="px-4 py-2 text-blue-500 bg-blue-100 rounded-lg hover:bg-blue-200 transition">Editar</button>
            <button 
              @click="deleteProduct(product.id)" 
              class="px-4 py-2 text-red-500 bg-red-100 rounded-lg hover:bg-red-200 transition">Excluir</button>
          </div>
        </div>
        <div class="mt-4">
          
        </div>
        
      </div>
      <RegisterProduct
        v-if= "showRegisterProduct"
        @close="toggleRegisterProductVisibility()"
      />
  </div>
  
</template>

<script>
import axios from 'axios';
import RegisterProduct from '@/views/components/RegisterProduct.vue';

export default {
  components: {
    RegisterProduct,
  },

  data() {
    return {
      products: [],
      showProducts: true,
      showRegisterProduct: false,
      api: process.env.VUE_APP_API_URL, 
    };
  },

  mounted() {
    this.getProducts();
  },

  methods: {

    async getProducts() {
      const response = await axios.get(`${this.api}/ecommerce/products/all`);
      console.log(response);
      this.products = response.data;
    },

    toggleRegisterProductVisibility(){
      this.showRegisterProduct = !this.showRegisterProduct;
      this.showProducts = !this.showProducts;
    },

    addProduct(newProduct) {
      this.products.push(newProduct);
    },

    deleteProduct(id) {
      this.products = this.products.filter(product => product.id !== id);
    },

    editProduct(productID) {
      this.showRegisterProduct = !this.showRegisterProduct;
    },
  },
};
</script>
