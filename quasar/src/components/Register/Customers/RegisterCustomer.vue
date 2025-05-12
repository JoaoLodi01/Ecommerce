<template>
    <div
        class="border border-black mt-2 p-6 shadow-md rounded"
        :class="{
            'relative top-12 left-12': widthScreen <= 1080,
            'relative top-28 text-xl': widthScreen > 1080
        }"
    >
        <h2 class="border-b border-black text-xl font-semibold mb-4 w-max">Cadastro de Cliente</h2>
        
        <q-form
            @submit="submitForm()"
            @reset="onReset"
            class="form-customer p-1"
        >
            <div class="border border-black p-5 bg-white rounded-md mb-5">
                <q-select 
                    v-model="type" 
                    :options="options" 
                    label="Tipo de cadastro" 
                    filled 
                />

                <div v-if="type === 'Física'">
                    <q-input 
                        v-model="form.trade_name" 
                        type="text" 
                        label="Nome" 
                        maxlength="120" 
                        color="grey-7"

                    />

                    <q-input 
                        v-model="form.cpf" 
                        v-bind:mask="'###.###.###-##'"
                        maxlength="14"
                        type="text" 
                        label="CPF"
                        color="grey-7"
                        
                    />  

                </div>
                <div v-else>
                    <q-input 
                        v-model="form.company_name" 
                        type="text" 
                        label="Razão social" 
                        maxlength="120" 
                        color="grey-7"

                    />

                    <q-input 
                        v-model="form.cnpj" 
                        v-bind:mask="'##.###.###/####-##'"
                        @vue:updated="getDataApis()"
                        maxlength="18"
                        type="text" 
                        label="CNPJ"                 
                        color="grey-7"

                    />

                </div>
            </div>
            <q-input 
                v-model="form.cep"
                v-bind:mask="'#####-###'"
                type="text" 
                label="CEP"
                maxlength="9"
                color="grey-7"

            />

            <q-input 
                v-model="form.address" 
                type="text" 
                label="Endereço" 
                maxlength="120"
                color="grey-7"

            />

            <q-input 
                v-model="form.number" 
                type="text" 
                label="Número" 
                maxlength="30"
                color="grey-7"

            />
            
            <q-input 
                v-model="form.email" 
                type="email" 
                label="E-mail"
                maxlength="120" 
                color="grey-7"

            />
            
            <q-input 
                v-model="form.phone" 
                type="tel"
                label="Número de telefone" 
                maxlength="16"
                color="grey-7"

            />

            <div class="mt-2">
                <q-checkbox 
                    left-label 
                    v-model="form.is_customer" 
                    label="Cliente" 
                />

                <q-checkbox 
                    left-label 
                    v-model="form.is_supplier" 
                    label="Fornecedor" 
                />

                <q-checkbox 
                    left-label 
                    v-model="form.is_driver" 
                    label="Motorista" 
                />
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

<script>
    import { api } from 'src/boot/axios';
    import { LocalStorage, useQuasar } from 'quasar';
    import { onBeforeUnmount } from 'vue';
    import axios from 'axios'

    export default {
        setup()
        {
            let $q = useQuasar();
            let timer

            onBeforeUnmount(() => { 
                if(timer !== void 0)
                {
                    clearTimeout(timer)
                    $q.loading.hide()
                }
            })

            return {
                options: [
                    'Física',
                    'Júridica'
                ],

                showLoading()
                {
                    $q.loading.show({
                        message: 'Criando cliente ...'

                    })
                    timer = setTimeout(() => {
                        $q.loading.hide()
                        timer = void 0
                    }, 3000)
                }
            }
        
        },

        data() {
            return {
                type: '',
                form: {
                    name: '',
                    cpf: '',
                    cnpj: '',
                    cep: '',
                    address: '',
                    number: '',
                    email: '',
                    is_customer: false,
                    is_driver: false,
                    is_supplier: false,
                    phone: '',
                    issuer_id: LocalStorage.getItem("issuer_id")
                },
            };
        },

        methods: {
            async submitForm() {
                try {
                    this.form.cpf = this.form.cpf.replace(/\D/g, '')
                    this.form.cnpj = this.form.cnpj.replace(/\D/g, '')
                    this.form.cep = this.form.cep.replace(/\D/g, '') 

                    console.log('forms', this.form)

                    const response = await api.post(`/customers/create`, this.form);
                    console.log(response.data)
                    if(response.data.success)
                    {
                        alert(`Cliente: ${this.form.name}, cadastrado com sucesso!`)
                        this.$emit("close", false)
                    }
                    
                } catch (error) {
                    alert("Ocorreu um erro ao cadastrar o cliente.");
                    console.error('Erro', error)
                }
            },

            async getDataApis()
            {
                const cnpj = this.form.cnpj.replace(/\D/g, '')
                if(cnpj.length === 14)
                {
                    const data = await axios.get(`${process.env.API_CNPJA}/${cnpj}`);
                    console.log(data)
                }

            },

            onReset()
            {
                this.form = {
                    name: '',
                    cpf: '',
                    cnpj: '',
                    cep: '',
                    address: '',
                    number: '',
                    email: '',
                    password: '',
                    password_: '',
                    phone: '',
                }
            }
        },

        props: {
            widthScreen: {
                type: Number,
                required: true
            }
        },

        emits: [
            'close'
        ],

        
    };
</script>

<style lang="scss">
    .form-customer {
        width: 60vh;
    }
    
</style>