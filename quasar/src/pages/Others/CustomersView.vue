<template>
    <div 
        class="ml-14 h-max w-full"
        :class="{
            'relative top-12': widthScreen <= 1080
        }"    
    >
        <div>
            <h1 class="text-3xl font-semibold mb-6 pt-2 ml-2">Clientes</h1>
            <div class="mb-5">
                <ReportCustomer
                    v-if="showReportCustomer"
                    :widthScreen="widthScreen"
                />

            </div>
            
            <button 
                v-if="!showUpdateCustomers, showCustomers"
                @click="openRegister()"
                :class="{
                    'w-44 p-1 mr-5': widthScreen <= 1080,
                    'w-72': widthScreen > 1080
                }"
                class="py-2 absolute right-0 top-2 bg-gray-800 text-white font-semibold rounded-lg hover:bg-gray-500 transition">
                <span>Cadastrar um novo cliente</span>
                
            </button>

            <button 
                v-else
                @click="closeRegister()"
                :class="{
                    'w-44 p-1 mr-5': widthScreen <= 1080
                }"
                class="w-72 py-2 absolute right-0 top-2 bg-gray-800 text-white font-semibold rounded-lg hover:bg-gray-500 transition"
            >
                <span>Voltar</span>
            </button>
        </div>
    </div>
  
    <div 
        class="customer-grid grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 mb-8 ml-14" 
        v-if="showCustomers"
        :class="{
            'relative right-2 top-10': widthScreen <= 1080
        }"    
    >
        <div
            v-for="(customer, id) in customers" :key="id" 
            class="bg-white p-6 shadow-lg rounded-lg border border-gray-200 transition-transform hover:-translate-y-3 cursor-pointer"
            @click="editCustomer(customer.id, customer.name)"
        >
        <div>
            <div class="text-sm text-gray-500 mb-2">
                <span class="font-semibold">ID:</span> {{ customer.id }}
            </div>

            <div class="text-sm text-gray-500 mb-2">
                <span class="font-semibold">Cliente:</span> {{ customer.name }}
            </div>

            <div class="text-sm text-gray-500 mb-2" v-if="customer.cpf">
                <span class="font-semibold">CPF:</span> {{ customer.cpf.replace(/(\d{3})(\d{3})(\d{3})(\d{2})/, '$1.$2.$3-$4') }}
            </div>

            <div class="text-sm text-gray-500 mb-2" v-if="customer.cnpj">
                <span class="font-semibold">CNPJ:</span> {{ customer.cnpj.replace(/(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})/, '$1.$2.$3/$4-$5') }}
            
            </div>

            <div class="text-sm text-gray-500 mb-2">
               <span class="font-semibold">Número:</span> {{ customer.number }}
            </div>

            <div class="text-sm text-gray-500 mb-2">
               <span class="font-semibold">Status:</span> {{ customer.active === 1 ? 'Ativo' : 'Inativo' }}
            </div>
            
            <!-- Ações -->
            <div class="flex space-x-2" >
                <q-btn
                    @click="editCustomer(customer.id, customer.name)"
                    class="px-4 py-2 rounded-lg  transition"
                    :disabled=!customer.active
                    :class="{
                        'text-gray-400 bg-slate-500': !customer.active,
                        'text-blue-500 bg-blue-100 hover:bg-blue-200': customer.active,
                    }"    
                >
                    Editar
                </q-btn>
                <q-btn
                    @click="deleteCustomer(customer.id)"
                    class="px-4 py-2 rounded-lg transition"
                    :disabled=!customer.active
                    :class="{
                        'text-gray-400 bg-slate-500': !customer.active,
                        'text-red-500 bg-red-100 hover:bg-red-200': customer.active,
                    }"    
                    v-if="customer.active"
                >
                    Excluir
                </q-btn>
                <q-btn
                    v-else
                    class="px-4 py-2 rounded-lg transition"
                    :class="{
                        'text-gray-400 bg-slate-500': !customer.active
                    }"
                    @click="activeCustomer(customer.id)"
                >   
                    Ativar
                </q-btn>
            </div>
        </div> <!-- For acaba aqui-->
      </div>
    </div>

    <div class="mb-8" v-if="!showCustomers">
        <RegisterCustomer
            v-if="showRegisterCustomers"
            @close="closeReload($event)"
            :widthScreen="widthScreen"
            
        />

        <UpdateCustomer
            v-if="showUpdateCustomers"
            :customerID="customerID"
            :customerName="customerName"
            :widthScreen="widthScreen"
            @close="closeReload($event)"
        />
    </div>
</template>
  
<script>
    import { api } from 'src/boot/axios';
    import RegisterCustomer from 'src/components/Register/Customers/RegisterCustomer.vue';
    import UpdateCustomer from 'src/components/Register/Customers/UpdateCustomer.vue';
    import ReportCustomer from 'src/components/Reports/Customers/ReportCustomer.vue';

    export default {
        data() {
            return {
                customers: [],
                showCustomers: true,
                showRegisterCustomers: false,
                showUpdateCustomers: false,
                showReportCustomer: true,
                customerID: '',
                customerName: '',
                widthScreen: 0                
            };
        },

        mounted(){
            this.getCustomers();
            this.widthScreen += screen.width

        },

        methods: {
            async getCustomers() {
                const response = await api.get('/customers/all');
                this.customers = response.data.data;
                console.log(this.customers)
            },

            async deleteCustomer(id)
            {
                const response = await api.delete(`/customers/${id}/deactivate`)
                console.log(response.data)
                window.location.reload()

            },

            async activeCustomer(id)
            {
                const response = await api.put(`/customers/${id}/active`)
                console.log(response.data)
                window.location.reload()

            },

            openRegister()
            {
                this.showRegisterCustomers = true
                this.showUpdateCustomers = false
                this.showCustomers = false
                this.showReportCustomer = false
                console.log('showRegisterCustomers', this.showRegisterCustomers, ' this.showUpdateCustomers', this.showUpdateCustomers)
            
            },  

            closeRegister()
            {
                console.log('Chamou closeRegister')
                this.showRegisterCustomers = false
                this.showUpdateCustomers = false
                this.showCustomers = true
                this.showReportCustomer = true
            },

            closeReload(event)
            {
                this.showUpdateCustomers = event
                this.showRegisterCustomers = event
                window.location.reload()
            },

            editCustomer(id, name)
            {
                this.showUpdateCustomers = true
                this.showCustomers = false
                this.showRegisterCustomers = false
                this.showReportCustomer = false
                this.customerID = id
                this.customerName = name

            }
        },

        components: {
            RegisterCustomer,
            ReportCustomer,
            UpdateCustomer

        }
    };
</script>

<style>
    .customer-grid {
        width: 83%;
        padding: 5px;
    }
</style>