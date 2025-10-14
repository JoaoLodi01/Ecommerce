<template>
    <div class="text-center h-96">
        <header class="head flex justify-between bg-[#274690] text-white text-xl p-5 mb-8">
            <div class="inline-flex">
                <h3 
                    class="ml-5 mr-5"
                >
                    Bem vindo(a)! Sinta-se a vontade para escolher a sua empresa!
                </h3>
                
                <router-link 
                    to="/" 
                    class="mt-auto mb-auto mr-6"
                >
                    <span class="mt-0.5 ml-2 ">Voltar ao início</span>
                </router-link>

                <div 
                    class="cursor-pointer mt-auto mb-auto" 
                    @click="showConfirmFn(0, 'logout')"
                >
                    <span class="mt-0.5 ml-2">Sair</span>
                </div>

            </div>

            <div class="mt-auto mb-auto flex">
                Usuário: {{ owner_name }} - 
                CPF: {{ String(owner_cpf).replace(/(\d{3})(\d{3})(\d{3})(\d{2})/, '$1.$2.$3-$4') }}
                
            </div>
        </header>

         <div v-if="!showContent">
            <LoandingPage
                :text="`Carregando empresas...`"

            />
        </div>

        <Transition name="slide-up">
            <div class="flex justify-center" v-if="showContent">
                <q-card class="w-80 hover:drop-shadow-lg">
                    <router-link to="/register-issuer">
                        <q-card-section>
                            <div class="flex justify-center mt-8">
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
                                                            
                            </div>

                            <div class="text-h6 text-center mt-5">Clique aqui para adicionar uma empresa!</div>

                        </q-card-section>
                    </router-link>
                </q-card>
                
                <q-card
                    class="q-card ml-5 mr-5 hover:drop-shadow-lg transition-transform hover:-translate-y-2"
                    v-for="(companie, id) in companies" 
                    :key="id"
                    
                >
                    <div class="mt-3 mr-5 flex justify-end cursor-pointer transition-transform hover:-translate-y-2">
                        <div 
                            v-if="companie.id !== IDEditCompanie" 
                            @click.prevent="IDEditCompanie === 0 ? editCompanie(companie.id) : null"
                            
                        >
                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M11.42 15.17 17.25 21A2.652 2.652 0 0 0 21 17.25l-5.877-5.877M11.42 15.17l2.496-3.03c.317-.384.74-.626 1.208-.766M11.42 15.17l-4.655 5.653a2.548 2.548 0 1 1-3.586-3.586l6.837-5.63m5.108-.233c.55-.164 1.163-.188 1.743-.14a4.5 4.5 0 0 0 4.486-6.336l-3.276 3.277a3.004 3.004 0 0 1-2.25-2.25l3.276-3.276a4.5 4.5 0 0 0-6.336 4.486c.091 1.076-.071 2.264-.904 2.95l-.102.085m-1.745 1.437L5.909 7.5H4.5L2.25 3.75l1.5-1.5L7.5 4.5v1.409l4.26 4.26m-1.745 1.437 1.745-1.437m6.615 8.206L15.75 15.75M4.867 19.125h.008v.008h-.008v-.008Z" />
                            </svg>
                        </div>

                        <div v-if="showEditCompanie && companie.id === IDEditCompanie"  @click="editCompanie(0)">
                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M6 18 18 6M6 6l12 12" />
                            </svg>
                        </div>
                        
                    </div>
                    <q-card-section>
                        <div v-show="companie.id !== IDEditCompanie">
                            <span class="text-xl">{{ companie.companyName }}</span>
                            <br>
                            <q-btn 
                                label="Entrar" 
                                @click="joinCompanie(companie.companyName, companie.id)"
                                class="mt-2 text-white"
                                color="primary"
                                :disable="!companie.active"

                            />
                            
                            <p class="mt-4">
                                {{  companie.cnpj ? 'CNPJ' : 'CPF' }} : {{ companie.cnpj ? companie.cnpj.replace(/(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})/, '$1.$2.$3/$4-$5') : companie.cpf.replace(/(\d{3})(\d{3})(\d{3})(\d{2})/, '$1.$2.$3-$4') }}
                            </p>
                        </div>

                        <div class="flex justify-center" v-show="showEditCompanie && companie.id === IDEditCompanie">
                            <div v-if="companie.active">
                                <div class="mb-5" >
                                    <q-btn 
                                        color="red" 
                                        label="Desabilitar empresa" 
                                        @click="showConfirmFn(companie.id, 'disable')"

                                    />
                                </div>
                                
                                <div>
                                    <q-btn 
                                        color="green" 
                                        label="Transferir empresa" 
                                        @click="showConfirmFn(companie.id, 'transfer')"
        
                                    />
                                </div>
                            </div>
                            <div v-else class="mt-5">
                                <q-btn 
                                    color="green" 
                                    label="Reativar empresa" 
                                    @click="showConfirmFn(companie.id, 'active')"
    
                                />
                            </div>
                        </div>
                    </q-card-section>
                </q-card>
            </div>
        </Transition>
    </div>

    <LoandingPage
        v-if="showLoandig"
        :text="`Carregando dados da empresa ${companieName}...`"

    />

    <ConfirmPage
        v-if="showConfirm"
        @confirm="handleOperation($event)"
        :operation="typeOperation"

    />
    
</template>

<script setup lang="ts">
    import { LocalStorage, useQuasar } from 'quasar';
    import { ref, onMounted } from 'vue';
    import { api } from 'src/boot/axios';   
    import { useRouter } from 'vue-router';
    import camelcaseKeys from 'camelcase-keys';
    import getColors from 'src/services/getColors';
    import LoandingPage from 'src/components/Loanding/LoandingPage.vue';
    import ConfirmPage from 'src/components/Confirm/ConfirmPage.vue'
    import { getLiberations } from 'src/services/Access/getLiberations';

    type TCompanies = {
        active: boolean,
        id: number,
        companyName: string,
        cnpj: string,
        cpf: string
    };

    const $q = useQuasar();
    const router = useRouter();
    const owner_name = ref<number>(LocalStorage.getItem("owner_name"));
    const owner_cpf = ref<number>(LocalStorage.getItem("owner_cpf"));

    let companies = ref<TCompanies[]>([ ]);
    let witdhScreen = ref<number>(0);
    let has = ref<boolean>(false);
    let showContent = ref<boolean>(false);
    let showEditCompanie = ref<boolean>(false);
    let IDEditCompanie = ref<number>(0);
    let showLoandig = ref<boolean>(false);
    let showConfirm = ref<boolean>(false);
    let typeOperation = ref<string>('');
    let companieName = ref<string>('');

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
        const ecommerceReleased = LocalStorage.getItem("liberationEcommerce");
        
        if(ecommerceReleased)
        {
            showLoandig.value = true;
            companieName.value = name;

            const first_name = name.split(" ")[0];

            LocalStorage.set("first_name", first_name);
            LocalStorage.set("issuer_id", issuer_id);
            LocalStorage.set("issuer_name", name);

            const response = await api.get(`/first-steps/${issuer_id}`);
            const data = camelcaseKeys(response.data.data, { deep: true });
            
            const completed = data.completeIssuer === 1 ? true : false;

            console.log('Aqui', LocalStorage.getItem("issuer_id"));
            
            if(LocalStorage.getItem("issuer_id"))
            {
                getColors(LocalStorage.getItem("issuer_id"));

            } else {
                return;
            };
            
            if(!completed)
            {
                LocalStorage.set("_completed", false);
                router.push({ 
                    name: `FirstIssuerData`, 
                    params: { name: LocalStorage.getItem("first_name") }
                });

                showLoandig.value = false;
            } else {
                router.push({ 
                    name: 'Start', 
                    params: { name: LocalStorage.getItem("first_name") }
                });

                showLoandig.value = false;
            };

        } else {
            $q.notify({
                color: 'red',
                message: 'Ecommerce não liberado, contate o revendedor/fornecedor',
                position: 'top',
                timeout: 1500

            });
        };
    };

    const editCompanie = (companieID: number) =>
    {
        showEditCompanie.value = !showEditCompanie.value;
        IDEditCompanie.value = companieID;
        if(IDEditCompanie.value) return;
    };

    const showConfirmFn = (companieID: number, operation: string) => 
    {
        showConfirm.value = true;
        typeOperation.value = operation;
        LocalStorage.setItem("companieID", companieID);
    
    };

    const handleOperation = async (event: TEmit[]|boolean): Promise<void> =>
    {
        const operation = event[0]['operation'];
        const value = event[0]['value'];
        if(!value) $q.notify({ color: 'red', message: 'Operação cancelada!', position: 'top', timeout: 2000 });

        if(operation === 'disable' || operation === 'active')
        {
            const res = value ? await api.put(`/issuer/${operation}-company/${LocalStorage.getItem("companieID")}`) : null;
            const data = res.data;

            $q.notify({
                color: data.success ? 'green' : 'red',
                message: data.message,
                position: 'top',
                timeout: 2000

            });
        } else if(operation === 'transfer')
        {
            
        } else if(operation === 'logout')
        {
            logout();

        };

        IDEditCompanie.value = 0;
        showConfirm.value = false;
        showEditCompanie.value = false;
        LocalStorage.remove("companieID");
        getCompanies();

    };

    const logout = async () =>
    {
        const res = await api.post('/auth/logout');
        if(res.data.success)
        {
            LocalStorage.remove("auth_token");
            LocalStorage.remove("issuer_id");
            LocalStorage.getItem("expire");

            $q.notify({
                color: 'green',
                message: 'Volte sempre!',
                position: 'top',
                timeout: 1000

            });

            router.push(res.data.route);

        };
    };

    onMounted(async () => {
        await getCompanies();
        const liberations = await getLiberations(LocalStorage.getItem("user_id"));        

        if(liberations){
            showContent.value = true;
        }

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
            margin-left: 2rem;
            margin-right: 2rem;
            margin-top: 2rem;
            width: 18rem;
        } 
    }
    
    @media (min-width: 1366px)
    {
        .q-card{
            margin-left: 2rem;
            margin-right: 2rem;
            margin-top: 2rem;
            width: 18rem;
            height: 13rem;

        }
    }
</style>