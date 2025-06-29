<template>
    <div class="flex justify-center ml-14 mt-10 p-5">
        <q-form
            @submit="completeIssuer()"
            
        >
            <router-link v-if="!_completed" class="ml-5" to="/companies">Voltar</router-link>
            <h1 
                v-if="!_completed" 
                class="ml-5 text-2xl"
            >
                Complete o cadastro da sua empresa!
            </h1>
            
            <div class="bg-white p-5 rounded-lg mb-5">
                <h3 class="border-b mb-3">Dados da empresa</h3>
                <div class="flex">
                    <q-input 
                        class="w-max"
                        label="CNPJ/CPF"
                        v-if="issuer.cnpj"
                        v-model="issuer.cnpj" 
                        type="text" 
                        disable
                        
                    />
                    
                    <q-input 
                        class="w-max"
                        label="CNPJ/CPF"
                        v-else
                        v-model="issuer.cpf" 
                        type="text" 
                        disable
                        
                    />

                    <q-input  
                        class="w-max text-base ml-5"
                        label="Razão social:"
                        v-model="issuer.company_name"
                    />

                    <q-input  
                        class="w-max text-base ml-5"
                        label="Nome fantasia:"
                        v-model="issuer.trade_name"
                    />

                    <q-input 
                        class="w-max ml-5"
                        label="Fundação"
                        v-model="issuer.date_of_foundation" 
                        type="date" 
                               
                    />
                    
                </div>
            </div>
            
            <div class="mr-5 bg-white p-5 rounded-lg mb-5">
                <h3 class="border-b mb-5">Endereço</h3>
                <div class="flex">
                    <q-input 
                        v-model="issuer.cep"
                        v-on:update:model-value="getCEPData()"
                        filled        
                        label="CEP *" 
                        class="mb-4"
                        color="grey"
                        v-bind:mask="'#####-###'"
                        maxlength="9"
                        :rules="[ val => !!val || 'Preencha o CEP' ]"
    
                    />   

                    <q-input 
                        filled        
                        label="Cidade *" 
                        v-model="issuer.city"
                        :rules="[ val => !!val || 'Preencha a sua cidade' ]"
                        class="mb-4 ml-2 mr-2"
                        color="grey"
                        maxlength="10"
    
                    />
                    
                    <q-input 
                        v-model="issuer.uf"
                        filled        
                        type="text"
                        label="UF *" 
                        class="mb-4 ml-2 mr-2"
                        color="grey"
                        maxlength="2"
                        aria-required="true"
                        :rules="[ val => !!val || 'Preencha a UF' ]"

                    />   
    
                    <q-input 
                        filled        
                        label="Endereço *" 
                        v-model="issuer.address"                        
                        class="mb-4 ml-2 mr-2"
                        color="grey"
                        maxlength="100"
                        :rules="[ val => !!val || 'Preencha o endereço' ]"
    
                    />        
                        
                    <q-input 
                        filled        
                        label="Número *" 
                        v-model="issuer.number"
                        :rules="[ val => !!val || 'Preencha o número' ]"
                        class="mb-4"
                        color="grey"
                        maxlength="10"
    
                    /> 

                </div>
            </div>
                
            <div class="bg-white p-5 rounded-lg mb-5">
                <h3 class="border-b mb-5">Dados fiscáis</h3>
                <q-select
                    :options="crtOptions"
                    v-model="issuer.crt"
                    label="CRT ( Cód. Regime tributário ) *"
                    class="mb-4"
                    color="grey" 
                    filled 
                    :rules="[ val => !!val || 'Preencha o seu CRT' ]"
                />

                <q-input 
                    filled        
                    label="Cód. CNAE *" 
                    v-model="issuer.cod_cnae"
                    :rules="[ val => !!val || 'Preencha o Cód. CNAE' ]"
                    class="mb-4"
                    color="grey"
                    maxlength="10"

                />  

                <q-input 
                    filled        
                    label="CNAE *" 
                    v-model="issuer.cnae"
                    :rules="[ val => !!val || 'Preencha o CNAE' ]"
                    class="mb-4"
                    color="grey"
                    maxlength="160"

                />  
                
                <q-input 
                    filled        
                    label="IE *" 
                    v-model="issuer.ie"
                    class="mb-4"
                    color="grey"
                    maxlength="14"
                    :rules="[ val => !!val || 'Preencha a IE']"

                />  

                <q-input 
                    filled        
                    label="IM" 
                    v-model="issuer.im"
                    class="mb-4"
                    color="grey"
                    maxlength="12"
                    v-if="issuer.cnpj"

                />  
            </div>
            
            <div>
                <q-btn 
                    label="Salvar" 
                    type="submit" 
                    class="ml-2 submit-btn"
                    :class="`bg-[${color}] text-white`"
                />
                
            </div>
        </q-form>
        
    </div>    
</template>

<script setup lang="ts">
    import { api } from 'src/boot/axios';
    import { LocalStorage, useQuasar } from 'quasar';
    import { onMounted, ref } from 'vue';
    import axios from 'axios';

    type Issuer = {
        company_name: string,
        trade_name: string,
        date_of_foundation: string,
        cnpj: string,
        cpf: string,
        cep: string,
        uf: string,
        cod_ibg: string,
        city: string,
        address: string,
        number: number,
        cod_crt: number,
        crt: string,
        cod_cnae: number,
        cnae: string,
        ie: string,
        im: string
    }

    const crtOptions = ref([
        'Simples Nacional',
        'Lucro real',
        'Lucro presumido',
        'Simples - excesso de receita',
        'MEI'

    ])

    const $q = useQuasar();
    
    const issuer = ref<Issuer | null>({
        company_name: '',
        trade_name: '',
        date_of_foundation: '',
        cnpj: '',
        cpf: '',
        cep: '',
        uf: '',
        cod_ibg: '',
        city: '',
        address: '',
        number: 0,
        cod_crt: 0,
        crt: '',
        cod_cnae: 0,
        cnae: '',
        ie: '',
        im: ''
    })

    const color: any = ref(null);

    const _completed: any = ref(null);

    const showLoading = () => {
        $q.loading.show({
            message: _completed ? 'Atualizando dados' : 'Salvando dados ( pode levar alguns minutos )'
        });
    }

    const hideLoading = () => {
        $q.loading.hide();
    }

    const getIssuer = async () => {
        const res = await api.get(`/issuer/companie/${LocalStorage.getItem("issuer_id")}`)
        issuer.value = res.data.issuer

    }

    const completeIssuer = async () => {
        showLoading();
        issuer.value.cod_crt = crtOptions.value.indexOf(issuer.value.crt) + 1;
        try {
            const res = await api.put(`issuer/complete-register/${LocalStorage.getItem("issuer_id")}`, issuer.value, {
                headers: {
                    Accept: "*/*"
                }
            });

            console.log('Res: ', res.data);
            
        } catch (error) {
            console.error('Error: ', error);
            
        } finally {
            hideLoading();
        };
        
    };
    
    const getCEPData = async () => {
        if(issuer.value.cep)
        {
            const formatedCEP = issuer.value.cep.replace(/\D/, '');
            if(formatedCEP.length === 8)
            {  
                const res = await axios.get(`${process.env.API_CEP}/${formatedCEP}/json`);
                console.log('Res cep:', res.data);

                issuer.value.cod_ibg = res.data.ibge;
                issuer.value.city = res.data.localidade;
                issuer.value.address = res.data.logradouro;
                issuer.value.uf = res.data.uf;
                                
            };
        };
    };

    onMounted(() => {
        getIssuer();
        color.value = '#E75A7C';
        _completed.value = LocalStorage.getItem("_completed");
    })
</script>