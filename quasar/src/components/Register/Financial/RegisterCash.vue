<template>
    <div class="max-w-md mx-auto mt-10 p-6 bg-white shadow-md rounded">
        <h2 class="text-xl font-semibold mb-4">Registro Financeiro</h2>
        
        <form  
            @submit.prevent="submitForm"
            @reset="onReset">
    
        <q-input
        type="text"
        v-model="form.description"
        label="Descrição"
        color="grey-7"
        />

    
        <q-input
        type="text"
        v-model="form.name"
        label="Cliente"
        color="grey-7"
        />

        <q-input
        type="text"
        v-model="form.user"
        label="Usuário"
        color="grey-7"
        readonly
        />
    
        <q-input
        type="text"
        v-model="form.especie"
        label="Espécie"
        color="grey-7"
        />

        <q-input 
        type="number" 
        v-model="form.total_amount" 
        label="Total"
        color="grey-7"
        />
    
          <button
            type="submit"
            class="bg-slate-600 text-white p-1 mr-5 rounded-lg">
            Cadastrar
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
            especie: "",
            total_amount: ""
        },
        api: process.env.VUE_APP_API_URL_ECOMMERCE,
        };
    },
    methods: {
        onReset(){
            this.form = {
                description: "",
                name: "",
                user: "",
                especie: "",
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