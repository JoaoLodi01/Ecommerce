<template>
    <div class="ml-14">
        <div>
            <div class="flex">
                <h1 class="text-2xl mb-6 mt-6 border-b w-max">Recebimentos</h1>

                <div class="flex gap-2 border ml-12 p-5 h-max mt-auto mb-auto rounded-lg">
                        
                    <div class="flex gap-2 text-xs">
                        <div class="bg-green-500 h-3 w-3 rounded-full mt-auto mb-auto"></div>
                        <span>Pagos</span>
                    </div>
                    
                    <div class="flex gap-2 text-xs">
                        <div class="bg-red-500 h-3 w-3 rounded-full mt-auto mb-auto"></div>
                        <span>Vencidos</span>
                    </div>
                    
                    <div class="flex gap-2 text-xs">
                        <div class="bg-orange-500 h-3 w-3 rounded-full mt-auto mb-auto"></div>
                        <span>Próximo de vencer</span>
                    </div>
                    
                    <div class="flex gap-2 text-xs">
                        <div class="bg-blue-500 h-3 w-3 rounded-full mt-auto mb-auto"></div>
                        <span>Pago com atraso</span>
                    </div>
                    
                    <div class="flex gap-2 text-xs">
                        <div class="bg-yellow-500 h-3 w-3 rounded-full mt-auto mb-auto"></div>
                        <span>Atrasado</span>
                    </div>
                </div>

                <div class="">
                    <q-option-group
                        v-model="options"
                        type="radio"
                        class="flex gap-2 mt-5"
                        :options="[
                            {label: 'Todos', value: 'all'},
                            {label: 'Liberados', value: 'active'},
                            {label: 'Vencidos', value: 'late'},
                            {label: 'Próximo de vencer', value: 'almostDue'},
                            {label: 'Congelados', value: 'freeze'},
                            {label: 'Desativados', value: 'disabled'},
                        ]"
                    />
                </div>
            </div>
            
            <q-table
                :rows="customers"
                :columns="columns"
                row-key="id"
                
            >
                <template v-slot:body="props">
                    <q-tr :props="props">
                        <q-td
                            v-for="col in props.cols"
                            :key="col.name"
                            :props="props"
                            :class="{
                                'text-green-500': props.row.activeLicense === 'Liberado', 

                            }"
                        >  
                            <template v-if="col.name === 'actions'">
                                <div class="flex justify-center">
                                    <div @click="management('view', props.row.id)" class="cursor-pointer rounded p-1 hover:bg-gray-100">
                                        <q-icon name="visibility" />
                                        
                                    </div>
                                                                        
                                    <div @click="management('update', props.row.id)" class="cursor-pointer rounded p-1 hover:bg-gray-100">
                                        <q-icon name="edit" />
                                        
                                    </div>
                                </div>
                            </template>

                            <template v-else>
                                {{ col.value }}
                                
                            </template>
                        </q-td>
                    </q-tr>
                </template>
            </q-table>
        </div>
        
    </div>
    <q-dialog 
        v-model="showCustomerManagement" 
        persistent
    >
            <q-card style="min-width: 600px">
            <CustomerManagement
                :customer-i-d="selectedCustomerID"
                :operation="typeOperation"
                @close="showCustomerManagement = !$event"

            />
            
        </q-card>
    </q-dialog>
</template>

<script setup lang="ts">
    import { QTableColumn, useQuasar } from 'quasar';
    import { api } from 'src/boot/axios';
    import { onMounted, ref, watch } from 'vue';
    import { formatCPFField } from 'src/util/formatCPF';
    import camelcaseKeys from 'camelcase-keys';
    import CustomerManagement from 'src/components/Customers/CustomerManagement.vue';
    import dayjs from 'dayjs';
   
    const $q = useQuasar();
    const options = ref<'all' | 'active' | 'late' | 'almostDue' | 'freeze' | 'disabled'>('all');

    const customers = ref<ICustomers[]>([]);
    const allCustomers = ref<ICustomers[]>([]);
    const apiAccess = process.env.API_URL;
    const columns: QTableColumn[] = [
        {
            name: 'id',
            label: 'Cód',
            field: 'id',
            align: 'center'
        },
        {
            name: 'activeLicense',
            label: 'Status',
            field: 'activeLicense',
            align: 'center'
        },
        {
            name: 'expireLicense',
            label: 'Duração',
            field: 'expireLicense',
            align: 'center',
            format: (val) => {
                const date = dayjs(val);
                return date.format('DD/MM/YYYY');
            }
        },
        {
            name: 'fullName',
            label: 'Nome',
            field: 'fullName',
            align: 'center',
            format: (val: string) => val.toLocaleUpperCase()
        },
        {
            name: 'email',
            label: 'E-mail',
            field: 'email',
            align: 'center'
        },
        {
            name: 'cpf',
            label: 'CPF',
            field: 'cpf',
            align: 'center',
            format: (val: string) => formatCPFField(val)
        },
        {
            name: 'actions',
            label: 'Ações',
            field: 'actions',
            align: 'center',
        }
    ];

    let showCustomerManagement = ref<boolean>(false);
    let selectedCustomerID = ref<number>(0);
    let typeOperation = ref<string>('');

    watch(options, (newOption) => {
        if(newOption === 'active')
        {
            customers.value = allCustomers.value.filter(c => c.activeLicense === 'Liberado')

        } else if (newOption === 'late'){
            customers.value = allCustomers.value.filter(c => c.activeLicense === 'Vencido')

        } else if (newOption === 'almostDue') {
            customers.value = allCustomers.value.filter(c => c.activeLicense === 'Próximo de vencer')

        } else if (newOption === 'freeze') {
            customers.value = allCustomers.value.filter(c => c.active === false )

        } else if (newOption === 'disabled') {
            customers.value = allCustomers.value.filter(c => c.active === false )

        } else if (newOption === 'all'){
            customers.value = [...allCustomers.value];

        };
    });

    const getDatas = async () =>
    {
        const res = await api.get(`${apiAccess}/access/customers/all`);
        const data = camelcaseKeys(res.data, { deep: true });

        allCustomers.value = data.data;
        customers.value = [...allCustomers.value];
        
    };
    
    const management = (operation: string, customerID: number) =>
    {
        typeOperation.value = operation;
        if(customerID !== 0)
        {
            showCustomerManagement.value = true;
            selectedCustomerID.value = customerID;

        } else {
            $q.notify({
                color: 'red',
                message: 'ID do cliente informado incorretamente',
                position: 'top',
                timeout: 1200

            });
        };
    };

    onMounted(() => {
        getDatas();

    });
</script>