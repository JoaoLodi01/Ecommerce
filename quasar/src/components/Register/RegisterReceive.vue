<template>
    <div class="max-w-md mx-auto mt-10 p-6 bg-white shadow-md rounded">
        <h2 class="text-xl font-semibold mb-4">Registro Financeiro</h2>
        
        <form @submit.prevent="submitForm">
    
          <label for="description">Descrição:</label>
          <input 
          type="text" 
          v-model="form.description" 
          id="description" 
          placeholder="Inserir..."/>
    
          <label for="name">Cliente:</label>
          <input 
          type="text" 
          v-model="form.name" 
          id="name" 
          placeholder="Inserir..."/>

          <label for="user">Usuário:</label>
          <input 
          type="text" 
          v-model="form.user" 
          id="user" 
          placeholder="Inserir..."/>
    
          <label for="especie">Especie:</label>
          <input 
          type="select" 
          v-model="form.especie" 
          id="especie" 
          placeholder="Inserir..."/>
    
          <label for="due_date">Data de Vencimento:</label>
          <input 
          type="date" 
          v-model="form.due_date" 
          id="due_date" 
          placeholder="Inserir..."/>
    
          <label for="installment_number">Número de parcelas:</label>
          <input 
          type="number" 
          v-model="form.installment_number" 
          id="installment_number" 
          placeholder="Inserir..."/>

          <label for="installment_value">Valor das parcelas:</label>
          <input 
          type="number" 
          v-model="form.installment_value" 
          id="installment_value" 
          placeholder="Inserir..."/>

          <label for="type_interest">Tipo juros:</label>
          <input
          type="select" 
          v-model="form.type_interest" 
          id="type_interest" 
          placeholder="Inserir..."/>

          <label for="interest_value">Valor juros:</label>
          <input 
          type="number" 
          v-model="form.interest_value" 
          id="interest_value" 
          placeholder="Inserir..."/>

          <label for="total_amount">Total:</label>
          <input 
          type="number" 
          v-model="form.total_amount" 
          id="total_amount" 
          placeholder="Inserir..."/>
    
        </form>
      </div>
    </template>
    
    <script>
      import axios from "axios";
      
      export default {
        data() {
          return {
            form: {
                description: "",
                name: "",
                user: "",
                cpf: "",
                especie: "",
                due_date: "",
                installment_number: "",
                installment_value: "",
                type_interest: "",
                interest_value: "",
                total_amount: ""
            },
            api: process.env.VUE_APP_API_URL_ECOMMERCE,
          };
        },
        methods: {
          
        },
      };
      </script>