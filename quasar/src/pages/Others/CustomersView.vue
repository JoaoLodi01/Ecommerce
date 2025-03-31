<template>
  <div class="clientes-container px-20">
    <h1 class="text-3xl font-semibold mb-6 pt-2">Clientes</h1>
    <button 
      @click="toggleRegisterClientVisibility"
      class="w-96 py-2 absolute right-2 top-2 bg-gray-800 text-white font-semibold rounded-lg hover:bg-gray-500 transition">
      <span v-if="!showRegisterClients">Cadastrar</span>
      <span v-else>Voltar</span>
    </button>
  <!-- GRID CLIENTES -->
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 mb-8" v-if="showClients">
      <div
        v-for="(client, id) in clients" :key="id" 
        class="bg-white p-6 shadow-lg rounded-lg border border-gray-200"
    >
        <div>
            <div class="text-sm text-gray-500 mb-2">
                <span class="font-semibold">ID:</span> {{ client.id }}
            </div>

            <div class="text-sm text-gray-500 mb-2">
                <span class="font-semibold">Cliente:</span> {{ client.name }}
            </div>

            <div class="text-sm text-gray-500 mb-2" v-if="client.cpf">
              <span class="font-semibold">CPF:</span> {{ client.cpf.replace(/(\d{3})(\d{3})(\d{3})(\d{2})/, '$1.$2.$3-$4') }}
            </div>

            <div class="text-sm text-gray-500 mb-2" v-if="client.cnpj">
               <span class="font-semibold">CNPJ:</span> {{ client.cnpj.replace(/(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})/, '$1.$2.$3/$4-$5') }}
            
            </div>

            <div class="text-sm text-gray-500 mb-2">
               <span class="font-semibold">Número:</span> {{ client.number }}
            </div>

            <div class="text-sm text-gray-500 mb-2">
               <span class="font-semibold">Status:</span> {{ client.active === 1 ? 'Ativo' : 'Inativo' }}
            </div>
            

            <!-- Ações -->
            <div class="flex space-x-2" >
                <button
                    @click="editClient(client)"
                    class="px-4 py-2 rounded-lg hover:bg-blue-200 transition"
                    :class="{
                        'text-gray-400 bg-slate-500': !client.active,
                        'text-blue-500 bg-blue-100': client.active,
                    }"    
                >
                    Editar
                </button>
                <button
                    @click="deleteClient(client.id)"
                    class="px-4 py-2 rounded-lg hover:bg-red-200 transition"
                    :class="{
                        'text-gray-400 bg-slate-500': !client.active,
                        'text-red-500 bg-red-100': client.active,
                    }"    
                >
                    Excluir
                </button>
            </div>
        </div>
      </div>
    </div>
    
  </div>
</template>
  
<script>
    import { api } from 'src/boot/axios';

    export default {
        data() {
        return {
                clients: [],
                showClients: true,
                showRegisterClients: false,
            };
        },

        mounted(){
            this.getClients();
        },

        methods: {
            async getClients() {
                const response = await api.get('/customers/all');
                console.log(response);
                this.clients = response.data.data;
            },

            async deleteClient(id)
            {
                const response = await api.delete(`/customers/${id}/deactivate`)
                console.log(response.data)
            }
        },
    };
</script>