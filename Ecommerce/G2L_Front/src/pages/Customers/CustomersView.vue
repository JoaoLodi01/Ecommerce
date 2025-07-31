<template>
    <div v-show="_loanding">
        <LoandingPage
            @show-page="showPage($event)"
            :text="'Carregando clientes ...'"
        />

    </div>
    <div v-show="!_loanding">
        <div    
            :class="{
                'mt-10 p-6 ml-16 mb-5 bg-white rounded-lg shadow-lg w-[150vh]': widthScreen > 1366,
                'mt-10 ml-14 mr-6 mb-5 bg-white rounded-lg shadow-lg w-[120vh]': widthScreen <= 1680
                
            }"  
        >
            <div class="flex justify-between">
                <h1 class="text-3xl font-semibold m-5">{{ titleByOperation }}</h1>
                
                <div 
                    :class="{
                        'mt-5': widthScreen > 1366,
                        'mt-5 mr-5': widthScreen <= 1366
                    }"
                >
                    <q-btn
                        v-if="showCustomers"
                        @click="customerManagement('create', 0, 0)"
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
                v-if="showCustomers"
            >
                <q-btn 
                    title="Opções"
                    class="mr-5"
                    :style="`background-color: ${buttonColor}; color: ${buttonColor === '#ffffff' ? '#000' : '#ffffff'}`"
                    @click="showConfig = true"
                >
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M9.594 3.94c.09-.542.56-.94 1.11-.94h2.593c.55 0 1.02.398 1.11.94l.213 1.281c.063.374.313.686.645.87.074.04.147.083.22.127.325.196.72.257 1.075.124l1.217-.456a1.125 1.125 0 0 1 1.37.49l1.296 2.247a1.125 1.125 0 0 1-.26 1.431l-1.003.827c-.293.241-.438.613-.43.992a7.723 7.723 0 0 1 0 .255c-.008.378.137.75.43.991l1.004.827c.424.35.534.955.26 1.43l-1.298 2.247a1.125 1.125 0 0 1-1.369.491l-1.217-.456c-.355-.133-.75-.072-1.076.124a6.47 6.47 0 0 1-.22.128c-.331.183-.581.495-.644.869l-.213 1.281c-.09.543-.56.94-1.11.94h-2.594c-.55 0-1.019-.398-1.11-.94l-.213-1.281c-.062-.374-.312-.686-.644-.87a6.52 6.52 0 0 1-.22-.127c-.325-.196-.72-.257-1.076-.124l-1.217.456a1.125 1.125 0 0 1-1.369-.49l-1.297-2.247a1.125 1.125 0 0 1 .26-1.431l1.004-.827c.292-.24.437-.613.43-.991a6.932 6.932 0 0 1 0-.255c.007-.38-.138-.751-.43-.992l-1.004-.827a1.125 1.125 0 0 1-.26-1.43l1.297-2.247a1.125 1.125 0 0 1 1.37-.491l1.216.456c.356.133.751.072 1.076-.124.072-.044.146-.086.22-.128.332-.183.582-.495.644-.869l.214-1.28Z" />
                        <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
                    </svg>
                </q-btn> <!-- QBTB of config -->

                <q-btn
                    @click="showReportCustomer = !showReportCustomer"
                    :style="`background-color: ${buttonColor}; color: ${buttonColor === '#ffffff' ? '#000' : '#ffffff'}`"
                    title="Relatórios"
                >
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6 ">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M9 12h3.75M9 15h3.75M9 18h3.75m3 .75H18a2.25 2.25 0 0 0 2.25-2.25V6.108c0-1.135-.845-2.098-1.976-2.192a48.424 48.424 0 0 0-1.123-.08m-5.801 0c-.065.21-.1.433-.1.664 0 .414.336.75.75.75h4.5a.75.75 0 0 0 .75-.75 2.25 2.25 0 0 0-.1-.664m-5.8 0A2.251 2.251 0 0 1 13.5 2.25H15c1.012 0 1.867.668 2.15 1.586m-5.8 0c-.376.023-.75.05-1.124.08C9.095 4.01 8.25 4.973 8.25 6.108V8.25m0 0H4.875c-.621 0-1.125.504-1.125 1.125v11.25c0 .621.504 1.125 1.125 1.125h9.75c.621 0 1.125-.504 1.125-1.125V9.375c0-.621-.504-1.125-1.125-1.125H8.25ZM6.75 12h.008v.008H6.75V12Zm0 3h.008v.008H6.75V15Zm0 3h.008v.008H6.75V18Z" />
                    </svg>
                </q-btn>
            
                <q-btn 
                    :style="`background-color: ${buttonColor}; color: ${buttonColor === '#ffffff' ? '#000' : '#ffffff'}`"
                    class="ml-5"
                    @click="showImportFiles = true"
                >
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M12 16.5V9.75m0 0 3 3m-3-3-3 3M6.75 19.5a4.5 4.5 0 0 1-1.41-8.775 5.25 5.25 0 0 1 10.233-2.33 3 3 0 0 1 3.758 3.848A3.752 3.752 0 0 1 18 19.5H6.75Z" />
                    </svg>

                </q-btn>

                <q-btn 
                    :style="`background-color: ${buttonColor}; color: ${buttonColor === '#ffffff' ? '#000' : '#ffffff'}`"
                    class="ml-5"
                    title="Baixa arquivo de importação"
                    @click="downloadDefaultFile"
                >
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 14.25v-2.625a3.375 3.375 0 0 0-3.375-3.375h-1.5A1.125 1.125 0 0 1 13.5 7.125v-1.5a3.375 3.375 0 0 0-3.375-3.375H8.25m.75 12 3 3m0 0 3-3m-3 3v-6m-1.5-9H5.625c-.621 0-1.125.504-1.125 1.125v17.25c0 .621.504 1.125 1.125 1.125h12.75c.621 0 1.125-.504 1.125-1.125V11.25a9 9 0 0 0-9-9Z" />
                    </svg>
                </q-btn>
                
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
            class="customer-grid mb-2" 
            :class="{
                'ml-16 max-w-[165vh] w-[150vh]': widthScreen > 1366,
                'ml-12': widthScreen <= 1366
            }"    
        >
            <q-table
                v-if="showCustomers"
                flat bordered
                grid
                :rows="customers"
                :columns="columns"
                v-model:pagination="pagination"
                row-key="customer_code"
                hide-bottom
            
            >
                <template v-slot:item="props">
                    <q-card
                        class="q-ma-sm q-pa-md shadow-2 rounded-borders bg-white w-[22rem] transition-transform hover:-translate-y-3 cursor-pointer"
                        :class="{
                            'active-shadow': props.row.active,
                            'disabled-shadow': !props.row.active,

                        }"
                    >
                        <div
                            @click.prevent="!editByButtonConfig ? customerManagement('update', props.row.active, props.row.customer_code,) : null "
                        >
                            <div class="text-lg">
                                <span class="text-gray-500 text-base">Código</span>
                                <br>
                                <span class="font-semibold text-lg">{{ props.row.customer_code }}</span>
                                
                            </div>
                            <div class="text-lg">
                                <span class="text-gray-500 text-base">Razão social</span>
                                <br>
                                <span>{{ props.row.company_name || 'Sem razão social informada' }}</span>

                            </div>
                            
                            <div class="text-lg">
                                <span class="text-gray-500 text-base">Nome fantasia</span>
                                <br>
                                <span>{{ props.row.trade_name || 'Sem nome fantasia informado'  }}</span>

                            </div>

                            <div class="text-lg">
                                <span class="text-gray-500 text-base">CPF</span>
                                <br>
                                <span class="font-semibold">{{ formatField(props.row.cpf) || 'Sem CPF informado' }}</span>

                            </div>

                            <div class="text-lg">
                                <span class="text-gray-500 text-base">CNPJ</span>   
                                <br>
                                <span class="font-semibold">{{ formatField(props.row.cnpj) || 'Sem CNPJ informado' }}</span>
                            </div>
                        </div>

                        <div class="slashed-zero flex space-x-2 mt-5" v-if="props.row.customer_code !== 1">
                            <q-btn
                                @click="customerManagement('update', props.row.active, props.row.customer_code)"
                                class="px-4 py-2 rounded-lg transition"
                                label="Editar"
                                :disabled=!props.row.active
                                :class="{
                                    'text-gray-400 bg-slate-500': !props.row.active,
                                    'text-white bg-blue-500': props.row.active,
                                }"    
                            />

                            <q-btn
                                @click="deleteOrActive('disable', props.row.customer_code)"
                                class="px-4 py-2 rounded-lg transition"
                                :disabled=!props.row.active
                                :class="{
                                    'text-gray-400 bg-slate-500': !props.row.active,
                                    'text-white bg-red-500': props.row.active,
                                }"    
                                label="Desativar"
                                v-if="props.row.active"
                            />
                                
                            
                            <q-btn
                                @click="deleteOrActive('active', props.row.customer_code)"
                                v-else
                                class="px-4 py-2 rounded-lg transition"
                                label="Ativar"
                                :class="{
                                    'text-white bg-green-500': !props.row.active 
                                }" 
                            />

                            <q-btn 
                                label="Visualizar"
                                class="rounded-lg text-white bg-sky-500"
                                @click="viewCustomer(props.row.customer_code)"
                            />
                        </div>
                    </q-card>
                </template>
            </q-table>
        </div>

        <div v-if="!showCustomers">
            <CustomerManagement
                v-if="showCustomerManagement"
                @close="closeReload($event)"
                :widthScreen="widthScreen"
                :customer-code="customerCodSelected"
                :operation="operation"
                
            />
        </div>

        <ImportFiles
            v-show="showImportFiles"
            @close="closeReload($event)"
            :operation="'importCustomers'"

        />

        <ViewCustomer
            v-if="showViewCustomer"
            :customer-code="customerCodSelected"
            @close="showViewCustomer = !$event"

        />

        <Transition name="slide-up">
            <ConfigCustomers
                v-show="showConfig"
                @close="closeReload($event)"

            />

        </Transition>
    </div>
</template>
  
<script setup lang="ts">
    import { LocalStorage, useQuasar, QTableColumn } from 'quasar';
    import { api } from 'src/boot/axios';
    import { ref, onMounted, watch, reactive } from 'vue';
    import ConfigCustomers from 'src/components/Config/ConfigCustomers.vue';    
    import CustomerManagement from 'src/components/Register/Customers/CustomerManagement.vue';
    import ViewCustomer from 'src/components/Register/Customers/ViewCustomer.vue';
    import LoandingPage from 'src/components/Loanding/LoandingPage.vue';
    import ImportFiles from 'src/components/Files/ImportFiles.vue';    
    import camelcaseKeys from 'camelcase-keys';

    type TConfigCustomer = {
        lastFilter: string,
        editByButton: boolean,
        
    };

    type TPagination = {
        rowsPerPage: number
    }
    
    const $q = useQuasar();
    const titles = reactive({
        'create': 'Novo cliente',
        'update': 'Editar cliente'
        
    });
    
    const buttonColor = ref<string>(LocalStorage.getItem("buttonColor"));

    const issuerID = ref<number>(LocalStorage.getItem("issuer_id"));
    const searchFilter = ref<'all' | 'active' | 'disabled' >('all');

    const columns: QTableColumn[] = [
        { 
            name: 'customer_code', 
            label: 'Código', 
            field: 'customer_code', 
            align: 'center' 
        },
        { 
            name: 'company_name', 
            label: 'Razão social', 
            field: 'company_name', 
            align: 'center' 
        },
        { 
            name: 'trade_name', 
            label: 'Nome Fantasia', 
            field: 'trade_name', 
            align: 'center' 
        },
        { 
            name: 'cpf', 
            label: 'CPF', 
            field: 'cpf', 
            align: 'center'
        },
        { 
            name: 'cnpj', 
            label: 'CNPJ', 
            field: 'cnpj', 
            align: 'center'
        },
        {
            name: 'actions',
            label: 'Ações',
            field: 'actions',
            align: 'center'
        },
    ];

    let editByButtonConfig = ref<boolean>(false);
    let allCustomers = ref<ICustomer[]>([]);
    let customers = ref<ICustomer[]>([]);
    let _loanding = ref<boolean>(true);
    let showCustomers = ref<boolean>(false);
    let showCustomerManagement = ref<boolean>(false);
    let showViewCustomer = ref<boolean>(false);
    let showImportFiles = ref<boolean>(false);
    let showReportCustomer = ref<boolean>(false);
    let showConfig = ref<boolean>(false);
    let operation = ref<string>('');
    let titleByOperation = ref<string>('Clientes');
    let customerCodSelected = ref<number>(0);
    let widthScreen = ref<number>(0);   
    
    let pagination = ref<TPagination>({
        rowsPerPage: 0
    });

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

    function formatField(val: string) 
    {
        if(val)
        {
            return val.length === 14 ? val.replace(/(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})/, '$1.$2.$3/$4-$5') : val.replace(/(\d{3})(\d{3})(\d{3})(\d{2})/, '$1.$2.$3-$4');
        } else {
            return ``;
        };
    };

    const showPage = (event: boolean) =>
    {
        showCustomers.value = event;
        _loanding.value = !event;
    };

    const getCustomers = async () =>
    {
        const res = await api.get(`/customers/all/${issuerID.value}`);
        allCustomers.value = res.data.data;
        pagination.value = {
            rowsPerPage: allCustomers.value.length
        };
        
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

            const customer = customers.value.find(c => c.customer_code === id);
            if(customer)
            {
                customer.active = action === 'active' ? 1 : 0;
                
            };
        };
    };

    const closeRegister = () => 
    {
        showCustomers.value = true;
        showReportCustomer.value = false;
        titleByOperation.value = 'Clientes';

    };           

    const customerManagement = (action: string, active: number, customerCod: number) =>
    {
        console.log(action);
        if(action === 'update')
        {
            console.log('Foi update');
            if(active !== 1)
            {
                $q.notify({
                    color: 'red-4',
                    message: 'Impossível alterar cliente desativado!',
                    timeout: 2000,
                    position: 'top'
                
                });
                return;
            };

            if(customerCod === 1)
            {
                $q.notify({
                    color: 'red-4',
                    message: 'Impossível alterar cliente padrão!',
                    timeout: 2000,
                    position: 'top'
                
                });
                return;
            };

            if(active === 1)
            {
                console.log('Vai abrir o update');
                operation.value = action;
                showCustomers.value = false;
                showCustomerManagement.value = true;
                titleByOperation.value = titles[action];
                customerCodSelected.value = customerCod;   
                return;
                
            };
            
        } else {
            console.log('Vai abrir o create');
            operation.value = action;
            showCustomers.value = false;
            showCustomerManagement.value = true;
            titleByOperation.value = titles[action];
            customerCodSelected.value = customerCod;  
            return;

        };        
    };

    const closeReload = async (event: boolean) => 
    {   
        titleByOperation.value = 'Clientes';
        await getConfig();
        await getCustomers();
        showCustomers.value = event;
        showReportCustomer.value = false;
        showConfig.value = false;
        showImportFiles.value = false;

    };

    const getConfig = async (): Promise<TConfigCustomer> =>
    {
        console.log(issuerID.value);
        const res = await api.get(`/configs/all-configs/${issuerID.value}`);
        const data: TConfigCustomer = camelcaseKeys(res.data.data.customers, { deep: true });
        
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
            editByButtonConfig.value = data.editByButton;
            searchFilter.value = data.lastFilter as 'all' | 'active' | 'disabled';
            return;
        };
    };

    const downloadDefaultFile = async () =>
    {
        const res = await api.get('customers/download/default-file', {
            responseType: 'blob'

        });

        console.log(res);

        const url = window.URL.createObjectURL(
            new Blob([res.data], { 
                type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' 
            }
        ));
        
        const link = document.createElement('a');

        link.href = url;
        link.setAttribute('download', `Padrão_Importação.xlsx`);
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);

    };

    const viewCustomer = (customerCode: number) =>
    {
        showViewCustomer.value = true;
        customerCodSelected.value = customerCode;

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

    .active-shadow{
        --tw-shadow-colored: 0 1px 1px 0 var(--tw-shadow-color);
        --tw-shadow-color: #4ade80;
        --tw-shadow: var(--tw-shadow-colored);
        box-shadow: var(--tw-ring-offset-shadow, 0 0 #0000), var(--tw-ring-shadow, 0 0 #0000), var(--tw-shadow);
    }
    
    .disabled-shadow{
        --tw-shadow-colored: 0 1px 1px 0 var(--tw-shadow-color);
        --tw-shadow-color: red;
        --tw-shadow: var(--tw-shadow-colored);
        box-shadow: var(--tw-ring-offset-shadow, 0 0 #0000), var(--tw-ring-shadow, 0 0 #0000), var(--tw-shadow);
    }

</style>