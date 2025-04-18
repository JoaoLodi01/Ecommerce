<template>
    <div 
        class="ml-14 mr-14 border border-black mt-5 p-6 bg-white shadow-md rounded" 
        :class="{
            'relative top-10 left-6': widthScreen <= 1080
        }"
    >
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
                    'ml-7': widthScreen <= 1080
                }"
            >
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
                typeOptions: [
                    'Cliente',
                    'Fornecedor',
                    'Motorista'
                ],

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
                    type: [],
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
                    type: data.type,
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

            widthScreen: {
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