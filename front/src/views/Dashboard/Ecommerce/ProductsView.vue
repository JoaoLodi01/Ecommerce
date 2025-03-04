<template>
  <Sidebar/>
  <div class="estoque-container px-20 py-20">
    <!-- Título -->
    <h1 class="text-3xl font-semibold mb-6">Estoque</h1>

    <!-- Grid de Produtos -->
      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 mb-8">
        <div 
          v-for="(product, index) in products" 
          :key="product.id" 
          class="bg-white p-6 shadow-lg rounded-lg border border-gray-200">
          <!-- Nome do produto -->
          <h2 class="text-xl font-semibold mb-4">{{ product.name }}</h2>

          <!-- ID do produto -->
          <div class="text-sm text-gray-500 mb-2">
            <span class="font-semibold">ID:</span> {{ product.id }}
          </div>

          <!-- Quantidade -->
          <div class="text-sm text-gray-500 mb-2">
            <span class="font-semibold">Quantidade:</span> {{ product.quantity }}
          </div>

          <!-- Preço de Venda -->
          <div class="text-sm text-gray-500 mb-4">
            <span class="font-semibold">Preço de Venda:</span> R$ {{ Number(product.sale).toFixed(2) || '0.00' }}
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
          <RegisterProduct
            v-if= "showRegisterProduct"
          />
          <button 
            @click="toggleRegisterProductVisibility"
            class="w-full py-3 bg-gray-800 text-white font-semibold rounded-lg hover:bg-gray-500 transition">
            <span v-if="!showRegisterProduct">Cadastrar</span>
            <span v-else>Voltar</span>
          </button>
        </div>
      </div>
  </div>
</template>

<script>
import RegisterProduct from '@/views/components/RegisterProduct.vue';
import Sidebar from '@/views/components/Sidebar.vue';

export default {
  components: {
    RegisterProduct,
    Sidebar,
  },
  data() {
    return {
      products: [],
      api: process.env.VUE_APP_API_URL,
      showRegisterProduct: false,
      showSidebar: false,
    };
  },

  methods: {
    toggleRegisterProductVisibility(){
      this.showRegisterProduct = !this.showRegisterProduct;
    },

    addProduct(newProduct) {
      this.products.push(newProduct);
    },

    deleteProduct(id) {
      this.products = this.products.filter(product => product.id !== id);
    },

    editProduct(product) {
      // Adicione a lógica de edição se necessário
    },
  },
};
</script>
