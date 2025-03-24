<template>
<div class="max-w-md mx-auto mt-10 p-6 bg-white shadow-md rounded">
    <h2 class="text-xl font-semibold mb-4">Cadastro de Cliente</h2>
    
    <div class="max-w-md mx-auto mt-5 p-6 bg-white shadow-md rounded">
      <div>
        <label for="client">Cliente:</label>
        <input 
        type="text" 
        v-model="form.client" 
        id="client" 
        placeholder="Inserir..."
        class="mt-1 p-2 w-full border border-gray-300 rounded-lg"
        />
      </div>

      <div>
        <label for="cpf">CPF:</label>
        <input 
        type="text" 
        v-model="form.cpf" 
        id="cpf" 
        placeholder="Inserir..."
        class="mt-1 p-2 w-full border border-gray-300 rounded-lg"
        />
      </div>

      <div>
        <label for="cnpj">CNPJ:</label>
        <input 
        type="text" 
        v-model="form.cnpj" 
        id="cnpj" 
        placeholder="Inserir..."
        class="mt-1 p-2 w-full border border-gray-300 rounded-lg"
        />
      </div>

      <div>
        <label for="email">E-mail:</label>
        <input 
        type="email" 
        v-model="form.email" 
        id="email" 
        placeholder="Inserir..."
        class="mt-1 p-2 w-full border border-gray-300 rounded-lg"
        />
      </div>

      <div>
        <label for="phone">Fone:</label>
        <input 
        type="number" 
        v-model="form.phone" 
        id="phone" 
        placeholder="Inserir..."
        class="mt-1 p-2 w-full border border-gray-300 rounded-lg"
        />
      </div>
    </div>
  </div>
</template>

<script>
  import axios from "axios";
  
  export default {
    data() {
      return {
        form: {
          cliente: "",
          cpf: "",
          cnpj: "",
          email: "",
          phone: "",
        },
        api: process.env.VUE_APP_API_URL_ECOMMERCE,
      };
    },
    methods: {
      async submitForm() {
        try {
          const response = await axios.post(`${this.api}/consumers/create`, this.form);
          this.form = { cliente: "", cpf: "", cnpj: "", email: "", phone: "" };
        
        } catch (error) {
            alert("Ocorreu um erro ao cadastrar o cliente.");
        }
      },
    },
  };
  </script>