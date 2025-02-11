<template>
    <div class="max-w-md mx-auto mt-10 p-6 bg-white shadow-md rounded">
      <h2 class="text-xl font-semibold mb-4">Cadastro de Cliente</h2>
      <form @submit.prevent="submitForm">
        <div class="mb-4">
          <label for="name" class="block text-sm font-medium text-gray-700">Nome:</label>
          <input
            type="text"
            id="name"
            v-model="form.cliente"
            class="mt-1 block w-full p-2 border rounded-md"
            placeholder="Digite o nome"
          />
        </div>
  
        <div class="mb-4">
          <label for="cpf" class="block text-sm font-medium text-gray-700">CPF:</label>
          <input
            type="text"
            id="cpf"
            v-model="form.cpf"
            class="mt-1 block w-full p-2 border rounded-md"
            placeholder="Digite o CPF"
          />
        </div>
  
        <div class="mb-4">
          <label for="cnpj" class="block text-sm font-medium text-gray-700">CNPJ:</label>
          <input
            type="text"
            id="cnpj"
            v-model="form.cnpj"
            class="mt-1 block w-full p-2 border rounded-md"
            placeholder="Digite o CNPJ"
          />
        </div>
  
        <div class="mb-4">
          <label for="email" class="block text-sm font-medium text-gray-700">E-mail:</label>
          <input
            type="email"
            id="email"
            v-model="form.email"
            class="mt-1 block w-full p-2 border rounded-md"
            placeholder="Digite o e-mail"
          />
        </div>
  
        <div class="mb-4">
          <label for="phone" class="block text-sm font-medium text-gray-700">Telefone</label>
          <input
            type="text"
            id="phone"
            v-model="form.phone"
            class="mt-1 block w-full p-2 border rounded-md"
            placeholder="Digite o telefone"
          />
        </div>
  
        <button
          type="submit"
          class="w-full bg-blue-600 text-white py-2 px-4 rounded hover:bg-blue-700"
        >
          Cadastrar
        </button>
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
        api: process.env.VUE_APP_API_URL,
        successMessage: null,
        errorMessage: null,
      };
    },
    methods: {
      async submitForm() {
        try {
          const response = await axios.post(`${api}/consumers/create`, this.form);
          this.successMessage = response.data.message;
          this.errorMessage = null;
          this.form = { cliente: "", cpf: "", cnpj: "", email: "", phone: "" }; // Reseta o formulário
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
  
  <style>
  body {
    font-family: Arial, sans-serif;
    background-color: #f3f4f6;
  }
  </style>