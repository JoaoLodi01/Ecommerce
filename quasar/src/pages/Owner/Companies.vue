<template>
    <div class="text-center">
        <div class="head">
            <div class="">
                <router-link to="/" class="flex">   
                    <span class="mt-0.5 ml-2">Voltar</span>
                </router-link>
            </div>    
            
            <h1>Listagem das suas empresas</h1>
            
        </div>

        <div class="companies flex justify-center">
            <q-card class="w-80">
                <q-card-section>
                    <div class="text-h6 text-center">Adicionar uma nova empresa</div>
                </q-card-section>
                <q-card-section>
                    <div class="flex justify-center">
                        <router-link to="/register-issuer">
                            <svg 
                                xmlns="http://www.w3.org/2000/svg" 
                                fill="none" 
                                viewBox="0 0 24 24" 
                                stroke-width="1.5" 
                                stroke="currentColor" 
                                class="size-12"
                            >
                                <path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15" />
                            </svg>
                        </router-link>
                        
                    </div>

                </q-card-section>
            </q-card>

            <q-card class="ml-8" v-for="(companie, id) in companies" :key="id">
                <q-card-section class="">
                    Empresa: {{ companie.name }}
                    <br>
                    {{ companie.cnpj ? 'CNPJ' : 'CPF' }}: {{ companie.cnpj.replace(/(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})/, '$1.$2.$3/$4-$5') ?? companie.cpf.replace(/(\d{3})(\d{3})(\d{3})(\d{2})/, '$1.$2.$3-$4') }}
                    <br>
                    <q-btn 
                        color="primary" 
                        icon="check" 
                        label="OK" 
                        @click="joinCompanie(companie.name, companie.id)"

                    />
                </q-card-section>
            </q-card>
        </div>
        
    </div>
</template>

<script>
    import { LocalStorage } from 'quasar';
    import { api } from 'src/boot/axios';   

    export default {
        data()
        {
            return {
                companies: [ ]
            }
        },

        methods: {
            async getCompanies()
            {
                const response = await api.get(`issuer/all/companies/${LocalStorage.getItem("uuse_id")}`);
                console.log(response)
                if(response.data.success)
                {
                    this.companies = response.data.companies   
                }
            },

            async joinCompanie(name, issuer_id)
            {
                LocalStorage.setItem("issuer_id", issuer_id)
                this.$router.push({ 
                    path:`${name}/home`, 
                    params: { name: name }
                })
            }
        },

        mounted()
        {
            this.getCompanies()
            const uuse_id = LocalStorage.getItem("uuse_id")
            console.log('uuse_id: /companies: ', uuse_id)
            if(!uuse_id)
            {
                this.$router.push('/register-owner')   
            }
        }
    }
</script> 