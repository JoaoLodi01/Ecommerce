<template>
    <div v-if="_loanding">
        <LoandingPage
            @show-page="showPage($event)"
            :text="'Carregando clientes ...'"
        />

    </div>
    
    <div    
        v-if="!_loanding"
        :class="{
            'mt-10 p-6 ml-20 mb-5 bg-white rounded-lg shadow-lg w-[160vh]': widthScreen > 1366,
            'mt-10 ml-14 mr-6 mb-5 bg-white rounded-lg shadow-lg w-[120vh]': widthScreen <= 1680
            
        }"  
    >
        <div
            class="flex justify-between "

        >
            <h1 v-if="!showRegisterCustomers && !showUpdateCustomers" class="text-3xl font-semibold m-5">Clientes</h1>
            <h1 v-if="showRegisterCustomers" class="text-3xl font-semibold m-5">Novo cliente</h1>
            <h1 v-if="showUpdateCustomers" class="text-3xl font-semibold m-5">Edição de cliente</h1>
            
            <div 
                :class="{
                    'mt-5': widthScreen > 1366,
                    'mt-5 mr-5': widthScreen <= 1366
                }"
            >
                <q-btn
                    v-if="showCustomers"
                    @click="openRegister()"
                    :style="`background-color: ${buttonColor}; color: ${buttonColor === '#ffffff' ? '#000' : '#ffffff'}`"

                >
                    <span>Novo cliente</span>
                    
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
            class="mt-2 ml-2 flex"
            v-if="!showRegisterCustomers"
        >
            <q-btn 
                title="Opções"
                class="ml-2"
                :style="`background-color: ${buttonColor}; color: ${buttonColor === '#ffffff' ? '#000' : '#ffffff'}`"
                @click="openConfig()"
            >
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M9.594 3.94c.09-.542.56-.94 1.11-.94h2.593c.55 0 1.02.398 1.11.94l.213 1.281c.063.374.313.686.645.87.074.04.147.083.22.127.325.196.72.257 1.075.124l1.217-.456a1.125 1.125 0 0 1 1.37.49l1.296 2.247a1.125 1.125 0 0 1-.26 1.431l-1.003.827c-.293.241-.438.613-.43.992a7.723 7.723 0 0 1 0 .255c-.008.378.137.75.43.991l1.004.827c.424.35.534.955.26 1.43l-1.298 2.247a1.125 1.125 0 0 1-1.369.491l-1.217-.456c-.355-.133-.75-.072-1.076.124a6.47 6.47 0 0 1-.22.128c-.331.183-.581.495-.644.869l-.213 1.281c-.09.543-.56.94-1.11.94h-2.594c-.55 0-1.019-.398-1.11-.94l-.213-1.281c-.062-.374-.312-.686-.644-.87a6.52 6.52 0 0 1-.22-.127c-.325-.196-.72-.257-1.076-.124l-1.217.456a1.125 1.125 0 0 1-1.369-.49l-1.297-2.247a1.125 1.125 0 0 1 .26-1.431l1.004-.827c.292-.24.437-.613.43-.991a6.932 6.932 0 0 1 0-.255c.007-.38-.138-.751-.43-.992l-1.004-.827a1.125 1.125 0 0 1-.26-1.43l1.297-2.247a1.125 1.125 0 0 1 1.37-.491l1.216.456c.356.133.751.072 1.076-.124.072-.044.146-.086.22-.128.332-.183.582-.495.644-.869l.214-1.28Z" />
                    <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
                </svg>
            </q-btn> <!-- QBTB of config -->

            <div class="flex ml-5">
                <q-btn
                    @click="showReportCustomer = !showReportCustomer"
                    :style="`background-color: ${buttonColor}; color: ${buttonColor === '#ffffff' ? '#000' : '#ffffff'}`"
                    title="Relatórios"
                >
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6 ">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M9 12h3.75M9 15h3.75M9 18h3.75m3 .75H18a2.25 2.25 0 0 0 2.25-2.25V6.108c0-1.135-.845-2.098-1.976-2.192a48.424 48.424 0 0 0-1.123-.08m-5.801 0c-.065.21-.1.433-.1.664 0 .414.336.75.75.75h4.5a.75.75 0 0 0 .75-.75 2.25 2.25 0 0 0-.1-.664m-5.8 0A2.251 2.251 0 0 1 13.5 2.25H15c1.012 0 1.867.668 2.15 1.586m-5.8 0c-.376.023-.75.05-1.124.08C9.095 4.01 8.25 4.973 8.25 6.108V8.25m0 0H4.875c-.621 0-1.125.504-1.125 1.125v11.25c0 .621.504 1.125 1.125 1.125h9.75c.621 0 1.125-.504 1.125-1.125V9.375c0-.621-.504-1.125-1.125-1.125H8.25ZM6.75 12h.008v.008H6.75V12Zm0 3h.008v.008H6.75V15Zm0 3h.008v.008H6.75V18Z" />
                    </svg>

                    <!--Flechas-->
                    <svg v-if="!showReportCustomer" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                        <path stroke-linecap="round" stroke-linejoin="round" d="m8.25 4.5 7.5 7.5-7.5 7.5" />
                    </svg>

                    <svg v-if="showReportCustomer" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 19.5 8.25 12l7.5-7.5" />
                    </svg>

                </q-btn>
                
                <div class="ml-4">
                    <ReportCustomer
                        v-if="showReportCustomer"
                        :issuerID="issuerID"
                    />
                </div>
            </div>
            
            <div 
                class="ml-auto"
            >
                <q-option-group
                    v-model="searchFilter"
                    type="radio"
                    toggle
                    class="flex"
                    :options="[
                        {label: 'Todos', value: 'all'},
                        {label: 'Ativos', value: 'active'},
                        {label: 'Inativos', value: 'disabled'},
                    ]"
                />

            </div>
        </div>
    </div>

    <div 
        class="customer-grid grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-5 gap-4 mb-2" 
        :class="{
            'ml-20 w-[160vh]': widthScreen > 1366,
            'ml-12': widthScreen <= 1366
        }"    
    >
        <div
            v-if="showCustomers"
            v-for="(customer, id) in customers" :key="id" 
            class="relative overflow-x-auto max-h-96 overflow-y-auto bg-white p-6 shadow-lg rounded-lg border border-gray-200 transition-transform hover:-translate-y-3 cursor-pointer"
        >
            <div 
                @click="editCustomer(customer.customer_cod, customer.company_name || customer.trade_name, customer.active)"
            >
                <div class="text-sm text-gray-500 mb-2">
                    <span class="font-semibold">ID:</span> {{ customer.customer_cod }}
                </div>

                <div class="text-sm text-gray-500 mb-2">
                    <span class="font-semibold">Cliente:</span> {{ customer.company_name || customer.trade_name }}
                </div>

                <div class="text-sm text-gray-500 mb-2">
                    <span class="font-semibold">CPF:</span> {{ customer.cpf? customer.cpf.replace(/(\d{3})(\d{3})(\d{3})(\d{2})/, '$1.$2.$3-$4') : 'Sem CPF'}}
                </div>

                <div class="text-sm text-gray-500 mb-2">
                    <span class="font-semibold">CNPJ:</span> {{ customer.cnpj ? customer.cnpj.replace(/(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})/, '$1.$2.$3/$4-$5') : 'Sem CNPJ' }}
                </div>

                <div class="text-sm text-gray-500 mb-2">
                    <span class="font-semibold">Endereço:</span> {{ customer.address ?? 'Sem endereço cadastrado' }}
                </div>

                <div class="text-sm text-gray-500 mb-2">
                <span class="font-semibold">Status:</span> {{ customer.active === 1 ? 'Ativo' : 'Inativo' }}
                </div>
            </div>
            
            <!-- Ações -->
            <div class="slashed-zero flex space-x-2 mt-5" v-if="customer.customer_cod !== 1">
                <q-btn
                    @click="editCustomer(customer.customer_cod, customer.company_name || customer.trade_name, customer.active)"
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
                    @click="deleteOrActive('disable', customer.customer_cod)"
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
                    @click="deleteOrActive('active', customer.customer_cod)"
                    v-else
                    class="px-4 py-2 rounded-lg transition"
                    :class="{
                        'text-gray-400 bg-slate-500': !customer.active 
                    }" 
                    
                >   
                    Ativar
                </q-btn>
            </div> <!-- For acaba aqui-->
        </div>
    </div>

    <div v-if="!showCustomers">
        <RegisterCustomer
            v-if="showRegisterCustomers"
            @close="closeReload($event)"
            :widthScreen="widthScreen"
            
        />

        <UpdateCustomer
            v-if="showUpdateCustomers"
            :customerID="customerID"
            :widthScreen="widthScreen"
            @close="closeReload($event)"

        />

        <Transition name="slide-up">
            <ConfigCustomers
                v-if="showConfig"
                @close="closeReload($event)"

            />

        </Transition>
        
    </div>
</template>
  
<script setup lang="ts">
    import { LocalStorage, useQuasar } from 'quasar';
    import { api } from 'src/boot/axios';
    import { ref, onMounted, watch } from 'vue';
    import ConfigCustomers from 'src/components/Config/ConfigCustomers.vue';    
    import RegisterCustomer from 'src/components/Register/Customers/RegisterCustomer.vue';
    import UpdateCustomer from 'src/components/Register/Customers/UpdateCustomer.vue';
    import ReportCustomer from 'src/components/Reports/Customers/ReportCustomer.vue';
    import LoandingPage from 'src/components/Loanding/LoandingPage.vue';
    import camelcaseKeys from 'camelcase-keys';

    type TConfigCustomer = {
        lastFilter: string
        
    };
    
    const $q = useQuasar();
    
    let allCustomers = ref<ICustomer[]>([]);
    let customers = ref<ICustomer[]>([]);

    let _loanding = ref<boolean>(true);
    let showCustomers = ref<boolean>(false);
    let showReportCustomer = ref<boolean>(false);
    let showRegisterCustomers = ref<boolean>(false);
    let showConfig = ref<boolean>(false);
    let showUpdateCustomers = ref<boolean>(false);
    let customerID = ref<number>(0);
    let customerName = ref<string>('');
    let widthScreen = ref<number>(0);
    
    const buttonColor = ref<string>(LocalStorage.getItem("buttonColor"));

    const issuerID = ref<number>(LocalStorage.getItem("issuer_id"));
    const searchFilter = ref<'all' | 'active' | 'disabled' >('all');

    watch(searchFilter, async (newOption) =>
    {
        if(newOption === 'active')
        {
            customers.value = allCustomers.value.filter(c => c.active === 1);
        } else if (newOption === 'disabled')
        {
            customers.value = allCustomers.value.filter(c => c.active === 0);

        } else {
            customers.value = [...allCustomers.value];
        };
    });
    
    const showPage = (event: boolean) =>
    {
        showCustomers.value = event;
        _loanding.value = !event;
    };

    const getCustomers = async () =>
    {
        console.log('chamou getCustomers')
        const res = await api.get(`/customers/all/${issuerID.value}`);
        allCustomers.value = res.data.data;
        customers.value = [...allCustomers.value];
        
    };

    const deleteOrActive = async (action: string, id: number) =>
    {
        const res = action === 'disable' ? await api.put(`customers/${id}/${action}`) : await api.put(`customers/${id}/${action}`);
        if(res.data.success)
        {
            $q.notify({
                color: `green`,
                message: res.data.message,
                timeout: 2000,
                position: 'top'
                
            });

            const customer = customers.value.find(c => c.customer_cod === id);
            if(customer)
            {
                customer.active = action === 'active' ? 1 : 0;
                
            };
        };
    };

    const openRegister = () => 
    {
        showRegisterCustomers.value = true;
        showUpdateCustomers.value = false;
        showCustomers.value = false;
        showReportCustomer.value = false;
        showConfig.value = false;
        
    };     

    const closeRegister = () => 
    {
        showCustomers.value = true;
        showReportCustomer.value = false;
        showRegisterCustomers.value = false;
        showUpdateCustomers.value = false;

    };           

    const openConfig = () => 
    {
        showCustomers.value = false;
        showConfig.value = true;

    };

    const editCustomer = (id: number, name: string, active_: number) =>
    {
        const active = active_ === 1 ? true : false;
        if(id === 1) 
        {
            $q.notify({
                color: 'red-4',
                message: 'Impossível alterar cliente padrão!',
                timeout: 2000,
                position: 'top'
                
            });
            
            return;
        };

        if(!active)
        {
            $q.notify({
                color: 'red-4',
                message: 'Impossível alterar cliente desativado!',
                timeout: 2000,
                position: 'top'
                
            });

        } else {
            showUpdateCustomers.value = true;
            showCustomers.value = false;
            showRegisterCustomers.value = false;
            showReportCustomer.value = false;
            customerID.value = id;
            customerName.value = name;
        };
    };

    const closeReload = async (event: boolean) => 
    {   
        console.log('Chamnou: closeReload: event', event, ' !event', !event)
        await getConfig();
        await getCustomers();
        showCustomers.value = event;    
        showRegisterCustomers.value = !event;
        showUpdateCustomers.value = !event;
        showReportCustomer.value = !event;
        showConfig.value = !event;

    };

    const getConfig = async (): Promise<TConfigCustomer> =>
    {
        const res = await api.get(`/configs/all-configs/${issuerID.value}`);
        const data: TConfigCustomer = camelcaseKeys(res.data.data.customers, { deep: true });
        console.log(data)
        if(typeof data === 'undefined' || data.lastFilter === '')
        {
            $q.notify({
                color: 'red',
                message: 'Erro ao carregar as configurações, contate o adminstrador!',
                timeout: 2000,
                position: 'top'

            });
            return;

        } else {
            searchFilter.value = data.lastFilter as 'all' | 'active' | 'disabled';
            return;
        };
    };

    onMounted(() => {
        getCustomers();
        getConfig();
        widthScreen.value = screen.width;

    });

</script>

<style>
    .div1 {
        width: 154%;
    }

    .slide-up-enter-from {
        opacity: 0;
        transform: translateY(50px);

    }

    .slide-up-enter-to {
        opacity: 1;
        transform: translateY(0);
        
    }

    .slide-up-enter-active {
        transition: all 0.5s ease-out;
    }
</style>