<template>
    <div
        class="border border-black bg-white p-6 shadow-md rounded"
        :class="{
            'w-screen': props.widthScreen < 1366,
            'ml-20 form-customer': props.widthScreen > 1366
        }"

    >
        <q-form
            @submit="onSubmit()"

        >
            <div class="border border-black p-5 bg-white rounded-md mb-5">
                <h4 class="ml-1.5 border-b w-max">Dados cadastrais</h4>
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
                                if(config.validateCpf) return true;
                                if(!config.validateCpf && !val) return false || 'CPF obrigatório';
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
                        :rules="[
                            val => {
                                if(config.validateCnpj) return true;
                                if(!config.validateCnpj && !val) return false || 'CNPJ obrigatório';
                            }
                        ]"

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
                    v-model="customerData.uf" 
                    type="text" 
                    label="UF" 
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

                <q-input 
                    v-model="customerData.ie" 
                    type="tel"
                    label="IE" 
                    maxlength="14"
                    color="grey-7"
                    class="ml-2"

                />

                <q-input 
                    v-model="customerData.im" 
                    type="tel"
                    label="IM" 
                    maxlength="12"
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
                <q-btn 
                    type="submit" 
                    class="mr-5"
                    :style="`background-color: ${buttonColor}; color: ${textColor ?? '#fff'}`"
                    :label="props.operation === 'update' ? 'Alterar dados do cliente' : 'Cadastrar cliente'"
                 
                />
            
            </div>
        </q-form>
    </div>

    <LoandingPage
        v-if="loanding"
        :text="props.operation === 'create' ? 'Cadastrando novo cliente!' : `Carregando dados do cliente: ${props.customerCOD} ...`"

    />
</template>

<script setup lang="ts">
    import { api } from 'src/boot/axios';
    import { LocalStorage, useQuasar } from 'quasar';
    import { ref, defineEmits, defineProps, onMounted, watch } from 'vue';
    import LoandingPage from 'src/components/Loanding/LoandingPage.vue';    
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
        widthScreen: number,
        operation: string,
        customerCOD?: number

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
        uf: '',
        im: '',
        ie: '',
        address: '',
        number: '',
        is_customer: true,
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

    const buttonColor = ref<string>(LocalStorage.getItem("buttonColor"));
    const textColor = ref<string>(LocalStorage.getItem("textColor"));

    let loanding = ref<boolean>(false);

    watch(options.value, async() => 
    {
        customerData.value.cnpj = '';

    });

    const onSubmit = async () =>
    {
        loanding.value = true;
        const isUpdate = props.operation === 'update' ? true : false;
        console.log(isUpdate)

        $q.notify({
            color: 'green',
            message: isUpdate ? 'Alterando dados do cliente!' : 'Cadastrando um novo cliente!',
            position: 'top',
            timeout: 2000

        });

        const apiURL = `/customers/${isUpdate ? `update/${props.customerCOD}` : 'create'}`
        
        console.log(customerData.value);
        
        const res = isUpdate ? await api.put(apiURL, customerData.value) : await api.post(apiURL, customerData.value);
        const data = res.data;

        if(data.success)
        {
            $q.notify({
                color: 'green',
                message: isUpdate ? 'Cliente alterando com sucesso!' : 'Cliente cadastrado com sucesso!',
                position: 'top',
                timeout: 2000

            });

            emits('close', true);

        };

        loanding.value = false;
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

            customerData.value.company_name = res.alias;
            customerData.value.cep = res.cep;
            customerData.value.address = res.address;
            customerData.value.number = res.number;

            return;
        } 
    };

    const getDataCEP = async () => 
    {
        const fomratedCEP = customerData.value.cep.replace(/\D/g, '');
        if(fomratedCEP.length === 8)
        {
            const res = await getCEPData(fomratedCEP);

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

            customerData.value.address = res.addres;
            customerData.value.uf = res.uf;
            return;  
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
    };

    const getCustomerData = async () =>
    {
        $q.notify({
            color: 'green',
            message: 'Carregando dados ...',
            position: 'top',
            timeout: 2000

        });

        const res = await api.get(`/customers/${props.customerCOD}`);
        const data: IRegisterCustomer = res.data.data;

        if(res.data.success)
        {
            customerData.value = {
                customer_type: data.cnpj !== '' ? 'Física' : 'Júridica',
                company_name: data.company_name,
                trade_name: data.trade_name,
                cpf: data.cpf,
                cnpj: data.cnpj,
                address: data.address,
                cep: data.cep,
                uf: data.uf,
                ie: data.ie,
                im: data.im,
                number: data.number,
                is_customer: returnValue(data.is_customer),
                is_driver: returnValue(data.is_driver),
                is_supplier: returnValue(data.is_supplier),
                phone: data.phone,
                issuer_id: data.issuer_id

            };
        };

        loanding.value = false;
    };

    onMounted(async () => {
        props.operation === 'update' ? await getCustomerData() : null;
        getConfig();

    });

</script>

<style lang="scss">
    .form-customer {
        width: 145vh;
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