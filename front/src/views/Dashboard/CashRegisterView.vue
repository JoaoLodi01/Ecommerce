<template>

    <h2>Caixa</h2>

    <form @submit.prevent="submitForm">
        @csrf

        <label>Descrição:</label>
        <input type="text" v-model="form.description" placeholder="Inserir...">

        <label>Valor de entrada:</label>
        <input type="number" v-model="form.valor_entrada" placeholder="Inserir...">

        <label>Valor de saída:</label>
        <input type="number" v-model="form.valor_saida" placeholder="Inserir...">

        <button type="submit">Cadastrar</button>

    </form>

</template>

<script>
import axios from "axios";

export default {
    data(){
        return{
            form:{
                description: "",
                valor_entrada: "",
                valor_saida: "",
            },
        };
    },
    methods: {
        async submitForm(){
            try {
                const response = await axios.post("http://127.0.0.1:8000/api/create", this.form, {
                    headers: {
                        "Content-Type": "application/json",
                    },
                });

                console.log("Resposta da API:", response.data);
                alert("Cadastro realizado com sucesso!");
            } catch (error) {
                console.log("Erro ao cadastrar;", error);
                alert("Erro ao cadastrar.");
            }
        },
    },
};

</script>