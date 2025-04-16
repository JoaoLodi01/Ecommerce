<template>
    <div 
        class="ml-14 mr-14 border border-black mt-5 p-6 bg-white shadow-md rounded"
        :class="{
            'relative top-10 left-12': widthScreen <= 1080,
            'ml-72': widthScreen > 1080
        }"
    >
        <h2 class="border-b border-black text-xl font-semibold mb-4 w-max">Cadastro de Cliente</h2>
        
        <q-form
            @submit="submitForm()"
            @reset="onReset"
            class="p-1 "
            :class="{ 
                'grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6': widthScreen > 1080
            }"
        >
            <q-input 
                v-model="form.name" 
                type="text" 
                label="Nome" 
                maxlength="120" 
                color="grey-7"

            />

            <q-input 
                v-model="form.cpf" 
                @update:modelValue="formatCPF"
                type="text" 
                label="CPF"
                maxlength="14"
                color="grey-7"
                
            />

            <q-input 
                v-model="form.cnpj" 
                @update:modelValue="formatCNPJ"
                type="text" 
                label="CNPJ" 
                maxlength="18"
                color="grey-7"

            />

            <q-input 
                v-model="form.cep"
                @update:model-value="formatCEP"
                type="text" 
                label="CEP"
                maxlength="8"
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

            <q-select 
                v-model="form.type" 
                :options="typeOptions" 
                label="Tipo de cadastro" 
                color="grey-7"
                multiple
                filled
                stack-label 

            />
            
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
    import { useQuasar } from 'quasar';
    import { onBeforeUnmount } from 'vue';

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
                typeOptions: [
                    'Cliente',
                    'Fornecedor',
                    'Motorista'
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
                form: {
                    name: '',
                    cpf: '',
                    cnpj: '',
                    cep: '',
                    address: '',
                    number: '',
                    email: '',
                    type: [],
                    phone: '',
                },

                
                
            };
        },

        methods: {
            formatCPF()
            {
                let cpf = this.form.cpf.replace(/\D/g, '')

                if(cpf.length > 11)
                {
                    cpf = cpf.substring(0, 11)

                }
                this.form.cpf = cpf.replace(/(\d{3})(\d{3})(\d{3})(\d{2})/, '$1.$2.$3-$4');

            },

            formatCNPJ()
            {
                let cnpj = this.form.cnpj.replace(/\D/g, '')

                if(cnpj.length > 14)
                {
                    cnpj = cnpj.substring(0, 11)

                }
                this.form.cnpj = cnpj.replace(/(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})/, '$1.$2.$3/$4-$5');

            },

            formatCEP() {
                let cep = this.form.cep.replace(/\D/g, ''); 

                if (cep.length > 8) {
                    cep = cep.substring(0, 8);
                }

                this.form.cep = cep.replace(/(\d{5})(\d{3})/, '$1-$2');
            },

            formatPhone() {
                let phone = this.form.phone.replace(/\D/g, ''); 

                if (phone.length > 14) {
                    phone = phone.substring(0, 8);
                }

                this.form.phone = phone.replace(/(\d{2})(\d{3})/, '$1-$2');
            },

            async submitForm() {
                try {
                    this.form.cpf = this.form.cpf.replace(/\D/g, '')
                    this.form.cnpj = this.form.cnpj.replace(/\D/g, '')
                    this.form.cep = this.form.cep.replace(/\D/g, '') 
                    
                    const response = await api.post(`/customers/create`, this.form);
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
        ]
    };
</script>