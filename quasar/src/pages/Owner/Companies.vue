<template>
    <div class="text-center h-96">
        <header class="head flex justify-between bg-slate-600 text-white text-xl p-5 mb-8">
            <div class="inline-flex">
                <h3 
                    class="ml-5 mr-5"
                >
                    Bem vindo(a)! Sinta-se a vontade para escolher a sua empresa!
                </h3>
                
                <router-link 
                    to="/" 
                    class="mt-auto mb-auto mr-6" 
                    v-if="witdhScreen >= 1366"
                >
                    <span class="mt-0.5 ml-2 hover:text-slate-300 hover:border-b">Voltar ao início</span>
                </router-link>

                <div 
                    class="cursor-pointer mt-auto mb-auto" 
                    @click="logout()"
                >
                    <span class="mt-0.5 ml-2 hover:text-slate-300 hover:border-b">Sair</span>
                </div>

            </div>
            <div class="mt-auto mb-auto border-b">
                Usuário: {{ owner_name }} |
                CPF: {{ owner_cpf.replace(/(\d{3})(\d{3})(\d{3})(\d{2})/, '$1.$2.$3-$4') }}
            </div>
        </header>

        <div class="companies flex justify-center">
            <q-card class="w-80">
                <q-card-section>
                    <div class="flex justify-center p-10">
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
                    <div class="text-h6 text-center">Adicionar uma nova empresa</div>

                </q-card-section>
            
            </q-card>

            <q-card v-if="companies.length <= 0">
                <q-card-section>
                    <q-skeleton height="150px" square />
                    <span class="mt-5">Carregando dados...</span>
                </q-card-section>
            </q-card>

            <q-card
                class="q-card" 
                v-for="(companie, id) in companies" 
                :key="id"
                
            >
                <q-card-section>
                    <span class="text-xl">{{ companie.company_name }}</span>
                    <br>
                    <q-btn 
                        color="primary" 
                        icon="check" 
                        label="Entrar" 
                        @click="joinCompanie(companie.company_name, companie.id)"
                        class="mt-8"

                    />
                    
                    <p class="mt-5">
                        {{ companie.cnpj ? 'CNPJ' : 'CPF' }} : {{ companie.cnpj?.replace(/(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})/, '$1.$2.$3/$4-$5') ?? companie.cpf?.replace(/(\d{3})(\d{3})(\d{3})(\d{2})/, '$1.$2.$3-$4') }}
                    </p>
                </q-card-section>
            </q-card>
        </div>
        
    </div>
</template>

<script>
    import { LocalStorage } from 'quasar';
    import { api } from 'src/boot/axios';   
    import OwnerData from './OwnerData.vue';

    export default {
        data()
        {
            return {
                companies: [ ],
                owner_name: LocalStorage.getItem("owner_name"),
                owner_cpf: LocalStorage.getItem("owner_cpf"),
                witdhScreen: 0,
                showOptions: true

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
                console.log('issuer_id', issuer_id)
                const first_name = name.split(" ")[0]
            
                LocalStorage.setItem("issuer_id", issuer_id)
                LocalStorage.setItem("first_name", first_name)
                LocalStorage.setItem("issuer_name", name)
                const response = await api.get(`/first-steps/${issuer_id}`)
                const completed = response.data.first_steps.complete_issuer === 1 ? true : false;
                
                if(!completed)
                {
                    LocalStorage.setItem("_completed", false)
                    this.$router.push({ 
                        path:`/${first_name}/first/companie-data`, 
                        params: { name: LocalStorage.getItem("first_name") }
                    })
                    
                } else {
                    this.$router.push({ 
                        path:`/${first_name}/home`, 
                        params: { name: LocalStorage.getItem("first_name") }
                    })

                }
                
            },

            async logout()
            {
                const ofCourse = confirm('Deseja realmente sair?')
                if(ofCourse)
                {
                const res = await api.post('/auth/logout')
                if(res.data.success)
                {
                    LocalStorage.remove("auth_token")  
                    this.$router.push(res.data.route)

                }
                }
            }
        },

        mounted()
        {
            this.getCompanies()
            const uuse_id = LocalStorage.getItem("uuse_id")
            
            if(!uuse_id)
            {
                this.$router.push('/register-owner')   
            }

            this.witdhScreen = screen.width
            console.log(this.witdhScreen)
        },

        components: {
            OwnerData
        }
    }
</script> 

<style lang="scss">
    @media (max-width: 1680px)
    {
        .q-card{
            margin-top: 3rem;
            width: 20rem;
        }
                
    }
    
    @media (min-width: 1366px)
    {
        .q-card{
            margin-left: 3rem;
            width: 20rem;
        }
                
    }
    
</style>