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

        <div v-if="showSpeciesRegister">
            <table class="overflow-x-auto min-w-full table-auto border-collapse border border-gray-200">
                <thead>
                    <tr class="bg-gray-200">
                        <th scope="col" class="px-6 py3">Código</th>
                        <th scope="col" class="px-6 py3">Espécie</th>
                        <th scope="col" class="px-6 py3">Tipo Lançamento</th>
                        <th scope="col" class="px-6 py3">Ações</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(specie, id) in species" :key="id">
                        <td scope="row" class="px-6 py-3 text-center">{{ specie.payment_cod }}</td>
                        <td scope="row" class="px-6 py-3 text-center">{{ specie.especie }}</td>
                        <td scope="row" class="px-6 py-3 text-center">{{ specie.tipo_lancamento }}</td>
                        <td scope="row" class="px-6 py-3 text-center">
                            <q-btn @click="editSpecie(specie)">
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="m16.862 4.487 1.687-1.688a1.875 1.875 0 1 1 2.652 2.652L10.582 16.07a4.5 4.5 0 0 1-1.897 1.13L6 18l.8-2.685a4.5 4.5 0 0 1 1.13-1.897l8.932-8.931Zm0 0L19.5 7.125M18 14v4.75A2.25 2.25 0 0 1 15.75 21H5.25A2.25 2.25 0 0 1 3 18.75V8.25A2.25 2.25 0 0 1 5.25 6H10" />
                                </svg>
                            </q-btn>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="" v-else>
            <RegisterSpecies/>

        </div>
    </div>
</template>

<script>
    import { api } from 'src/boot/axios';
    import RegisterSpecies from 'src/components/Register/Others/RegisterSpecies.vue';
    import { LocalStorage } from 'quasar';

    export default {
        data(){
            return{
                species: [],
                showSpeciesRegister: true,
                showUpdateUsers: false,
            }
        },  

        methods: {
            async getRegisters(){
                try {
                    const response = await api.get(`/species/all/${LocalStorage.getItem("issuer_id")}`)
                    this.species = response.data.all

                    console.log(response.data);

                } catch (error) {
                    console.error("Erro ao buscar os registros: ", error)
                }   
            },

            editSpecie(){
                this.showUpdateUsers = true
            },
        },

        mounted() {
            this.getRegisters()
        },

        components: {
            RegisterSpecies
        }
    }
</script>