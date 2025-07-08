<template>
    <div
        class="border border-black bg-white p-6 shadow-md rounded"
        :class="{
            'w-screen': props.widthScreen < 1366,
            'ml-32 form-customer': props.widthScreen > 1366
        }"

    >
        <q-form
            @submit="submitForm()"

        >
            <div class="border border-black p-5 bg-white rounded-md mb-5">
                <h4 class="ml-1.5 border-b w-max mb-2">Dados cadastrais</h4>
                <q-select 
                    v-model="customerData.customer_type" 
                    :options="options" 
                    label="Tipo de cadastro *" 
                    filled 
                    color="grey-7"
                    :rules="[ val => !!val || 'Selecione o tipo de cadastro do cliente' ]"
                    
                />

                <div v-if="customerData.customer_type === 'Física'">
                    <q-input 
                        v-model="customerData.trade_name" 
                        type="text" 
                        label="Nome" 
                        maxlength="120" 
                        color="grey-7"
                        class="ml-2"
                        :rules="[ val => !!val || 'O nome fantasia do cliente é obrigatório']"

                    />

                    <q-input 
                        v-model="customerData.cpf" 
                        v-bind:mask="'###.###.###-##'"
                        maxlength="14"
                        type="text" 
                        label="CPF"
                        color="grey-7"
                        class="ml-2"
                        :rules="[
                            val => {
                                if(!config.validateCpf) return true;
                                return !val || validateCPF(val) || 'CPF inválido' 
                            }
                        ]"
                        
                    />  

                </div>
                <div v-if="customerData.customer_type === 'Júridica'">
                    <q-input 
                        v-model="customerData.company_name" 
                        type="text" 
                        label="Razão social" 
                        maxlength="120" 
                        color="grey-7"
                        class="ml-2"

                    />
                    
                    <q-input 
                        v-model="customerData.trade_name" 
                        type="text" 
                        label="Nome fantasia" 
                        maxlength="120" 
                        color="grey-7"
                        class="ml-2 mt-2 mb-2"

                    />

                    <q-input 
                        v-model="customerData.cnpj" 
                        v-bind:mask="'##.###.###/####-##'"
                        @update:model-value="getDataCNPJ()"
                        maxlength="18"
                        type="text" 
                        label="CNPJ"                 
                        color="grey-7"
                        class="ml-2"

                    />

                </div>
            </div>

            <div class="border border-black p-5 bg-white rounded-md mb-5">
                <h4 class="ml-1.5 border-b w-max mb-2">Endereço</h4>
                <q-input 
                    v-model="customerData.cep"
                    @update:model-value="getDataCEP()"
                    v-bind:mask="'#####-###'"
                    type="text" 
                    label="CEP"
                    maxlength="9"
                    color="grey-7"
                    class="ml-2"
                    :rules="[ val => !!val || 'O CEP é obrigatório' ]"

                />

                <q-input 
                    v-model="customerData.address" 
                    type="text" 
                    label="Endereço" 
                    maxlength="120"
                    color="grey-7"
                    class="ml-2"

                />

                <q-input 
                    v-model="customerData.number" 
                    type="text" 
                    label="Número" 
                    maxlength="30"
                    color="grey-7"
                    class="ml-2"

                />
            </div>
            
            <div class="border border-black p-5 bg-white rounded-md mb-5">
                <h4 class="ml-1.5 border-b w-max mb-2">Outros dados</h4>
                <q-input 
                    v-model="customerData.phone" 
                    type="tel"
                    label="Número de telefone" 
                    maxlength="16"
                    color="grey-7"
                    class="ml-2"

                />

                <div class="mt-2">
                    <q-checkbox 
                        left-label 
                        v-model="customerData.is_customer" 
                        label="Cliente" 
                        class="ml-2"
                        color="grey-7"

                    />

                    <q-checkbox 
                        left-label 
                        v-model="customerData.is_supplier" 
                        label="Fornecedor" 
                        class="ml-2"
                        color="grey-7"

                    />

                    <q-checkbox 
                        left-label 
                        v-model="customerData.is_driver" 
                        label="Motorista" 
                        class="ml-2"
                        color="grey-7"
                        
                    />
                </div>
            </div>

            <div
                :class="{
                    'ml-2 mt-5': widthScreen <= 1080
                }"
            >
                <q-btn type="submit" class="mr-5">
                    <button>Criar</button>
                </q-btn>
                
                <q-btn @click="onReset()">   
                    <button>Limpar</button>
                </q-btn>
            </div>
        </q-form>
    </div>
</template>

<script setup lang="ts">
    import { api } from 'src/boot/axios';
    import { LocalStorage, useQuasar } from 'quasar';
    import { ref, defineEmits, defineProps, onMounted, reactive } from 'vue';
    import getCNPJData from 'src/services/getData/getCNPJData';
    import getCEPData from 'src/services/getData/getCEPData';
    import validateCPF from 'src/utils/validateCPF';
    import camelcaseKeys from 'camelcase-keys';

    interface IConfigCustomer
    {
        validateAddres: boolean,
        validateCnpj: boolean,
        validateCpf: boolean
        
    };

    const props = defineProps<{
        widthScreen: number

    }>();

    const emits = defineEmits<{
        (e: 'close', value: boolean)

    }>();

    const $q = useQuasar();

    const customerData = ref<IRegisterCustomer>({
        customer_type: '',
        company_name: '',
        trade_name: '',
        cpf: null,
        cnpj: null,
        cep: '',
        address: '',
        number: 0,
        is_customer: false,
        is_driver: false,
        is_supplier: false,
        phone: '',
        issuer_id: LocalStorage.getItem("issuer_id")
        
    });
    
    const options = ref<string[]>([
        'Física',
        'Júridica'

    ]);

    const config = ref<IConfigCustomer>({
        validateAddres: false,
        validateCnpj: false,
        validateCpf: false

    });

    const submitForm = async () =>
    {
        const res = await api.post(`/customers/create`, customerData.value);

        if(res.data.success)
        {
            alert(`Cliente: ${customerData.value.company_name ?? customerData.value.trade_name}, cadastrado com sucesso!`);
            emits('close', true);
        };
    };

    const getDataCNPJ = async () => 
    {
        const formatedCNPJ = customerData.value.cnpj.replace(/\D/g, '');
        if(formatedCNPJ.length === 14)
        {
            const res = await getCNPJData(formatedCNPJ);
            
            if(typeof res === 'string' || Array.isArray(res))
            {
                $q.notify({
                    type: 'negative',
                    message: res || res[0],
                    timeout: 3500 ,
                    position: 'top'

                });

                return;   

            };

            customerData.value = {
                company_name: res.alias,
                customer_type: customerData.value.customer_type,
                trade_name: customerData.value.trade_name, // Mantem padrão
                cpf: customerData.value.cpf, // Mantem padrão
                cnpj: customerData.value.cnpj,
                cep: res.cep,
                address: res.address,
                number: res.number, 
                is_customer: customerData.value.is_customer, // Mantem padrão
                is_driver: customerData.value.is_driver, // Mantem padrão
                is_supplier: customerData.value.is_supplier, // Mantem padrão
                phone: customerData.value.phone, // Mantem padrão
                issuer_id: customerData.value.issuer_id // Mantem padrão
                
            };  

            return;
        } 
    };

    const getDataCEP = async () => 
    {
        const fomratedCEP = customerData.value.cep.replace(/\D/g, '');
        if(fomratedCEP.length === 8)
        {
            const res = await getCEPData(fomratedCEP);
            console.log('Res: ', res);

            if(typeof res === 'string')
            {
                $q.notify({
                    type: 'negative',
                    message: res || res[0],
                    timeout: 3500 ,
                    position: 'top'

                });                

                return;
            };

            customerData.value = {
                company_name: customerData.value.company_name, // Mantem padrão
                customer_type: customerData.value.customer_type, // Mantem padrão
                trade_name: customerData.value.trade_name, // Mantem padrão
                cpf: customerData.value.cpf, // Mantem padrão
                cnpj: customerData.value.cnpj, // Mantem padrão
                cep: customerData.value.cep,
                address: res.addres,
                number: customerData.value.number, // Mantem padrão
                is_customer: customerData.value.is_customer, // Mantem padrão
                is_driver: customerData.value.is_driver, // Mantem padrão
                is_supplier: customerData.value.is_supplier, // Mantem padrão
                phone: customerData.value.phone, // Mantem padrão
                issuer_id: customerData.value.issuer_id // Mantem padrão

            };
            return;  
        };
    };

    const onReset = () => 
    {
        customerData.value = {
            company_name: '',
            trade_name: '',
            cpf: '',
            cnpj: '',
            cep: '',
            address: '',
            number: 0,
            is_customer: false,
            is_driver: false,
            is_supplier: false,
            phone: '',
            issuer_id: customerData.value.issuer_id

        };
    };

    const returnValue = (value: boolean | number ) => { return value === 1 ? true : false };
    
    const getConfig = async () =>
    {
        const res = await api.get(`/configs/all-configs/${customerData.value.issuer_id}`);
        const data: IConfigCustomer = camelcaseKeys(res.data.data.customers, { deep: true });

        config.value.validateAddres = returnValue(data.validateAddres);
        config.value.validateCnpj = returnValue(data.validateCnpj);
        config.value.validateCpf = returnValue(data.validateCpf);

        console.log(config);
        
    };

    onMounted(() => {
        getConfig();

    });

</script>

<style lang="scss">
    .form-customer {
        width: 150vh;
    }
    
    .slide-up-enter-from {
        opacity: 0;
        transform: translateY(-50px);

    }

    .slide-up-enter-to {
        opacity: 1;
        transform: translateY(0);
        
    }

    .slide-up-enter-active {
        transition: all 0.5s ease-out;
    }
</style>