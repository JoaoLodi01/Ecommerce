<template>
    <form @submit.prevent="addProduct" class="bg-white p-6 shadow-lg rounded-lg border border-gray-300 max-w-max m-auto">
      <!--border-gray-300" para retornar como estava, deixo assim-->
      <h2 class="text-2xl text-center font-semibold mb-4">Cadastrar Novo Produto</h2>
  
      <div class="max-w-md mx-auto mt-10 p-6 bg-white shadow-md rounded">
        <!-- Nome do produto -->
        <div>
          <label for="name" class="block text-sm font-medium">Produto:</label>
          <input 
            v-model="product.name" 
            type="text" 
            id="name" 
            placeholder="Nome do produto..." 
            class="mt-1 p-2 w-full border border-gray-300 rounded-lg"
          />
        </div>
  
        <!-- Quantidade -->
        <div>
          <label for="quantity" class="block text-sm font-medium">Quantidade:</label>
          <input 
            v-model="product.quantity" 
            type="number" 
            id="quantity" 
            placeholder="Quantidade..." 
            class="mt-1 p-2 w-full border border-gray-300 rounded-lg"
          />
        </div>
  
        <!-- Preço de Custo -->
        <div>
          <label for="cost" class="block text-sm font-medium">Preço de Custo:</label>
          <input 
            v-model="product.cost" 
            type="number" 
            id="cost" 
            placeholder="Preço de custo..." 
            class="mt-1 p-2 w-full border border-gray-300 rounded-lg"
          />
        </div>
  
        <!-- Preço de Venda -->
        <div>
          <label for="sale" class="block text-sm font-medium">Preço de Venda:</label>
          <input 
            v-model="product.sale" 
            type="number" 
            id="sale" 
            placeholder="Preço de venda..." 
            class="mt-1 p-2 w-full border border-gray-300 rounded-lg"
          />
        </div>
  
        <!-- Percentual de Lucro -->
        <div>
          <label for="profit" class="block text-sm font-medium">% de Lucro:</label>
          <input 
            v-model="product.profit" 
            type="number" 
            id="profit" 
            placeholder="% de lucro..." 
            class="mt-1 p-2 w-full border border-gray-300 rounded-lg"
          />
        </div>
  
        <!-- NCM -->
        <div>
          <label for="ncm" class="block text-sm font-medium">NCM:</label>
          <input 
            v-model="product.ncm" 
            type="number" 
            id="ncm" 
            placeholder="NCM..." 
            class="mt-1 p-2 w-full border border-gray-300 rounded-lg"
          />
        </div>
  
        <!-- CEST -->
        <div>
          <label for="cest" class="block text-sm font-medium">CEST:</label>
          <input 
            v-model="product.cest" 
            type="number" 
            id="cest" 
            placeholder="CEST..." 
            class="mt-1 p-2 w-full border border-gray-300 rounded-lg"
          />
        </div>
  
        <!-- CSOSN -->
        <div>
          <label for="csosn" class="block text-sm font-medium">CSOSN:</label>
          <input 
            v-model="product.csosn" 
            type="number" 
            id="csosn" 
            placeholder="CSOSN..." 
            class="mt-1 p-2 w-full border border-gray-300 rounded-lg"
          />
        </div>
  
        <!-- CFOP -->
        <div>
          <label for="cfop" class="block text-sm font-medium">CFOP:</label>
          <input 
            v-model="product.cfop" 
            type="number" 
            id="cfop" 
            placeholder="CFOP..." 
            class="mt-1 p-2 w-full border border-gray-300 rounded-lg"
          />
        </div>
  
        <!-- Botão de cadastro -->
        <div class="mt-4">
          <button @click="cancelOperation()">Voltar</button>
          <button 
            type="submit" 
            class="w-full py-3 bg-gray-800 text-white font-semibold rounded-lg hover:bg-gray-500 transition">Cadastrar Produto</button>
        </div>
      </div>
    </form>
  </template>
  
  <script>
  import axios from 'axios';
  
  export default {
    props: {
      products: Array,
      apiUrl: String,
    },
    data() {
      return {
        product: {
          name: '',
          quantity: '1',
          cost: '',
          sale: '',
          profit: '100',
          ncm: '',
          cest: '',
          csosn: '',
          cfop: '',
        },
        api: process.env.VUE_APP_API_URL,
      };
    },
    emits: [
      'close'
    ],  
  
    methods: {
      async addProduct() {
        try {
          if (
            !this.product.name ||
            !this.product.quantity ||
            !this.product.cost ||
            !this.product.sale ||
            !this.product.profit
          ) {
            alert("Nome, quantidade, preço custo, preço venda, perc lucro são obrigatórios!");
            return;
          }
  
          const response = await axios.post(`${this.api}/ecommerce/products/create`);
  
          this.$emit('productAdded', { ...this.product });
          this.product = {
            name: '',
            quantity: '',
            cost: '',
            sale: '',
            profit: '',
            ncm: '',
            cest: '',
            csosn: '',
            cfop: '',
          };
  
          console.log("Resposta da API:", response.data);
          alert("Cadastro realizado com sucesso!");
        } catch (error) {
          console.log("Erro ao cadastrar:", error);
          alert("Erro ao cadastrar!");
        }
      },

      cancelOperation()
      {
        this.$emit('close')
      }
    },
  };
  </script>
  