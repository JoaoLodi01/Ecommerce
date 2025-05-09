<template>
    <div class="container mx-auto mt-10 p-6 ml-16 bg-white rounded-lg shadow-lg">
        <div class="flex justify-between items-center mb-6">
            <h2 class="text-2xl font-semibold">Listagem espécies</h2>
            <div class="flex space-x-4">
                <q-btn
                    class="bg-blue-500 text-white p-1 mr-5 rounded-lg"
                    @click="showRegisterUsers = !showRegisterUsers"
                    label="Cadastrar"
                />
            </div>
        </div>

        <div class="table">
            <table class="overflow-x-auto min-w-full table-auto border-collapse border border-gray-200">
                <thead class="bg-gray-100">
                    <tr>
                        <th scope="col" class="px-6 py3">Código</th>
                        <th scope="col" class="px-6 py3">Nome</th>
                        <th scope="col" class="px-6 py3">Acesso</th>
                    </tr>
                </thead>
                <tbody>
                    <tr class="border border-b-black" v-for="(user, id) in users" :key="id">
                        <td class="px-6 py-3">{{ user.id }}</td>
                        <td class="px-6 py-3">{{ user.name }}</td>
                        <td class="px-6 py-3">{{ user.access }}</td>
                        <td class="px-6 py-3">
                            <q-btn @click="editUser(user)" class="">
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="m16.862 4.487 1.687-1.688a1.875 1.875 0 1 1 2.652 2.652L10.582 16.07a4.5 4.5 0 0 1-1.897 1.13L6 18l.8-2.685a4.5 4.5 0 0 1 1.13-1.897l8.932-8.931Zm0 0L19.5 7.125M18 14v4.75A2.25 2.25 0 0 1 15.75 21H5.25A2.25 2.25 0 0 1 3 18.75V8.25A2.25 2.25 0 0 1 5.25 6H10" />
                                </svg>
                            </q-btn>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</template>

<script>
    import { api } from "src/boot/axios";
    import { LocalStorage } from "quasar";

    export default {
        data(){
            return{
                users: [],
                showRegisterUsers: false,
                showUpdateUsers: false,
            }
        },

        methods: {
            async getUsers(){
                try {
                    const response = await api.get(`/users/all/${LocalStorage.getItem("issuer_id")}`)
                    this.users = response.data;

                    Console.log('Busca concluída: '. $users);
                } catch (error) {
                    if (!this.users || this.users === 0){
                        alert('Nenhuma informação encontrada!');
                    } else {
                        console.error('Erro na requisição: '. error);
                    }
                }
            },

            editUser(){
                this.showUpdateUsers = true
            },

        },
    }

</script>