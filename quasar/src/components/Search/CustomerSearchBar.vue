<template>
    <div class="">
        <input 
            v-model="clientsData.name"
            @click="setClient(clientsData)"
            @input="selectClient()"
            placeholder="Consumidor Padrão"
            class="text-black border border-black w-full"
            :disabled="!fillter"
        />
            <ul 
                v-if="filteredClients.length > 0 && clientsData.name !== ''" 
                class="fixed z-50 p-3 bg-white border border-gray-300 mt-1 transition-transform"
            >
                <li
                    v-for="client in filteredClients "
                    :key="client.id"
                    @click="setClient(client)"
                    class="p-2 hover:bg-gray-200 cursor-pointer"
                >
                {{ client.name }}

                </li>

                <li 
                    v-if="message"
                    class="p-2 hover:bg-gray-200 cursor-pointer"
                >
                    {{ message }}
                </li>
            </ul>
    </div>
</template>

<script>
    import { api } from 'src/boot/axios';
    import { toRaw } from 'vue';
        
    export default {    
        mounted()
        {
            const getConfig = async () => {
                const response = await api.get('/config/all-configs')
                this.fillter = response.data.configPDV[0].filter_search_customer
            }    
            getConfig()
            
        },

        data()
        {
            return {
                clientsData: {
                    id: null,
                    name: ''
                },

                fillter: '',
                message: '',
                filteredClients: [],

            }
        },

        methods: {
            async selectClient(){
                if(this.clientsData.name.length > 0)
                {
                    const response = await api.post('/customers/search', {
                        fillter: this.fillter,
                        search: this.clientsData.name
                    });

                    this.clients = toRaw(response.data);
                    typeof response.data === 'string' ? this.message = response.data : this.filterClients()

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