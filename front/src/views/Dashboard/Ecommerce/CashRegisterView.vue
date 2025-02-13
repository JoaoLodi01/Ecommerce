<template>
    <div class="cashRegister-container">
        <h2>Caixa</h2>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Descrição</th>
                    <th>Entrada</th>
                    <th>Saída</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="cash in cashs" :key="cash.id">
                    <td>{{ cash.id }}</td>
                    <td>{{ cash.description }}</td>
                    <td>{{ cash.valor_entrada ? Number(cash.valor_entrada).toFixed(2) : '0.00' }}</td>
                    <td>{{ cash.valor_saida ? Number(cash.valor_saida).toFixed(2) : '0.00' }}</td>
                    <td>
                        <button @click="editCash(cash)">Editar</button>
                        <button @click="deleteCash(cash.id)">Excluir</button>
                    </td>
                </tr>
            </tbody>
        </table>

        <form @submit.prevent="submitForm">

            <label>Descrição:</label>
            <input type="text" v-model="cash.description" placeholder="Inserir...">

            <label>Valor de entrada:</label>
            <input type="number" v-model="cash.valor_entrada" placeholder="Inserir...">

            <label>Valor de saída:</label>
            <input type="number" v-model="cash.valor_saida" placeholder="Inserir...">

            <button type="submit">Cadastrar</button>

        </form>
    </div>
</template>

<script>
import axios from "axios";

export default {
    data(){
        return{
            cash:{
                description: "",
                valor_entrada: "",
                valor_saida: "",
            },
            cashs: [],
        api: process.env.VUE_APP_API_URL_ECOMMERCE
        };
    },
    methods: {
        async submitForm(){
            try {
                if (!this.cash.description || !this.cash.valor_entrada && !this.cash.valor_saida){
                    alert("Descrição e pelo menos um valor (entrada ou saída) são obrigatórios!");
                    return;
                }

                const response = await axios.post(`${this.api}/cashRegister/create`, this.cash, {
                    headers: {
                        "Content-Type": "application/json",
                    },
                });

                this.cashs.push({ ...this.cash});
                this.cash = {
                    description: "",
                    valor_entrada: "",
                    valor_saida: "",
                }

                console.log("Resposta da API:", response.data);
                alert("Cadastro realizado com sucesso!");
            } catch (error) {
                console.log("Erro ao cadastrar:", error);
                alert("Erro ao cadastrar!");
            }
        },
    },
};

</script>
