<template>
    <div v-show="_loanding">
        <LoandingPage
            @show-page="_loanding = !$event"
            :text="'Carregando dados do cliente ...'"
        />

    </div>

    <div class="fixed inset-0 z-50 flex items-center justify-center bg-opacity-40 backdrop-blur-sm" v-if="!_loanding">
        <div class="bg-white h-auto w-[40rem] border border-gray-600 rounded-md" v-if="customer">
            <div class="m-12">
                <h1 class="text-2xl text-gray-500">Cliente: <span class="text-black">{{ customer.company_name ? customer.company_name : customer.trade_name }} ({{ customer.customer_code }})</span></h1>

                <div 
                    class="mt-4"
                    :class="{
                        'cursor-pointer': !customer.company_name,
                        'cursor-default': customer.company_name
                    }"
                >
                    <span class="text-gray-500 text-lg ">Razão social: </span>
                    <span v-if="!customer?.company_name && !editField['company_name']" @click="editField['company_name'] = true" class="text-xl"> {{ customer.company_name || 'Razão social não informado (!)' }}</span>
                    <span v-else-if="editField['company_name']" class="inline-flex">
                        <q-input 
                            class="w-80" 
                            dense 
                            @blur="updateFileds('company_name')"
                            v-model="customer.company_name" 
                            type="text" 
                            color="grey"
                        />
                    </span>
                    <span v-else>
                        {{ customer.company_name }}
                    </span>
                </div>

                <div 
                    class="mt-4" 
                    :class="{
                        'cursor-pointer': !customer.trade_name,
                        'cursor-default': customer.trade_name
                    }"
                >
                    <span class="text-gray-500 text-lg">Nome fantasia: </span>
                    <span class="text-xl">{{ customer.trade_name || 'Nome fantasia não informado' }}</span>
                </div>

                <div 
                    class="mt-4"
                    :class="{
                        'cursor-pointer': !customer.cpf,
                        'cursor-default': customer.cpf
                    }"
                >
                    <span class="text-gray-500 text-lg">CPF: </span>
                    <span v-if="!customer?.cpf && !editField['cpf']" @click="editField['cpf'] = true" class="text-xl"> {{ customer.cpf || 'Sem CPF informado (!)' }}</span>
                    <span v-else-if="editField['cpf']" class="inline-flex">
                        <q-input 
                            class="w-80" 
                            dense 
                            @blur="updateFileds('cpf')"
                            v-model="customer.cpf" 
                            type="text"
                            mask="###.###.###-##"
                            color="grey"
                        />
                    </span>
                    <span v-else>
                        {{ formatField(customer.cpf) }}
                    </span>
                </div>
                
                <div 
                    class="mt-4"
                    :class="{
                        'cursor-pointer': !customer.cnpj,
                        'cursor-default': customer.cnpj
                    }"

                >
                    <span class="text-gray-500 text-lg">CNPJ: </span>

                    <span v-if="!customer?.cnpj && !editField['cnpj']" @click="editField['cnpj'] = true" class="text-xl"> {{ customer.cnpj || 'Sem CNPJ informado (!)' }}</span>
                    <span v-else-if="editField['cnpj']" class="inline-flex">
                        <q-input 
                            class="w-80" 
                            dense 
                            @blur="updateFileds('cnpj')"
                            v-model="customer.cnpj" 
                            type="text"
                            mask="##.###.###/####-##"
                            color="grey"
                        />
                    </span>
                    <span v-else>
                        {{ formatField(customer.cnpj) }}
                    </span>
                </div>

                <div 
                    class="mt-4"
                    :class="{
                        'cursor-pointer': !customer.cep,
                        'cursor-default': customer.cep
                    }"

                    @click.prevent="!customer.cep ? updateFileds('cep') : null"
                >
                    <span class="text-gray-500 text-lg">CEP: </span>
                    <span class="text-xl">{{ customer.cep || 'Sem CEP informado (!)' }}</span>
                </div>

                <div class="mt-4">
                    <span class="text-gray-500 text-lg">Endereço: </span>
                    <span class="text-xl">{{ customer.address || 'Sem endereço informado' }}</span>
                </div>

                <div 
                    class="mt-4"
                    :class="{
                        'cursor-pointer': !customer.uf,
                        'cursor-default': customer.uf
                    }"

                    @click.prevent="!customer.uf ? updateFileds('uf') : null"
                >
                    <span class="text-gray-500 text-lg">UF: </span>
                    <span class="text-xl">{{ customer.uf || 'Sem UF informada (!)' }}</span>
                </div>

                <div class="mt-4">
                    <span class="text-gray-500 text-lg">Número: </span>
                    <span class="text-xl">{{ customer.number || 'Sem número de endereço informado' }}</span>
                </div>
                
                <div 
                    class="mt-4"
                    :class="{
                        'cursor-pointer': !customer.ie,
                        'cursor-default': customer.ie
                    }"

                    @click.prevent="!customer.ie ? updateFileds('ie') : null"
                >
                    <span class="text-gray-500 text-lg">IE: </span>
                    <span class="text-xl">{{ customer.ie || 'Sem IE informada (!)' }}</span>
                </div>
                
                <div 
                    class="mt-4"
                    :class="{
                        'cursor-pointer': !customer.im,
                        'cursor-default': customer.im
                    }"

                    @click.prevent="!customer.im ? updateFileds('im') : null"
                >
                    <span class="text-gray-500 text-lg">IM: </span>
                    <span class="text-xl">{{ customer.im || 'Sem IM informada (!)'}}</span>
                </div>
                
                <div class="mt-4 mb-2">
                    <span class="text-gray-500 text-lg">Telefone: </span>
                    <span class="text-xl">{{ customer.phone || 'Sem telefone informado'}}</span>
                </div>

                <q-separator color="grey" class="mb-2"/>
                <span class="text-sm">
                    O campo com (!) pode ser necessário para a emissão fiscal!<span class="text-blue-500"> Pode fazer a edição clicando sobre o campo!</span>
                </span>                    

                <div class="mt-4 w-full flex justify-end">
                    
                    <q-btn 
                        color="primary" 
                        label="Imprimir" 
                        class="mr-4"
                    />

                    <q-btn 
                        color="red" 
                        label="Fechar" 
                        @click="emits('close', true)" 
                    />
                </div>
            </div>
        </div>
    </div>
</template>

<script setup lang="ts">
    import { api } from 'src/boot/axios';
    import { ref, onMounted } from 'vue';
    import { LocalStorage } from 'quasar';
    import LoandingPage from 'src/components/Loanding/LoandingPage.vue';

    const props = defineProps<{
        customerCode: number

    }>();

    const emits = defineEmits<{
        (e: 'close', value: boolean),
        (e: 'edit', value: boolean)

    }>();

    let customer = ref<ICustomer>();
    let _loanding = ref<boolean>(false);
    let editField = ref<{ [key: string]: boolean }>({});

    function formatField(val: string) 
    {
        if(val)
        {
            return val.length === 14 ? val.replace(/(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})/, '$1.$2.$3/$4-$5') : val.replace(/(\d{3})(\d{3})(\d{3})(\d{2})/, '$1.$2.$3-$4');
        } else {
            return ``;
        };
    };

    const getCustomerData = async () =>
    {
        try {
            const res = await api.get(`customers/view/${LocalStorage.getItem("issuer_id")}/${props.customerCode}`);
            customer.value = res.data.data;

        } catch (error) {
            emits('close', true);
        };
    };

    const updateFileds = async (field: string) =>
    {
        const actualValue = customer.value?.[field as keyof ICustomer];
        editField.value[field] = false;
        console.log('Campo a ser alterado: ', field, ' novo valor: ', actualValue);
        console.log(customer.value);
        
        try {
            if(field === 'cpf')
            {
                console.log('Edição do CPF');
                if(customer.value.cpf.replace(/\D/g, '').length === 14)
                {
                    console.log('customer.value.cpf.length: ', customer.value.cpf.length);
                    customer.value.cpf = customer.value.cpf.replace(/\D/g, '');
                    console.log('CPF:', customer.value.cpf);
                    const res = await api.put(`/customers/update/${props.customerCode}`, customer.value)

                };

            };

            if(field === 'cnpj')
            {
                console.log('Edição do CNPJ');
                console.log(customer.value.cnpj.replace(/\D/g, '').length);
                if(customer.value.cnpj.replace(/\D/g, '').length === 14)
                {
                    customer.value.cnpj = customer.value.cnpj.replace(/\D/g, '');
                    console.log('CNPJ: ', customer.value.cnpj);
                    const res = await api.put(`/customers/update/${props.customerCode}`, customer.value)
                    console.log(res.data)
                };
            };

        } catch (error) {
            console.error('Erro na edição: ', error);
            
        };        
    };

    onMounted(async () => {
        await getCustomerData();

    });
</script>