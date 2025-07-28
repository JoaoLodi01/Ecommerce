<template>
    <div class="p-5">
        <div class="flex justify-between">            
            <h2 class="ml-auto mr-auto" v-if="!show">Carregando dados do cliente ...</h2>
            <h2 class="ml-auto mr-auto" v-else>Dados do cliente: </h2>
            <div 
                @click="emits('close', true)"
                class="cursor-pointer rounded h-max w-4 hover:bg-gray-100"
            >
                <q-icon name="close" />         
                
            </div>

        </div>
        <div class="border p-2 rounded mb-2 text-center">
            <div class="flex justify-center" v-if="!show">
                <q-spinner color="primary" size="40px" />    
                
            </div>
            
            <div v-if="show">
                <div>
                    <span class="text-gray-400 font-semibold">Nome: </span>
                    <span>
                        {{ customer.fullName }}
                    </span>
                </div>
                
                <div>
                    <span class="text-gray-400 font-semibold">CPF: </span>
                    <span>
                        {{ formatCPFField(customer.cpf) }}
                    </span>
                </div>

                <div class="mb-2">
                    <span class="text-gray-400 font-semibold">E-mail: </span>
                    <span>
                        {{ customer.email }}
                    </span>
                </div>
        
                <q-separator color="grey"/>

                <div class="mt-2">
                    <span class="text-gray-400 font-semibold">Hotel: </span>
                    <span>
                        {{ formatLiberation(customer.hotel) }} 
                        <span v-if="props.operation === 'update'" class="cursor-pointer" @click.prevent="props.operation === 'update' ? changeLiberations('hotel', props.customerID) : null">
                            <q-icon 
                                class="mb-[.2rem]"
                                :name="!customer.hotel ? 'check' : 'close'"
                                :title="!customer.hotel ? 'liberar' : 'remover'"
                                :class="{
                                    'bg-red-400 text-white rounded': customer.hotel,
                                    'bg-green-500 text-white rounded': !customer.hotel,

                                }"
                            
                            />
                        </span>
                    </span>
                </div>
                
                <div class="mb-2 mt-2">
                    <span class="text-gray-400 font-semibold">Ecommerce: </span>
                    <span>
                        {{ formatLiberation(customer.ecommerce) }}
                        <span v-if="props.operation === 'update'" class="cursor-pointer" @click.prevent="props.operation === 'update' ? changeLiberations('ecommerce', props.customerID) : null">
                            <q-icon 
                                class="mb-[.2rem]"
                                :name="!customer.ecommerce ? 'check' : 'close'"
                                :title="!customer.ecommerce ? 'liberar' : 'remover'"
                                :class="{
                                    'bg-red-400 text-white rounded': customer.ecommerce,
                                    'bg-green-500 text-white rounded': !customer.ecommerce,

                                }"
                            
                            />
                        </span>
                    </span>
                </div>
                
                <div class="mb-2">
                    <span class="text-gray-400 font-semibold">Site: </span>
                    <span>
                        {{ formatLiberation(customer.site) }}
                        <span v-if="props.operation === 'update'" class="cursor-pointer" @click.prevent="props.operation === 'update' ? changeLiberations('site', props.customerID) : null">
                            <q-icon 
                                class="mb-[.2rem]"
                                :name="!customer.site ? 'check' : 'close'"
                                :title="!customer.site ? 'liberar' : 'remover'"
                                :class="{
                                    'bg-red-400 text-white rounded': customer.site,
                                    'bg-green-500 text-white rounded': !customer.site,

                                }"
                            
                            />
                        </span>
                    </span>
                </div>
                <q-separator color="grey"/>

                <div class="mt-0.5 mb-2">
                    <div>
                        <span class="text-gray-400 mr-1 font-semibold">Mensalidade: </span>
                            <span class="inline-flex">
                                <span class="mt-auto mb-auto">R$</span>
                                <q-input 
                                    v-model="customer.monthlyFee"
                                    borderless
                                    type="text"
                                    maxlength="8"
                                    inputClass="text-right"
                                    class="w-16 mb-[.1rem]"
                                    :disable="props.operation !== 'update'"
                                    @blur="changeMonthlyFee"
                                    
                                />
                            </span>
                        </div>
                    <div class="mb-4">
                        <span class="text-gray-400 mr-1.5 font-semibold">Total de empresas: </span>
                        <span>{{ countCompanies }}</span>
                        
                    </div>

                    <q-separator color="grey"/>

                    <div v-if="props.operation === 'update'">
                        <q-btn 
                            class="mt-2"
                            color="red"
                            label="Desabilitar cliente" 
                            
                        />

                        <q-btn 
                            class="mt-2 ml-4"
                            color="grey"
                            label="Congelar cliente" 
                            
                        />
                    </div>
                </div>

                <div v-if="props.operation === 'update'">
                    <q-separator color="grey"/>

                    <q-btn 
                        @click="saveChangeMonthlyFee"
                        class="mt-2"
                        color="primary"
                        flat
                        label="Salvar dados!" 
                        
                    />
                </div>
            </div>
        </div>
    </div>
</template>

<script setup lang="ts">
    import { useQuasar } from 'quasar';
    import { ref, onMounted } from 'vue';
    import { api, apiEcommerce } from 'src/boot/axios';
    import { formatCPFField } from 'src/util/formatCPF';
    import { formatLiberation } from 'src/util/formatLiberation';
    import camelcaseKeys from 'camelcase-keys';
    
    const props = defineProps<{
        customerID: number,
        operation: string

    }>();

    const emits = defineEmits<{
        (e: 'close', value: boolean)
        
    }>();
    
    const $q = useQuasar();
    const customer = ref<ICustomers>({
        code: '',
        fullName: '',
        email: '',
        cpf: '',
        activeLicense: '',
        expireLicense: '',
        hotel: false,
        ecommerce: false,
        site: false,
        active: true,
        monthlyFee: 0,
        companies: 0,

    });

    let show = ref<boolean>(false);
    let countCompanies = ref<number>(0);

    function formatMonthlyFee(val: string)
    {
        return val.replace('.', ',');

    }

    const getCustomer = async () => 
    {
        const res = await api.get(`/access/customers/find/${props.customerID}`);
        const count = await apiEcommerce.get(`/access/count-companies/${props.customerID}`);

        countCompanies.value = count.data.data;
        
        const data: ICustomers = camelcaseKeys(res.data.data, { deep: true });
        
        customer.value = {
            code: data.code,
            fullName: data.fullName,
            email: data.email,
            cpf: data.cpf,
            activeLicense: data.activeLicense, 
            expireLicense: data.expireLicense, 
            active: data.active,
            hotel: data.hotel ? true : false,
            ecommerce: data.ecommerce ? true : false,
            site: data.site ? true : false,
            monthlyFee: formatMonthlyFee(String(data.monthlyFee)),
            companies: data.companies,
            
        };

        show.value = true;
    };

    const changeLiberations = async (liberation: string, customerID: number) =>
    {
        const res = await api.put(`/access/customers/update-serial/${customerID}`, {
            liberation: liberation
        });

        const data = res.data;

        if(data.success)
        {
            $q.notify({
                color: 'green',
                message: data.message,
                position: 'top',
                timeout: 2000

            });
            getCustomer();
        };
    };    

    const changeMonthlyFee = () =>
    {
        const value = Number(customer.value.monthlyFee);
        if(value < 0.01)
        {
            $q.notify({
                color: 'red',
                message: 'Valor informado abaixo do mínimo, R$ 0,01',
                position: 'top',
                timeout: 1200
            });
            
            customer.value.monthlyFee = '0,01';

        } else {
            customer.value.monthlyFee = parseFloat(customer.value.monthlyFee.toString().replace(',', '.'));
        };
    };

    const saveChangeMonthlyFee = async () =>
    {
        console.log(customer.value.monthlyFee);
        const res = await api.put(`/access/customers/update-monthly-fee/${props.customerID}`, {
            newValue: parseFloat(customer.value.monthlyFee.toString().replace(',', '.'))
        });

        const data = res.data;

        if(data.success)
        {
            $q.notify({
                color: 'green',
                message: 'Dados alterados com sucesso!',
                position: 'top',
                timeout: 2000

            });
        };

        await getCustomer();
    };

    onMounted(async () => {
        await getCustomer();
        document.addEventListener('keydown', (event: KeyboardEvent) => {
            const keyName = event.key;
            if(keyName === 'Escape') emits('close', true);

        });
    });
</script>

<style>

.loader, .loader:before, .loader:after {
    border-radius: 50%;
    width: 2.5em;
    height: 2.5em;
    animation-fill-mode: both;
    animation: bblFadInOut 1.8s infinite ease-in-out;
}

.loader {
    color: #fff;
    font-size: 2px;
    position: relative;
    text-indent: -9999em;
    transform: translateZ(0);
    animation-delay: -0.16s;
}

.loader:before,
.loader:after {
    content: '';
    position: absolute;
    top: 0;
}

.loader:before {
    left: -3.5em;
    animation-delay: -0.32s;
}

.loader:after {
    left: 3.5em;
}

@keyframes bblFadInOut {
    0%, 80%, 100% { box-shadow: 0 2.5em 0 -1.3em }
    40% { box-shadow: 0 2.5em 0 0 }
}
    
</style>