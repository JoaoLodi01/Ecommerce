<template>
  <div class="nfce-container">
    <h1 class="title">Emissão NFC-e</h1>

    <!-- Adicionar produto -->
    <div class="add-product">
      <label for="product">Produto:</label>
      <input 
        v-model="newProduct.produto" 
        @input="searchProduct"
        @keydown.enter="addProduct"
        type="text"
        id="product"
        placeholder="Digite o código ou nome..." 
      />
      <ul v-if="searchResults.length" class="search-results">
        <li v-for="product in searchResults" :key="product.id" @click="selectProduct(product)">
          {{ product.produto }} - R$ {{ product.price }}
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
            <td>{{ product.produto }}</td>
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
      <p><strong>Total:</strong> R$ {{ total.toFixed(2) }}</p>
      <button @click="emitNfce">Finalizar</button>
      <PaymentsForm
        v-if = "show"
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
        produto: "",
        csosn: "",
        price: 0,
        quantity: 1,
        discount: 0,
        addition: 0,
      },
      api: process.env.VUE_APP_API_URL,
      searchResults: [],
      products: [],
      total: 0,
      show: false
    };
  },
  components: {
    PaymentsForm,
  },
  computed: {
    total() {
      return this.products.reduce((acc, product) => acc + this.calculateTotal(product), 0);
    },
  },

  methods: {
    async searchProduct() {
      //console.log(this.newProduct.name);
      try {
        const response = await axios.post(`${this.api}/ecommerce/products/search`, {
          params: this.newProduct.produto});
          console.log('Consultando...', response.data)
        this.searchResults = response.data;

      } catch (error) {
        console.error("Erro ao buscar produtos:", error);
      }
    },

    selectProduct(product) {
      this.newProduct = {
          name: product.produto,
          csosn: product.csosn || '',
          price: product.price || 0,
          quantity: 1,
          discount: 0,
          addition: 0
      };
      this.searchResults = [];
    },

    addProduct() {
      if (!this.newProduct.produto || !this.newProduct.price >=0) {
        alert("Selecione um produto válido!");
        return;
      }
      this.products.push({ ...this.newProduct });
      this.newProduct = { produto: "", csosn: "", price: 0, quantity: 1, discount: 0, addition: 0 };
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
        this.show = !this.show;
        this.$routes.push({ name: "PaymentsForm" });
        console.log("Dados enviados!", response.data);

      } catch (error) {
        alert("Erro ao emitir venda!")
      }
    }
  },
};
</script>

