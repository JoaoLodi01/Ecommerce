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
            />

            <q-input 
                v-model="form.cpf" 
                @update:modelValue="formatCPF"
                type="text" 
                label="CPF"
                maxlength="14"
                
            />

            <q-input 
                v-model="form.cnpj" 
                @update:modelValue="formatCNPJ"
                type="text" 
                label="CNPJ" 
                maxlength="18"

            />

            <q-input 
                v-model="form.cep"
                @update:model-value="formatCEP"
                type="text" 
                label="CEP"
                maxlength="8"

            />

            <q-input 
                v-model="form.address" 
                type="text" 
                label="Endereço" 
                maxlength="120"
            />

            <q-input 
                v-model="form.number" 
                type="text" 
                label="Número" 
                maxlength="30"
            />
            
            <q-input 
                v-model="form.email" 
                type="email" 
                label="E-mail"
                maxlength="120" 
            />
            
            <q-input 
                v-model="form.phone" 
                type="tel"
                label="Número de telefone" 
                maxlength="24"
            />

            <q-input 
                v-model="form.password" 
                :type="showPassword ? 'text' : 'password'"
                label="Senha" 
                maxlength="120" 
            >
                <svg 
                    @click="showPassword = !showPassword" 
                    xmlns="http://www.w3.org/2000/svg"
                    fill="none" 
                    viewBox="0 0 24 24" 
                    stroke-width="1.5" 
                    stroke="currentColor" 
                    class="size-4 mt-5 "
                    v-if="showPassword"
                >
                    <path stroke-linecap="round" stroke-linejoin="round" d="M2.036 12.322a1.012 1.012 0 0 1 0-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178Z" />
                    <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
                </svg>

                <svg 
                    @click="showPassword = !showPassword"         
                    xmlns="http://www.w3.org/2000/svg" 
                    fill="none" 
                    viewBox="0 0 24 24" 
                    stroke-width="1.5" 
                    stroke="currentColor" 
                    class="size-4 mt-5 text-gray-600"
                    v-if="!showPassword"
                >
                    <path stroke-linecap="round" stroke-linejoin="round" d="M3.98 8.223A10.477 10.477 0 0 0 1.934 12C3.226 16.338 7.244 19.5 12 19.5c.993 0 1.953-.138 2.863-.395M6.228 6.228A10.451 10.451 0 0 1 12 4.5c4.756 0 8.773 3.162 10.065 7.498a10.522 10.522 0 0 1-4.293 5.774M6.228 6.228 3 3m3.228 3.228 3.65 3.65m7.894 7.894L21 21m-3.228-3.228-3.65-3.65m0 0a3 3 0 1 0-4.243-4.243m4.242 4.242L9.88 9.88" />
                </svg>

            </q-input>
            
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
                    password: '',
                    phone: '',
                },
                showPassword: false,
                
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