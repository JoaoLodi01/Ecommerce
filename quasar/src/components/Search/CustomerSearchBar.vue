<template>
    <div class="flex">
        <div>
            <div class="text-sm" v-if="props.pdv">
                <q-checkbox
                    size="1.6rem"
                    label="Cliente cadastrado - F4"
                    v-model="registredCustomer"
                    color="grey"
                    @vue:updated="watchRegistredCustomer()"

                />
            </div>

            <q-input 
                ref="customer"
                v-model="customersData.name"
                @update:model-value="selectClient()"
                class="w-96"
                color="grey"
                :disabled="!filter"

            />
            
        </div>    
            <ul 
                v-if="filteredClients.length > 0 && customersData.name !== ''" 
                class="fixed z-50 p-3 bg-white border border-gray-300 mt-14"
            >
                <li
                    v-for="client in filteredClients "
                    :key="client.id"
                    @click="setClient(client)"
                    class="p-2 hover:bg-gray-200 cursor-pointer"
                >
                    {{client.id}} - {{ client.company_name ? client.company_name : client.trad_name }}

                </li>
            </ul>
    </div>
</template>

<script setup lang="ts">
    import { api } from 'src/boot/axios';
    import { LocalStorage } from 'quasar';
    import { ref, onMounted, defineProps, defineEmits } from 'vue';
    
    type TcustomersData = {
        id: number,
        name: string
    };

    interface IFiltredCustomerData
    {
        readonly id: number,
        company_name: string,
        trad_name: string
    }

    const emits = defineEmits<{
        (e: 'update:selectCustomer', value: TcustomersData)

    }>();

    const props = defineProps<{
        pdv: boolean

    }>();
    
    const customer = ref<any>(null);

    let customersData = ref<TcustomersData>({
        id: 1,
        name: 'Consumidor Padrão'

    });

    let filteredClients = ref<IFiltredCustomerData[]>([]);
    
    let registredCustomer = ref<boolean>(false);
    let filter = ref<string>('');
    let message = ref<string>('');    

    let issuerID = ref<number>(LocalStorage.getItem("issuer_id"));

    const getConfig = async () => {
        const res = await api.get(`/config/all-configs/${LocalStorage.getItem("issuer_id")}`);
        const configs = res.data.data.pdv[0];
        
        if (configs) {
            filter.value = configs.filter_search_customer;

        } else {
            console.warn('Configuração filter_search_customer não encontrada.', configs.filter_search_customer);
            filter.value = null;
        };

    };   

    const selectClient = async () =>
    {
        if (customersData.value.name.length > 0 && filter.value && registredCustomer.value) {
            const res = await api.post('/customers/search', {
                filter: filter.value,
                search: customersData.value.name,
                issuer_id: issuerID.value

            });

            const customer: IFiltredCustomerData[] = res.data.data;
            console.log(customer)
            filterClients(customer);
        };
    };

    const watchRegistredCustomer = () => 
    {
        if(registredCustomer.value)
        {
            customersData.value.name = '';

        } else {
            customersData.value.name = 'Consumidor Padrão';

        };
    };

    const filterClients = (customer: IFiltredCustomerData[]) => 
    {
        filteredClients.value = customer.map(c => {return c});
        console.log(filteredClients.value);
    };

    const setClient = (client: IFiltredCustomerData): void => 
    {
        customersData.value.id = client.id;
        customersData.value.name = client.company_name ? client.company_name : client.trad_name;

        emits('update:selectCustomer', customersData.value);

        filteredClients.value = [];
    };   
    
    onMounted(() => {
        
        document.addEventListener('keydown', (event: TEvent) => {
            const keyName = event.key;
            
            if(keyName === 'F4')
            {
                console.log('Chamou');
                console.log(customersData.value.name);
                const input = customer.value?.$el?.querySelector('input');

                if(input)
                {
                    input.focus();

                } 

                registredCustomer.value = !registredCustomer.value ;
                customersData.value.name = 'Consumidor Padrão';

            } else {
                return;
            };
        });


        getConfig();
    });
</script>