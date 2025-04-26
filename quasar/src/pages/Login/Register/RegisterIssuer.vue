<template>
    <div class="p-10 flex">
        <router-link to="/companies" class="flex">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                <path stroke-linecap="round" stroke-linejoin="round" d="M10.5 19.5 3 12m0 0 7.5-7.5M3 12h18" />
            </svg>
            <span class="mt-0.5 ml-2">Voltar</span>
        </router-link>
    </div>
    <div class="flex justify-center">
        <div class="login-form border border-black p-5 rounded-lg shadow-xl">
            <q-form
                @submit.prevent="createIssuer()"
                
            >
                <h1 class="text-xl ml-auto mr-auto border-b border-black w-max mb-4">Registrar Emitente</h1>
                <q-input 
                    v-model="form.name"
                    type="text" 
                    filled        
                    label="Nome" 
                    stack-label
                    class="mb-4"
                    color="grey"
                    
                />

                <q-input 
                    v-model="form.cnpj"
                    filled        
                    label="CNPJ" 
                    stack-label
                    class="mb-4"
                    color="grey"
                    v-bind:mask="'##.###.###/####-##'"
                    maxlength="18"
                    @update:model-value=""
                    
                />

                <q-input 
                    v-model="form.cpf"
                    filled        
                    label="CPF" 
                    stack-label
                    class="mb-4"
                    color="grey"
                    v-bind:mask="'###.###.###-##'"
                    maxlength="14"

                /> 
                
                <q-input 
                    v-model="form.cep"
                    filled        
                    label="CEP" 
                    stack-label
                    class="mb-4"
                    color="grey"
                    v-bind:mask="'#####-###'"
                    maxlength="9"

                />   
                   
                <q-input 
                    filled        
                    label="Endereço" 
                    v-model="form.address"
                    stack-label
                    class="mb-4"
                    color="grey"
                    maxlength="100"

                />        
                   
                <q-input 
                    filled        
                    label="Número" 
                    v-model="form.number"
                    stack-label
                    class="mb-4"
                    color="grey"
                    maxlength="100"

                />       
                
                <q-btn 
                    @click=showLoading 
                    type="submit"
                    label="Criar conta"
                    class="m-2"
                    flat 
                    style="color: #1F2937"   
                />
                
                <router-link to="/login">
                    <q-btn
                        type="button"
                        class="m-2"
                        flat 
                        style="color: #1F2937"   
                        label="Já possui uma conta?"
                    />
                </router-link>
                
            </q-form>
            
        </div>
    </div>
</template>

<script>
    import { LocalStorage, useQuasar } from 'quasar'
    import axios, { api } from 'src/boot/axios'
    import { onBeforeUnmount } from 'vue'
    
    export default {
        setup()
        {
            const $q = useQuasar()
            let timer

            onBeforeUnmount(() => {
                if(timer !== void 0)
                {
                    clearTimeout(timer)
                    $q.loading.hide   
                }
            })

            return {
                showLoading () {
                    $q.loading.show({
                        message: 'Cadastrando sua empresa ...'
                    })

                    timer = setTimeout(() => {
                        $q.loading.hide()
                        timer = void 0
            
                    }, 2000)
                }
            }
        },

        data()
        {
            return {
                form: {
                    name: '',
                    cnpj: '',
                    cpf: '',
                    address: '',
                    number: '',
                    cep: '',
                    email: '',
                    phone: '',
                    
                }
            }
        },
        methods: {
            async getDataCNPJ()
            {
                const data = axios.get(process.env.API_CNPJ)

            },

            async createIssuer()
            {
                try {
                    const response = await api.post('/registers/issuer/create', {
                        name: this.form.name,
                        cpf: this.form.cpf.replace(/\D/g, ''),
                        cnpj: this.form.cnpj.replace(/\D/g, ''),
                        address: this.form.address,
                        number: this.form.number,
                        cep: this.form.cep.replace(/\D/g, ''),
                        uuse_id: LocalStorage.getItem("uuse_id"),
                        
                    })
                    console.log(response)

                    if(response.data.success)
                    {
                        this.$router.push({ path: '/companies' })
                    }
                } catch (error) {
                    console.error('createIssuer', error)

                }
            }
            
        },

        mounted()
        {
            console.log(`uuse_id: ${LocalStorage.getItem("uuse_id")}`)
        }
    }

</script>