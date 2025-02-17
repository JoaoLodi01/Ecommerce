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
            <td>R$ {{ product.discount ? product.discount : '0.00' }}</td>
            <td>R$ {{ product.addition ? product.addition : '0.00' }}</td>
            <td>R$ {{ product.price ? product.price : '0.00' }}</td>
            <td>R$ {{ calculateTotal(product) }}</td>
            <td><button @click="removeProduct(index)">Remover</button></td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- Resumo da venda -->
    <div class="sale-summary">
      <h2>Valores:</h2>
      <p><strong>Total:</strong> R$ {{ total }}</p>
      <button @click="showPayment">Finalizar</button>
      <PaymentsForm
          v-if="show"
          :show="this.show"
      />
    </div>
  </div>
</template>

<script>
import PaymentsForm from "@/views/components/PaymentsForm.vue";
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
        total: 0
      },
      api: process.env.VUE_APP_API_URL_ECOMMERCE,
      searchResults: [],
      products: [],
      show: false
    };
  },

  components: {
    PaymentsForm
  },

  methods: {
    async searchProduct() {
      /*if (!this.newProduct.name) {
        this.searchResults = [];
        return;
      }*/
      try {
        const response = await axios.get(`${this.api}/products/search`, {
          params: this.newProduct.name});
          console.log('Teste kochem', response.data)
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
      this.total += product.quantity * product.price - product.discount + product.addition;
    },

    showPayment(){
      this.show = !this.show

    },

    async emitNfce(){
      try {
        if(this.products && this.total > 0) {
          const response = await axios.post(`${this.api}/nfce/create`)
        }
        alert("Venda finalizada!")
      } catch (error) {
        response.message(error)
        alert("Erro ao emitir venda!")
      }
    }
  },
};
</script>

