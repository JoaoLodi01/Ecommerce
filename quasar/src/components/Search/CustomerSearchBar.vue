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
                label="Cliente" 
                ref="customer"
                v-model="clientsData.name"
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

<script setup lang="ts">
    import { api } from 'src/boot/axios';
    import { LocalStorage } from 'quasar';
    import { ref, onMounted, defineProps, defineEmits } from 'vue';
    
    type TclientsData = {
        id: number,
        name: string
    }

    const emits = defineEmits<{
        (e: 'update:selectCustomer', value: TclientsData)

    }>();

    const props = defineProps<{
        pdv: boolean

    }>();
    
    const customer = ref<any>(null);

    const defaultCustomer = ref<TclientsData>({
        id: 1,
        name: 'Consumidor Padrão'

    });

    let clientsData = ref<TclientsData>({
        id: 0,
        name: ''

    });
    
    let registredCustomer = ref<boolean>(false);
    let fillter = ref<string>('');
    let message = ref<string>('');
    let filteredClients = ref<TclientsData[]>([]);

    let issuerID = ref<number>(LocalStorage.getItem("issuer_id"));

    const getConfig = async () => {
        const res = await api.get(`/config/all-configs/${LocalStorage.getItem("issuer_id")}`);
        const configs = res.data.data.pdv[0];
        
        if (configs) {
            fillter.value = configs.filter_search_customer;

        } else {
            console.warn('Configuração filter_search_customer não encontrada.', configs.filter_search_customer);
            fillter.value = null;
        };

    };   

    const selectClient = async () =>
    {
        if (clientsData.value.name.length > 0 && fillter.value && registredCustomer) {
            try {
                const res = await api.post('/customers/search', {
                    fillter: fillter.value,
                    search: clientsData.value.name,
                    issuer_id: issuerID.value

                });

                console.log('response', res)

                //clients = toRaw(response.data);
                typeof res.data === 'string'
                    ? message.value = res.data
                    : filterClients();

            } catch (error) {
                console.error('Erro ao buscar cliente:', error);

            };
        };
    };

    const watchRegistredCustomer = () => 
    {
        if(registredCustomer)
        {
            clientsData.value.name = '';
            
        } else {
            clientsData.value.name = defaultCustomer.value.name;

        };
    };

    const filterClients = () => 
    {
        
    };

    const setClient = (client) => 
    {
        clientsData.value.id = client.id;
        clientsData.value.name = client.name;

        emits('update:selectCustomer', clientsData.value);

        filteredClients.value = [];
    };   
    
    onMounted(() => {
        document.addEventListener('keydown', (event: TEvent) => {
            const keyName = event.key;
            
            if(keyName === 'F4')
            {
                const input = customer.value?.$el?.querySelector('input');

                if(input)
                {
                    input.focus();

                };

                registredCustomer.value = !registredCustomer.value ;

                clientsData.value.name = defaultCustomer.value.name;
                
            } else {
                return;
            };
        });

        getConfig();
    });
</script>