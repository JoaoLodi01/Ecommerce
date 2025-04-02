<template>
    <div class="ml-14 mr-14 border border-black mt-5 p-6 bg-white shadow-md rounded">
        <div class="flex">
            <h2 class="text-xl font-semibold mb-4 w-max">Edição do Cliente: {{ customerName }}</h2>
            <span @click="closeUpdate()" class="cursor-pointer text-xl ml-auto">X</span>
        </div>

        <q-form
            @submit="submitForm()"
            @reset="onReset"
            class="p-1 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6"
        >
            <q-input 
                v-model="form.name" 
                type="text" 
                label="Nome" 
            />
    
            <q-input 
                v-model="form.cpf" 
                @update:modelValue="formatCPF"
                maxlength="14"
                type="text" 
                label="CPF"
            />
    
            <q-input 
                v-model="form.cnpj" 
                @update:modelValue="formatCNPJ"
                maxlength="18"
                type="text" 
                label="CNPJ" 
            />
    
            <q-input 
                v-model="form.cep"
                @update:model-value="formatCEP"
                maxlength="8"
                type="text" 
                label="CEP" 
            />
    
            <q-input 
                v-model="form.address" 
                type="text" 
                label="Endereço" 
            />
    
            <q-input 
                v-model="form.number" 
                type="text" 
                label="Número" 
            />
            
            <q-input 
                v-model="form.email" 
                type="email" 
                label="E-mail" 
            />
            
            <q-input 
                v-model="form.phone" 
                type="tel"
                label="Número de telefone" 
            />
    
            <q-input 
                v-model="form.oldPassword" 
                :type="showPassword ? 'text' : 'password'"
                label="Senha" 
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
            
            <div>
                <q-btn type="submit" class="mr-5">
                    <button @click="showLoading('Alterando')">Alterar</button>
                </q-btn>
                
                <q-btn type="button" @click="showLoading('Recarregando')">   
                    <button @click="onReset()">Cancelar</button>
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
                showLoading(message)
                {
                    $q.loading.show({
                        message: `${message} dados do cliente ...`

                    })

                    timer = setTimeout(() => {
                        $q.loading.hide()
                        timer = void 0
                    }, 4000)
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
                    oldPassword: '',
                    newPassword: '',
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
                    this.form.cpf ? this.form.cpf.replace(/\D/g, '') : null
                    this.form.cnpj ? this.form.cnpj.replace(/\D/g, '') : null
                    this.form.cep = this.form.cep.replace(/\D/g, '') 
                
                    const response = await api.put(`/customers/${this.customerID}`, this.form);
                if(response.data.success)
                {
                    alert(`Cliente: ${this.form.name}, alterado com sucesso!`)
                    this.$emit("close", false)
                }
                    
                } catch (error) {
                    alert("Ocorreu um erro ao cadastrar o cliente.");
                    console.error('Erro', error)
                }
            },

            async getCustomer() {
                const customer = await api.get(`/customers/${this.customerID}`)
                const data = customer.data.customer

                this.form = {
                    name: data.name,
                    cpf: data.cpf,
                    cnpj: data.cnpj,
                    cep: data.cep,
                    address: data.address,
                    number: data.number,
                    email: data.email,
                    oldPassword: data.password,
                    phone: data.phone,
                }
            },      

            onReset()
            {
                this.getCustomer()
            },

            closeUpdate()
            {
                this.$emit("close", false)
            }
        },
  
        props: {
            customerID: {
                type: Number,
                required: true
                
            },
            customerName: {
                type: String,
                required: true
            }
        },

        emits: [
            'close'
        ],

        mounted()
        {
            this.getCustomer()
        }
      };
  </script>