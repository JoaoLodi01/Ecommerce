<template>
    <div class="max-w-md mx-auto mt-10 p-6 bg-white shadow-md rounded">
      <h2 class="text-xl font-semibold mb-4">Cadastro de Cliente</h2>
      
      <form @submit.prevent="submitForm">

        <label for="client">Cliente:</label>
        <input type="text" v-model="form.client" id="client" placeholder="Inserir..."/>

        <label for="cpf">CPF:</label>
        <input type="text" v-model="form.cpf" id="cpf" placeholder="Inserir..."/>

        <label for="cnpj">CNPJ:</label>
        <input type="text" v-model="form.cnpj" id="cnpj" placeholder="Inserir..."/>

        <label for="email">E-mail:</label>
        <input type="email" v-model="form.email" id="email" placeholder="Inserir..."/>

        <label for="phone">Fone:</label>
        <input type="number" v-model="form.phone" id="phone" placeholder="Inserir..."/>

      </form>
  
      <p v-if="successMessage" class="mt-4 text-green-600">{{ successMessage }}</p>
      <p v-if="errorMessage" class="mt-4 text-red-600">{{ errorMessage }}</p>
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
<<<<<<< HEAD
        api: process.env.VUE_APP_API_URL,
        successMessage: null,
        errorMessage: null,
=======
        api: process.env.VUE_APP_API_URL_ECOMMERCE,
>>>>>>> ed74b4d82398334675d78bbebc8bf89143368377
      };
    },
    methods: {
      async submitForm() {
        try {
          const response = await axios.post(`${this.api}/consumers/create`, this.form);
          this.form = { cliente: "", cpf: "", cnpj: "", email: "", phone: "" };
          
        } catch (error) {
          this.successMessage = null;
          if (error.response && error.response.data.errors) {
            this.errorMessage = Object.values(error.response.data.errors).flat().join(", ");
          } else {
            this.errorMessage = "Ocorreu um erro ao cadastrar o cliente.";
          }
        }
      },
    },
  };
  </script>