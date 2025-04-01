<template>
    <div class="max-w-md mx-auto mt-10 p-6 bg-white shadow-md rounded">
        <h2 class="text-xl font-semibold mb-4">Registro Financeiro</h2>
        
        <form @submit.prevent="submitForm">
    
          <label for="description">Descrição:</label>
          <input 
          type="text" 
          v-model="form.description" 
          id="description" 
          placeholder="Inserir..."
          class=""/>
    
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
          type="text" 
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
          <select 
            v-model="form.type_interest" 
            id="especie">
            <option disabled value="">Selecionar...</option>
            <option value="especie1">%</option>
            <option value="especie2">R$</option>
          </select>

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
          
          <button 
            type="submit"
            class="bg-slate-600 text-white p-1 mr-5 rounded-lg">
            Cadastrar
          </button>
          <button>
            
          </button>
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
            resetform(){
                this.form = {
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
                }
            },

            async submitForm() {
                try {
                    const response = await axios.post(`${this.api}`, this.form); // Lembrar de criar rota e inserir aqui
                    this.resetform();
                    console.log('Dados enviados!', response.data)
                } catch (error) {
                    alert("Ocorreu um erro ao cadastrar o registro")
                }
            },
        },
      };
      </script>
