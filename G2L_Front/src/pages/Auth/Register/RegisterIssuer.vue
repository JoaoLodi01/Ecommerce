<template>
    <div class="p-10">
        <q-btn flat icon="arrow_back" label="Voltar" to="/companies" class="mb-6" />

    </div>

    <div class="flex justify-center">
        <div class="login-form border border-black p-5 rounded-lg shadow-xl w-96">
            <q-form
                @submit.prevent="createIssuer()"
                
            >
                <h1 class="text-xl ml-auto mr-auto border-b border-black w-max mb-4">Registrar Emitente</h1>
                <q-input 
                    v-model="form.company_name"
                    @update:model-value="handleInput"
                    type="text" 
                    outlined
                    label="Razão Social" 
                    stack-label
                    class="mb-4"
                    color="primary"
                    :rules="[
                        val => !!val || 'Campo obrigatório'
                    ]"
                    
                />

                <q-input 
                    v-model="form.trade_name"
                    type="text" 
                    outlined        
                    label="Nome Fantasia" 
                    stack-label
                    class="mb-4"
                    color="primary"
                    
                />

                <q-input 
                    v-model="form.cnpj"
                    outlined        
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
                    outlined        
                    label="CPF" 
                    stack-label
                    class="mb-4"
                    color="primary"
                    v-bind:mask="'###.###.###-##'"
                    maxlength="14"
                    @update:model-value="checkCPF"
                    :rules="[
                        val => !val || validateCPF(val) || 'CPF inválido'
                    ]"

                />

                <q-input 
                    v-model="form.date_of_foundation"
                    outlined        
                    type="date"
                    label="Data de fundação" 
                    stack-label
                    class="mb-4"
                    color="primary"
                    :rules="[
                        val => !!val || 'Campo obrigatório'
                    ]"

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

    <LoandingPage
        v-if="showLoanding"
        :text="'Cadastrando empresa ...'"
    />
</template>

<script setup lang="ts">
    import { LocalStorage, useQuasar } from 'quasar';
    import { api } from 'src/boot/axios';
    import { ref } from 'vue';
    import { useRouter } from 'vue-router';
    import LoandingPage from 'src/components/Loanding/LoandingPage.vue';
    import axios from 'axios';
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

    let showLoanding = ref<boolean>(false);

    const checkCPF = async () =>
    {
        const cpf = form.value.cpf.replace(/\D/g, '')

        if(cpf.length == 11) 
        {
            const res = await api.get(`/registers/issuer/last-cpf/${cpf}`);
            const exists = res.data

            if(!exists.data)
            {
                return;

            } else {
                $q.notify({
                    color: 'red',
                    message: 'CPF já cadastrado!',
                    position: 'top',
                    timeout: 1800
                });

                form.value.company_name = '';
                form.value.trade_name = '';
                form.value.cpf = '';

            };

        };
    };
    
    const getDataCNPJ = async () =>
    {
        const cnpj = form.value.cnpj.replace(/\D/g, '')

        if(
            cnpj.length == 14 && 
            form.value.company_name == '' && 
            form.value.trade_name == ''
        )
        {
            const res = await api.get(`/registers/issuer/last-cnpj/${cnpj}`);
            const exists = res.data

            console.log(exists.data);

            if(!exists.data)
            {
                const data = await axios.get(`${process.env.API_CNPJ}/${cnpj}`)
                
                form.value.company_name = data.data.alias
                form.value.trade_name = data.data.alias
                form.value.date_of_foundation = data.data.founded
                form.value.cod_cnae = data.data.mainActivity.id
                form.value.main_activity = data.data.mainActivity.text
                
            } else {
                $q.notify({
                    color: 'red',
                    message: 'CNPJ já cadastrado!',
                    position: 'top',
                    timeout: 1800
                });
                
                form.value.company_name = '';
                form.value.trade_name = '';
                form.value.cnpj = '';
            };
        };
    };

    const createIssuer = async () =>
    {
        showLoanding.value = true;
        try {
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

                showLoanding.value = false;
                router.push({ path: '/companies' });
                
            } else {
                $q.notify({
                    color: 'red',
                    message: res.data.message,
                    timeout: 1200,
                    position: 'top'
                
                });
            };

        } catch (error) {
            console.error('Caiu no catch: ', error);
            showLoanding.value = false;
            
        } finally {
            showLoanding.value = false;
        }
    };

    const handleInput = (val: string) =>
    {
        form.value.company_name = val.toUpperCase();
        form.value.trade_name = form.value.company_name;

    }

</script>