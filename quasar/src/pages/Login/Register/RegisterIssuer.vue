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
                    @update:model-value="form.trade_name = form.company_name"   
                    type="text" 
                    filled        
                    label="Razão Social" 
                    stack-label
                    class="mb-4"
                    color="primary"
                    
                />

                <q-input 
                    v-model="form.trade_name"
                    type="text" 
                    filled        
                    label="Nome Fantasia" 
                    stack-label
                    class="mb-4"
                    color="primary"
                    
                />

                <q-input 
                    v-model="form.cnpj"
                    filled        
                    label="CNPJ" 
                    stack-label
                    class="mb-4"
                    color="primary"
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
                    color="primary"
                    v-bind:mask="'###.###.###-##'"
                    maxlength="14"
                    :rules="[
                        val => !val || validateCPF(val) || 'CPF inválido'
                    ]"

                />

                <q-input 
                    v-model="form.date_of_foundation"
                    filled        
                    type="date"
                    label="Data de fundação" 
                    stack-label
                    class="mb-4"
                    color="primary"

                /> 
                
                <div class="flex justify-center">
                    <q-btn 
                        type="submit"
                        label="Criar Empresa"
                        class="m-2"
                        color="primary"   
                    />
                </div>
            
                
            </q-form>
            
        </div>
    </div>
</template>

<script setup lang="ts">
    import { LocalStorage, useQuasar } from 'quasar';
    import { api } from 'src/boot/axios';
    import axios from 'axios';
    import { ref } from 'vue';
    import { useRouter } from 'vue-router';
    import validateCPF from 'src/utils/validateCPF';

    interface IIsuerData
    {
        company_name: string,
        trade_name: string,
        cnpj: string,
        cpf: string,
        date_of_foundation: string,
        cod_crt: string,
        cod_cnae: string,
        main_activity: string
    };

    const $q = useQuasar();
    const router = useRouter();
    
    const form = ref<IIsuerData>({
        company_name: '',
        trade_name: '',
        cnpj: '',
        cpf: '',
        date_of_foundation: '',
        cod_crt: '',
        cod_cnae: '',
        main_activity: ''

    });
    
    const getDataCNPJ = async () =>
    {
        const cnpj = form.value.cnpj.replace(/\D/g, '')
        if(
            cnpj.length == 14 && 
            form.value.company_name == '' && 
            form.value.trade_name == ''
        )
        {
            const data = await axios.get(`${process.env.API_CNPJ}/${cnpj}`)
            
            form.value.company_name = data.data.alias
            form.value.trade_name = data.data.alias
            form.value.date_of_foundation = data.data.founded
            form.value.cod_cnae = data.data.mainActivity.id
            form.value.main_activity = data.data.mainActivity.text
            
        };
        
    };

    const createIssuer = async () =>
    {
        const res = await api.post('/registers/issuer/create', {
            company_name: form.value.company_name,
            trade_name: form.value.trade_name,
            cpf: form.value.cpf.replace(/\D/g, ''),
            cnpj: form.value.cnpj.replace(/\D/g, ''),
            date_of_foundation: form.value.date_of_foundation,
            cod_crt: form.value.cod_crt,
            cod_cnae: form.value.cod_cnae,
            main_activity: form.value.main_activity,              
            uuse_id: LocalStorage.getItem("uuse_id"),
            
        });
        
        if(res.data.success)
        {
            $q.notify({
                color: 'green',
                message: res.data.message,
                timeout: 1200,
                position: 'top'
            
            });

            router.push({ path: '/companies' });
            
        } else {
            $q.notify({
                color: 'red',
                message: res.data.message,
                timeout: 1200,
                position: 'top'
            
            });
        };
    };

</script>