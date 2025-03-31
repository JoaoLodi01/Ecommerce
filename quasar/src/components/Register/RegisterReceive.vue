<template>
    <div class="max-w-md mx-auto mt-10 p-6 bg-white shadow-md rounded">
        <h2 class="text-xl font-semibold mb-4">Movimento Financeiro</h2>
        
        <form @submit.prevent="submitForm">
    
          <label for="client">Cliente:</label>
          <input 
          type="text" 
          v-model="form.client" 
          id="client" 
          placeholder="Inserir..."/>
    
          <label for="cpf">CPF:</label>
          <input 
          type="text" 
          v-model="form.cpf" 
          id="cpf" 
          placeholder="Inserir..."/>
    
          <label for="cnpj">CNPJ:</label>
          <input 
          type="text" 
          v-model="form.cnpj" 
          id="cnpj" 
          placeholder="Inserir..."/>
    
          <label for="email">E-mail:</label>
          <input 
          type="email" 
          v-model="form.email" 
          id="email" 
          placeholder="Inserir..."/>
    
          <label for="phone">Fone:</label>
          <input 
          type="number" 
          v-model="form.phone" 
          id="phone" 
          placeholder="Inserir..."/>
        </form>
        <div class="inline-flex">
            <button
                class="bg-slate-600 text-white p-1 mr-5 rounded-lg"
                @click="showReceiveView = !showReceiveView">Fechar
            </button>
            <button
                class="bg-slate-600 text-white p-1 mr-5 rounded-lg"
                @click="">Cadastrar
            </button>
        </div>
        
    </div>
</template>
    
<script>
    import axios from "axios";
    import ToReceiveView from 
    
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
        showReceiveView: false,
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

    components: {
        ToReceiveView
    },
    };
</script>