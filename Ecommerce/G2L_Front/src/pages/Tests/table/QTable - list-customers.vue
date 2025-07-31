<template>    
    <q-table
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
                class="q-ma-sm q-pa-md shadow-2 rounded-borders bg-white w-[22rem] h-[24rem] transition-transform hover:-translate-y-3 cursor-pointer"
                :class="{
                    'active-shadow': props.row.active,
                    'disabled-shadow': !props.row.active,

                }"
            >
                <div
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
                        <span class="font-semibold">{{ props.row.cpf || 'Sem CPF informado' }}</span>

                    </div>

                    <div class="text-lg">
                        <span class="text-gray-500 text-base">CNPJ</span>   
                        <br>
                        <span class="font-semibold">{{ props.row.cnpj || 'Sem CNPJ informado' }}</span>
                    </div>
                </div>

                <div class="slashed-zero flex space-x-2 mt-5" v-if="props.row.customer_code !== 1">
                    <q-btn
                        
                        class="px-4 py-2 rounded-lg transition"
                        :disabled=!props.row.active
                        :class="{
                            'text-gray-400 bg-slate-500': !props.row.active,
                            'text-blue-500 bg-blue-100 hover:bg-blue-200': props.row.active,
                        }"    
                    >
                        Editar
                    </q-btn>

                    <q-btn
                        
                        class="px-4 py-2 rounded-lg transition"
                        :disabled=!props.row.active
                        :class="{
                            'text-gray-400 bg-slate-500': !props.row.active,
                            'text-red-500 bg-red-100 hover:bg-red-200': props.row.active,
                        }"    
                        v-if="props.row.active"
                    >
                        Desativar
                    </q-btn>
                    <q-btn
                        
                        v-else
                        class="px-4 py-2 rounded-lg transition"
                        :class="{
                        'text-white bg-green-500': !props.row.active 
                        }" 
                    >   
                        Ativar
                    </q-btn>

                    <q-btn 
                        color="primary" 
                        label="Visualizar"
                        @click="viewCustomer(props.row.customer_code)"
                    />
                </div>
            </q-card>
        </template>
    </q-table>
    <q-separator color="grey" />

    <QTableViewCustomer
        v-if="showViewCustomer"
        :customer-code="customerCodSelected"
        @close="showViewCustomer = !$event"

    />
</template>

<script setup lang="ts">
    import { api } from 'src/boot/axios';
    import { LocalStorage, QTableColumn } from 'quasar';
    import { ref, onMounted } from 'vue';
    import QTableViewCustomer from './QTable-ViewCustomer.vue';

    const issuerID = ref<number>(LocalStorage.getItem("issuer_id"));

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

    let allCustomers = ref<ICustomer[]>([]);
    let customers = ref<ICustomer[]>([]);

    let customerCodSelected = ref<number>(0);
    let showViewCustomer = ref<boolean>(false);
    
    let pagination = ref({
        rowsPerPage: 0
    });

    function showEmpetyData(val: string): string 
    {
        return val === null || val === '' ?  'Sem dado inforamdo' : val;
    }

    const getCustomers = async () =>
    {
        console.log('chamou getCustomers')
        const res = await api.get(`/customers/all/${issuerID.value}`);
        console.log(res.data.data)
        allCustomers.value = res.data.data;
        customers.value = [...allCustomers.value];
    
    };

    const viewCustomer = (customerCode: number) =>
    {
        showViewCustomer.value = true;
        customerCodSelected.value = customerCode;

    };

    onMounted(() => {
        getCustomers();

    });
</script>