<template>
  <div class="clientes-container px-20">
    <h1 class="text-3xl font-semibold mb-6 pt-2">Clientes</h1>
    <button 
      @click="toggleRegisterProductVisibility"
      class="w-96 py-2 absolute right-2 top-2 bg-gray-800 text-white font-semibold rounded-lg hover:bg-gray-500 transition">
      <span v-if="!showRegisterClients">Cadastrar</span>
      <span v-else>Voltar</span>
    </button>
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 mb-8">
      <div
        v-for="(client, id) in clients" :key="client.id" 
        class="bg-white p-6 shadow-lg rounded-lg border border-gray-200">

        <div class="text-sm text-gray-500 mb-2">
          <span class="font-semibold">ID:</span> {{ client.id }}
        </div>

        <div class="text-sm text-gray-500 mb-2">
          <span class="font-semibold">Cliente:</span> {{ client.name }}
        </div>

        <div class="text-sm text-gray-500 mb-2" v-if="client.cpf">
          <span class="font-semibold">CPF:</span> {{ client.cpf }}
        </div>

        <div class="text-sm text-gray-500 mb-2" v-if="client.cnpj">
          <span class="font-semibold">CNPJ:</span> {{ client.cnpj }}
          
        </div>

        <div class="text-sm text-gray-500 mb-2">
          <span class="font-semibold">Número:</span> {{ client.number }}
        </div>

        <div class="flex space-x-2">
          <button
             @click="editClient(client)"
            class="px-4 py-2 text-blue-500 bg-blue-100 rounded-lg hover:bg-blue-200 transition">Editar</button>
          <button
            @click="deleteClient(client.id)"
            class="px-4 py-2 text-red-500 bg-red-100 rounded-lg hover:bg-red-200 transition">Excluir</button>
        </div>
      </div>
    </div>
  </div>
</template>
  
<script>
import axios from "axios";
import RegisterConsumer from "@/views/components/Register/RegisterConsumer.vue";
  
export default {
  components: {
    RegisterConsumer,
  },

  data() {
    return {
      clients: [],
      showClients: true,
      showRegisterClients: false,
      api: process.env.VUE_APP_API_URL,
    };
  },

  mounted(){
    this.getClients();
  },

  methods: {
    async getClients() {
      const response = await axios.get(`${this.api}/ecommerce/consumers/all`);
      console.log(response);
      this.clients = response.data;
    },

    toggleRegisterClientVisibility(){
      this.showRegisterClients = !this.showRegisterClients;
      this.showClients = !this.showClients;
    },

    addClient(newClient){
      this.clients.push(newClient);
    },

    deleteClient(){
      this.clients = this.clients.filter(client => client.id !== id);
    },

    editClient(clientID){
      this.showRegisterClients = !this.showRegisterClients;
    },
  },
};
</script>