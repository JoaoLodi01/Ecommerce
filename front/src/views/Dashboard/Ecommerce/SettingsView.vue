<template>

    <h2>Configurações:</h2>

    <form @submit.prevent="submitForm">

        <input type="checkbox" id="address_by_cep" v-model="form.address_by_cep"/>
        <label for="address_by_cep">Endereço pelo CEP</label>

        <label for="room_service_limit">Limite de gastos por serviço de quarto:</label>
        <input type="text" id="room_service_limit" v-model="form.room_service_limit"/>

        <button type="submit">Salvar</button>
        
    </form>

</template>

<script>
import axios from "axios";

export default {
    data() {
        return{
            form:{
                address_by_cep: false,
                room_service_limit: 0,
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

                alert("Configurações salvas com sucesso!")
            } catch (error) {
                console.log("Erro ao salvar:", error)
                alert("Erro ao salvar.") + (error.response?.data?.message || error.message)
            }
        }
    }
}

</script>