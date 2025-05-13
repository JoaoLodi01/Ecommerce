<template>
    <div
        class="ml-20 mb-6"
          
    >
        <div
            class="flex"
            :class="{
                'div1': widthScreen > 1080
            }"
        >
            <h1 class="text-3xl font-semibold m-5 border border-b-gray-300">Clientes</h1>

            <div 
                class="mt-auto mb-auto"
                :class="{
                    'ml-auto': widthScreen > 1366
                }"
            >
                <q-btn 
                    class="bg-blue-500 hover:bg-blue-400 transition text-white font-semibold rounded-lg"
                    @click="showConfig = !showConfig" 
                >
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor" class="w-6 h-6">
                        <path fill-rule="evenodd" d="M6.455 1.45A.5.5 0 0 1 6.952 1h2.096a.5.5 0 0 1 .497.45l.186 1.858a4.996 4.996 0 0 1 1.466.848l1.703-.769a.5.5 0 0 1 .639.206l1.047 1.814a.5.5 0 0 1-.14.656l-1.517 1.09a5.026 5.026 0 0 1 0 1.694l1.516 1.09a.5.5 0 0 1 .141.656l-1.047 1.814a.5.5 0 0 1-.639.206l-1.703-.768c-.433.36-.928.649-1.466.847l-.186 1.858a.5.5 0 0 1-.497.45H6.952a.5.5 0 0 1-.497-.45l-.186-1.858a4.993 4.993 0 0 1-1.466-.848l-1.703.769a.5.5 0 0 1-.639-.206l-1.047-1.814a.5.5 0 0 1 .14-.656l1.517-1.09a5.033 5.033 0 0 1 0-1.694l-1.516-1.09a.5.5 0 0 1-.141-.656L2.46 3.593a.5.5 0 0 1 .639-.206l1.703.769c.433-.36.928-.65 1.466-.848l.186-1.858Zm-.177 7.567-.022-.037a2 2 0 0 1 3.466-1.997l.022.037a2 2 0 0 1-3.466 1.997Z" clip-rule="evenodd" />
                    </svg>
                </q-btn>
            </div>

            <div
                class="mt-auto mb-auto"
                :class="{
                    'ml-auto': widthScreen > 1366
                }"
            >
                <q-btn
                    v-if="showCustomers"
                    @click="openRegister()"
                    class="bg-blue-500 text-white font-semibold rounded-lg hover:bg-blue-400 transition"
                >
                    <span 
                        
                        v-if="widthScreen <= 1080"
                    >
                        Novo cliente
                    </span>
                    <span v-else>Cadastrar um novo cliente</span>
                    
                </q-btn>

                <q-btn 
                    v-else
                    @click="closeRegister()"
                    class="bg-gray-800 text-white font-semibold rounded-lg hover:bg-gray-500 transition"
                >
                    <span>Voltar</span>

                </q-btn>

            </div>
        </div>
        <div 
            v-if="widthScreen > 1080" class="mt-2 ml-2"
        >
            <ReportCustomer
                v-if="showReportCustomer"
                :widthScreen="widthScreen"
            />

        </div>
        <div 
            v-else
            class="ml-5"
        >
            <q-btn 
                v-if="showReportCustomer"
                @click="openReportCustomerMini()"
                color="grey"
            >
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M9 12h3.75M9 15h3.75M9 18h3.75m3 .75H18a2.25 2.25 0 0 0 2.25-2.25V6.108c0-1.135-.845-2.098-1.976-2.192a48.424 48.424 0 0 0-1.123-.08m-5.801 0c-.065.21-.1.433-.1.664 0 .414.336.75.75.75h4.5a.75.75 0 0 0 .75-.75 2.25 2.25 0 0 0-.1-.664m-5.8 0A2.251 2.251 0 0 1 13.5 2.25H15c1.012 0 1.867.668 2.15 1.586m-5.8 0c-.376.023-.75.05-1.124.08C9.095 4.01 8.25 4.973 8.25 6.108V8.25m0 0H4.875c-.621 0-1.125.504-1.125 1.125v11.25c0 .621.504 1.125 1.125 1.125h9.75c.621 0 1.125-.504 1.125-1.125V9.375c0-.621-.504-1.125-1.125-1.125H8.25ZM6.75 12h.008v.008H6.75V12Zm0 3h.008v.008H6.75V15Zm0 3h.008v.008H6.75V18Z" />
                </svg>
                <svg v-if="showReportCustomerMini" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-5 ml-2">
                    <path stroke-linecap="round" stroke-linejoin="round" d="m19.5 8.25-7.5 7.5-7.5-7.5" />
                </svg>
                <svg v-else xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-5 ml-2">
                    <path stroke-linecap="round" stroke-linejoin="round" d="m4.5 15.75 7.5-7.5 7.5 7.5" />
                </svg>

            </q-btn>
            <div class="mt-4">
                <ReportCustomer
                    v-if="showReportCustomerMini"
                    :widthScreen="widthScreen"
                />

            </div>
        </div>
    </div>
  
    <div 
        class="customer-grid grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-5 gap-4 mb-8 ml-20" 
        v-if="showCustomers"
        :class="{
            'relative right-7 top-10': widthScreen <= 1080
        }"    
    >
        <div
            v-for="(customer, id) in customers" :key="id" 
            class="relative overflow-x-auto max-h-96 overflow-y-auto bg-white p-6 shadow-lg rounded-lg border border-gray-200 transition-transform hover:-translate-y-3 cursor-pointer"
            @click="editCustomer(customer.id, customer.name)"
        >
        <div>
            <div class="text-sm text-gray-500 mb-2">
                <span class="font-semibold">ID:</span> {{ customer.id }}
            </div>

            <div class="text-sm text-gray-500 mb-2">
                <span class="font-semibold">Cliente:</span> {{ customer.company_name }}
            </div>

            <div class="text-sm text-gray-500 mb-2" v-if="customer.cpf">
                <span class="font-semibold">CPF:</span> {{ customer.cpf.replace(/(\d{3})(\d{3})(\d{3})(\d{2})/, '$1.$2.$3-$4') }}
            </div>

            <div class="text-sm text-gray-500 mb-2" v-if="customer.cnpj">
                <span class="font-semibold">CNPJ:</span> {{ customer.cnpj.replace(/(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})/, '$1.$2.$3/$4-$5')}}
            
            </div>

            <div class="text-sm text-gray-500 mb-2">
               <span class="font-semibold">Endereço:</span> {{ customer.address ?? 'Sem endereço cadastrado' }}
            </div>

            <div class="text-sm text-gray-500 mb-2">
               <span class="font-semibold">Status:</span> {{ customer.active === 1 ? 'Ativo' : 'Inativo' }}
            </div>
            
            <!-- Ações -->
            <div class="flex space-x-2" >
                <q-btn
                    @click="editCustomer(customer.id, customer.name)"
                    class="px-4 py-2 rounded-lg transition"
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
                    Desativar
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

    <div v-if="!showCustomers" >
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

        <ConfigCustomers
            v-if="showConfig"

        />
        
    </div>
</template>
  
<script>
    import { LocalStorage } from 'quasar';
    import { api } from 'src/boot/axios';
    import ConfigCustomers from 'src/components/Config/ConfigCustomers.vue';
    import RegisterCustomer from 'src/components/Register/Customers/RegisterCustomer.vue';
    import UpdateCustomer from 'src/components/Register/Customers/UpdateCustomer.vue';
    import ReportCustomer from 'src/components/Reports/Customers/ReportCustomer.vue';

    export default {
        data() {
            return {
                customers: [],
                showCustomers: true,
                showReportCustomer: true,
                showReportCustomerMini: false,
                showRegisterCustomers: false,
                showConfig: false,
                showUpdateCustomers: false,
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
                const response = await api.get(`/customers/all/${LocalStorage.getItem("issuer_id")}`);
                console.log(response)
                this.customers = response.data.all;
                
            },

            async deleteCustomer(id)
            {
                const response = await api.delete(`/customers/${id}/deactivate`)
            
            },

            async activeCustomer(id)
            {
                const response = await api.put(`/customers/${id}/active`)
                
            },

            openRegister()
            {
                this.showRegisterCustomers = true
                this.showUpdateCustomers = false
                this.showCustomers = false
                this.showReportCustomer = false
                this.showReportCustomerMini = false
                
            },  

            closeRegister()
            {
                this.showCustomers = true
                this.showRegisterCustomers = false
                this.showUpdateCustomers = false
                this.showReportCustomer = false

            },

            openConfig()
            {
                this.showConfig = true
                this.showUpdateCustomers = false
                this.showCustomers = false
                this.showReportCustomer = false
            },

            openReportCustomerMini()
            {
                this.showReportCustomerMini = !this.showReportCustomerMini
            },

            closeRegister()
            {
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
            UpdateCustomer,
            ConfigCustomers

        }
    };
</script>

<style>
    .customer-grid {
        width: 100%;
        padding: 5px;
    }

    .div1 {
        width: 154%;
    }
</style>