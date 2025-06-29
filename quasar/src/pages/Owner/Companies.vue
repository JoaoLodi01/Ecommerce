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
                CPF: {{ String(owner_cpf).replace(/(\d{3})(\d{3})(\d{3})(\d{2})/, '$1.$2.$3-$4') }}
            </div>
        </header>

        <Transition name="slide-up">
            <div class="companies flex justify-center" v-if="showContent">
                <q-card class="w-80 hover:drop-shadow-lg">
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
                
                <q-card
                    class="q-card ml-5 mr-5 hover:drop-shadow-lg"
                    v-for="(companie, id) in companies" 
                    :key="id"
                    
                >
                    <q-card-section>
                        <span class="text-xl">{{ companie.companyName }}</span>
                        <br>
                        <q-btn 
                            label="Entrar" 
                            @click="joinCompanie(companie.companyName, companie.id)"
                            class="mt-8 bg-[#BF3658] text-white"

                        />
                        
                        <p class="mt-5">
                            {{  companie.cnpj ? 'CNPJ' : 'CPF' }} : {{ companie.cnpj?.replace(/(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})/, '$1.$2.$3/$4-$5') ?? companie.cpf?.replace(/(\d{3})(\d{3})(\d{3})(\d{2})/, '$1.$2.$3-$4') }}
                        </p>    
                    </q-card-section>
                </q-card>
            </div>
        </Transition>
    </div>
</template>

<script setup lang="ts">
    import { LocalStorage } from 'quasar';
    import { ref, onMounted } from 'vue';
    import { api } from 'src/boot/axios';   
    import { useRouter } from 'vue-router';
    import camelcaseKeys from 'camelcase-keys';
    import getColors from 'src/services/getColors';

    type TCompanies = {
        id: number,
        companyName: string,
        cnpj: string,
        cpf: string
    };

    const router = useRouter();
    const owner_name = ref<number>(LocalStorage.getItem("owner_name"));
    const owner_cpf = ref<number>(LocalStorage.getItem("owner_cpf"));
    let companies = ref<TCompanies[]>([ ]);
    let witdhScreen = ref<number>(0);
    let has = ref<boolean>(false);
    let showContent = ref<boolean>(false);
        
    const getCompanies = async () =>
    {
        const res = await api.get(`issuer/all/companies/${LocalStorage.getItem("uuse_id")}`);
        
        if(res.data.success)
        {
            has.value = true;
            const customers = camelcaseKeys(res.data.data, { deep: true });
            companies.value = customers;
        };
    };

    const joinCompanie = async (name: string, issuer_id: number) =>
    {
        console.log('issuer_id', issuer_id);
        const first_name = name.split(" ")[0];
    
        LocalStorage.set("first_name", first_name);
        LocalStorage.set("issuer_id", issuer_id);
        LocalStorage.set("issuer_name", name);

        const response = await api.get(`/first-steps/${issuer_id}`);
        const data = camelcaseKeys(response.data.data, { deep: true });
        
        const completed = data.completeIssuer === 1 ? true : false;

        getColors(LocalStorage.getItem("issuer_id"));
        
        if(!completed)
        {
            LocalStorage.set("_completed", false);
            router.push({ 
                name: `FirstIssuerData`, 
                params: { name: LocalStorage.getItem("first_name") }
            });
            
        } else {
            router.push({ 
                name: 'Start', 
                params: { name: LocalStorage.getItem("first_name") }
            });
        };
    };

    const logout = async () =>
    {
        const ofCourse = confirm('Deseja realmente sair?');
        if(ofCourse)
        {
            const res = await api.post('/auth/logout');
            if(res.data.success)
            {
                LocalStorage.remove("auth_token");
                LocalStorage.getItem("expire");

                router.push(res.data.route);

            };
        };
    };

    onMounted(() => {
        getCompanies();

        showContent.value = true;

        const uuse_id = LocalStorage.getItem("uuse_id");
        
        if(!uuse_id)
        {
            router.push('/register-owner');

        };

        witdhScreen.value = screen.width;

    });
</script> 

<style lang="scss">
    .slide-up-enter-from {
        opacity: 0;
        transform: translateY(50px);

    }

    .slide-up-enter-to {
        opacity: 1;
        transform: translateY(0);
        
    }

    .slide-up-enter-active {
        transition: all 0.5s ease-out;
    }

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