<template>
  <div class="nfce-container">
    <h1 class="title">Emissão NFC-e</h1>

    <!-- Adicionar produto -->
    <div class="add-product">
      <label for="product">Produto:</label>
      <input 
        v-model="newProduct.name" 
        @input="searchProduct" 
        @keydown.enter="addProduct"
        type="text" id="product" placeholder="Digite o código ou nome..." 
      />
      <ul v-if="searchResults.length" class="search-results">
        <li v-for="product in searchResults" :key="product.id" @click="selectProduct(product)">
          {{ product.name }} - R$ {{ product.price }}
        </li>
      </ul>
    </div>

    <!-- Lista de Produtos -->
    <div class="product-list">
      <h2>Produtos Adicionados:</h2>
      <table>
        <thead>
          <tr>
            <th>Produto</th>
            <th>CSOSN</th>
            <th>Quantidade</th>
            <th>Desconto</th>
            <th>Acréscimo</th>
            <th>Valor bruto</th>
            <th>Valor líquido</th>
            <th>Ações</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(product, index) in products" :key="index">
            <td>{{ product.name }}</td>
            <td>{{ product.csosn || '---' }}</td>
            <td>{{ product.quantity }}</td>
            <td>R$ {{ product.discount ? product.discount.toFixed(2) : '0.00' }}</td>
            <td>R$ {{ product.addition ? product.addition.toFixed(2) : '0.00' }}</td>
            <td>R$ {{ product.price ? product.price.toFixed(2) : '0.00' }}</td>
            <td>R$ {{ calculateTotal(product).toFixed(2) }}</td>
            <td><button @click="removeProduct(index)">Remover</button></td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- Resumo da venda -->
    <div class="sale-summary">
      <h2>Valores:</h2>
      <p><strong>Total:</strong> R$ {{ total.toFixed(2) }}</p>
      <button @click="emitNfce">Emitir NFC-e</button>
    </div>
  </div>
</template>

<script>
import { ref, computed } from "vue";
import axios from "axios";

export default {
  data() {
    return {
      newProduct: {
        name: "",
        csosn: "",
        price: 0,
        quantity: 1,
        discount: 0,
        addition: 0,
      },
      api: import.meta.env.VITE_API_URL,
      searchResults: [],
      products: [],
    };
  },
  computed: {
    total() {
      return this.products.reduce((acc, product) => acc + this.calculateTotal(product), 0);
    },
  },
  methods: {
    async searchProduct() {
      if (!this.newProduct.name) {
        this.searchResults = [];
        return;
      }
      try {
        const response = await axios.get(`${this.api}/products/search`, {
          params: { query: this.newProduct.name },
        });
        this.searchResults = response.data;
      } catch (error) {
        console.error("Erro ao buscar produtos:", error);
      }
    },

    selectProduct(product) {
      this.newProduct = { ...product, quantity: 1, discount: 0, addition: 0 };
      this.searchResults = [];
    },

    addProduct() {
      if (!this.newProduct.name) {
        alert("Selecione um produto!");
        return;
      }
      this.products.push({ ...this.newProduct });
      this.newProduct = { name: "", csosn: "", price: 0, quantity: 1, discount: 0, addition: 0 };
    },

    removeProduct(index) {
      this.products.splice(index, 1);
    },

    calculateTotal(product) {
      return product.quantity * product.price - product.discount + product.addition;
    },

    async emitNfce() {
      try {
        const response = await axios.post(`${this.api}/nfce/create`, {
          products: this.products,
          total: this.total,
        });
        console.log("Dados enviados!", response.data);
      } catch (error) {
        console.error("Erro ao enviar dados!", error);
      }
    },
  },
};
</script>

<style scoped>
.sale-container {
  padding: 20px;
  font-family: Arial, sans-serif;
}

.add-product,
.product-list,
.sale-summary {
  margin-bottom: 20px;
}

.add-product input {
  margin: 5px;
}

.search-results {
  list-style-type: none;
  margin: 0;
  padding: 0;
  border: 1px solid #000000;
  max-height: 150px;
  overflow-y: auto;
}

.search-results li {
  padding: 8px;
  cursor: pointer;
}

.search-results li:hover {
  background-color: #ddd;
}

table {
  width: 100%;
  border-collapse: collapse;
}

table th,
table td {
  border: 1px solid #ddd;
  padding: 8px;
  text-align: center;
}

button {
  background-color: #4CAF50;
  color: white;
  border: none;
  padding: 8px 12px;
  cursor: pointer;
}

button:hover {
  background-color: #45a049;
}

.title {
  font-size: 24px;
  margin-bottom: 20px;
}
</style>