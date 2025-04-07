<template>
    <label class="text-black" for="client">Cliente</label>
    <input 
        v-model="clientsData.name"
        @click="setClient(clientsData)"
        @input="selectClient()"
        placeholder="Consumidor Padrão"
        class="text-black border border-black w-full"
    />
    <ul v-if="filteredClients.length > 0" class=" border border-gray-300 rounded mt-1">
        <li
            v-for="client in filteredClients"
            :key="client.id"
            @click="setClient(client)"
            class="fixed bg-black text-white z-50 p-3 hover:bg-gray-200 cursor-pointer"
        >
        {{ client.name }}

        </li>
    </ul>
</template>

<script>
    import { api } from 'src/boot/axios';
    import { toRaw } from 'vue';
        
    export default {    
        data()
        {
            return {
                clientsData: {
                    id: null,
                    name: ''
                },

                filteredClients: [],
            }
        },

        methods: {
            async selectClient(){
                if(this.clientsData.name.length > 0)
                {
                    const response = await api.post('/customers/search', {
                        search: this.clientsData.name
                    });
                    
                    this.clients = toRaw(response.data);
                    this.filterClients()
                }

            },

            filterClients(){
                this.filteredClients = this.clients.filter(client =>
                    client.name.toLowerCase()
                );

            },

            setClient(client){
                this.clientsData.id = client.id;
                this.clientsData.name = client.name;
                this.$emit('update:selectCustomer', this.clientsData)
                this.clients = []
                this.filteredClients = [];
                
            },            
        }
    }
</script>