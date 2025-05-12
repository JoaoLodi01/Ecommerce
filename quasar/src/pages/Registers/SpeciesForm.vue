<template>
    <div class="container mx-auto mt-10 p-6 ml-16 bg-white rounded-lg shadow-lg">
        <div class="flex justify-between items-center mb-6">
            <h2 class="text-2xl font-semibold">Espécies</h2>
            <div class="flex space-x-4">
                <q-btn
                    class="bg-blue-500 text-white p-2 rounded-lg"
                    @click="showSpeciesRegister = !showSpeciesRegister"
                    label="Cadastrar"
                />
            </div>
        </div>

        <div>
            <table class="overflow-x-auto min-w-full table-auto border-collapse border border-gray-200">
                <thead>
                    <tr class="bg-gray-200">
                        <th>Cód.</th>
                        <th>Espécie</th>
                        <th>Tipo Lançamento</th>
                        <th>Ativo</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(specie, id) in species" :key="id">
                        <td class="">{{ specie.id }}</td>
                        <td class="">{{ specie.especie }}</td>
                        <td class="">{{ specie.tipo_lancamento }}</td>
                        <td class="">{{ specie.active }}</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</template>

<script>
    import { api } from 'src/boot/axios';
    import { LocalStorage } from 'quasar';

    export default {
        data(){
            return{
                species: [],
                showSpeciesRegister: false,
            }
        },  

        methods: {
            async getRegisters(){
                try {
                    const response = await api.get(`/payments/all/${LocalStorage.getItem("issuer_id")}`)
                    this.species = response.data

                } catch (error) {
                    console.error("Erro ao buscar os registros: ", error)
                }   
            }
        },
    }
</script>