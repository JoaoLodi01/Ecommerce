<template>
    <div class="p-10">
        <router-link to="/companies" class="flex">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                <path stroke-linecap="round" stroke-linejoin="round" d="M10.5 19.5 3 12m0 0 7.5-7.5M3 12h18" />
            </svg>
            <span class="mt-0.5 ml-2">Voltar</span>
        </router-link>
    </div>

    <div class="flex justify-center">
        <div class="login-form border border-black p-5 rounded-lg shadow-xl w-96">
            <q-form
                @submit.prevent="createIssuer()"
                
            >
                <h1 class="text-xl ml-auto mr-auto border-b border-black w-max mb-4">Registrar Emitente</h1>
                <q-input 
                    v-model="form.company_name"
                    @update:model-value="this.form.trade_name = this.form.company_name"   
                    type="text" 
                    filled        
                    label="Razão Social" 
                    stack-label
                    class="mb-4"
                    color="[#BF3658]"
                    
                />

                <q-input 
                    v-model="form.trade_name"
                    type="text" 
                    filled        
                    label="Nome Fantasia" 
                    stack-label
                    class="mb-4"
                    color="[#BF3658]"
                    
                />

                <q-input 
                    v-model="form.cnpj"
                    filled        
                    label="CNPJ" 
                    stack-label
                    class="mb-4"
                    color="[#BF3658]"
                    v-bind:mask="'##.###.###/####-##'"
                    maxlength="18"
                    @update:model-value="getDataCNPJ()"
                    
                />

                <q-input 
                    v-model="form.cpf"
                    filled        
                    label="CPF" 
                    stack-label
                    class="mb-4"
                    color="[#BF3658]"
                    v-bind:mask="'###.###.###-##'"
                    maxlength="14"

                />

                <q-input 
                    v-model="form.date_of_foundation"
                    filled        
                    type="date"
                    label="Data de fundação" 
                    stack-label
                    class="mb-4"
                    color="[#BF3658]"

                /> 
                
                <div class="flex justify-center">
                    <q-btn 
                        type="submit"
                        label="Criar Empresa"
                        class="m-2"
                        color="[#BF3658]"   
                    />
                </div>
            
                
            </q-form>
            
        </div>
    </div>
</template>

<script>
    import { LocalStorage, useQuasar } from 'quasar'
    import { api } from 'src/boot/axios'
    import axios from 'axios'
    
    export default {
        data()
        {
            return {
                form: {
                    company_name: '',
                    trade_name: '',
                    cnpj: '',
                    cpf: '',
                    date_of_foundation: null,
                    cod_crt: '',
                    cod_cnae: '',
                    main_activity: ''
                    
                },
                timer: null
            }
        },
        
        methods: {
            showLoading () {
                this.$q.loading.show({
                    message: 'Cadastrando sua empresa ...'
                })

                this.timer = setTimeout(() => {
                    this.$q.loading.hide()
                    this.timer = void 0
        
                }, 1000)
            },

            hideLoading() {
                if (this.timer !== void 0) {
                    clearTimeout(this.timer)
                    this.timer = void 0
                }

                this.$q.loading.hide()
            },

            async getDataCNPJ()
            {
                const cnpj = this.form.cnpj.replace(/\D/g, '')
                if(
                    cnpj.length == 14 && 
                    this.form.company_name == '' && 
                    this.form.trade_name == ''
                )
                {
                    const data = await axios.get(`${process.env.API_CNPJ}/${cnpj}`)
                    
                    this.form.company_name = data.data.alias
                    this.form.trade_name = data.data.alias
                    this.form.date_of_foundation = data.data.founded
                    this.form.cod_cnae = data.data.mainActivity.id
                    this.form.main_activity = data.data.mainActivity.text
                    
                };
                
            },

            async createIssuer()
            {
                this.showLoading()
                try {
                    const response = await api.post('/registers/issuer/create', {
                        company_name: this.form.company_name,
                        trade_name: this.form.trade_name,
                        cpf: this.form.cpf.replace(/\D/g, ''),
                        cnpj: this.form.cnpj.replace(/\D/g, ''),
                        date_of_foundation: this.form.date_of_foundation,
                        cod_crt: this.form.cod_crt,
                        cod_cnae: this.form.cod_cnae,
                        main_activity: this.form.main_activity,              
                        uuse_id: LocalStorage.getItem("uuse_id"),
                        
                    })
                    
                    if(response.data.success)
                    {
                        this.$router.push({ path: '/companies' })
                        
                    } else {
                        alert(response.data)
                    }
                } catch (error) {
                    console.error('createIssuer', error)

                } finally {
                    this.hideLoading()
                }
            }   

        },
    }

</script>