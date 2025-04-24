<template>
    <div class="flex">
        <div class="">
            <div class="text-sm" v-if="pdv">
                <q-checkbox
                    size="1.6rem"
                    label="Cliente cadastrado"
                    v-model="registredCustomer"
                    color="grey"
                    @vue:updated="watchRegistredCustomer()"

                />

            </div>

            <q-input 
                v-model="clientsData.name"
                @click="setClient(clientsData)"
                @update:model-value="selectClient()"
                class="w-96"
                color="grey"
                :disabled="!fillter"

            />
        
        </div>
    
            <ul 
                v-if="filteredClients.length > 0 && clientsData.name !== ''" 
                class="fixed z-50 p-3 bg-white border border-gray-300 mt-14"
            >
                <li
                    v-for="client in filteredClients "
                    :key="client.id"
                    @click="setClient(client)"
                    class="p-2 hover:bg-gray-200 cursor-pointer"
                >
                    {{client.id}} - {{ client.name }}

                </li>
            </ul>
    </div>
</template>

<script>
    import { api } from 'src/boot/axios';
    import { toRaw } from 'vue';
        
    export default {    
        props: {
            pdv: {
                type: Boolean
            }
        },

        mounted()
        {
            const getConfig = async () => {
                const response = await api.get('/config/all-configs')
                this.fillter = response.data.configPDV[0].filter_search_customer
            }    
            getConfig()
            
            this.clientsData.name = this.defaultCustomer.name

        },

        data()
        {
            return {
                defaultCustomer: {
                    id: 1,
                    name: 'Consumidor Padrão'
                },

                clientsData: {
                    id: 0,
                    name: ''
                },
                
                registredCustomer: false,
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

            watchRegistredCustomer()
            {
                if(this.registredCustomer)
                {
                    this.clientsData.name = ''
                    
                } else {
                    this.clientsData.name = this.defaultCustomer.name

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