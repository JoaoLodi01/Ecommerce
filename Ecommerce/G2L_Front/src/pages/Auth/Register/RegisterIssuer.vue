<template>
    <div class="p-10">
        <q-btn flat icon="arrow_back" label="Voltar" to="/companies" class="mb-6" />

    </div>

    <div class="flex justify-center">
        <div class="login-form border border-black p-5 rounded-lg shadow-xl w-96 bg-white">
            <q-form
                @submit.prevent="createIssuer()"
                
            >
                <h1 class="text-xl ml-auto mr-auto border-b border-black w-max mb-4">Registrar Emitente</h1>
                <q-input 
                    v-model="form.companyName"
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
                    v-model="form.tradeName"
                    type="text" 
                    outlined        
                    label="Nome Fantasia" 
                    stack-label
                    class="mb-6"
                    color="primary"
                    
                />

                <q-input 
                    v-model="form.cnpj"
                    outlined        
                    label="CNPJ" 
                    stack-label
                    class="mb-6"
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
                    class="mb-2"
                    color="primary"
                    v-bind:mask="'###.###.###-##'"
                    maxlength="14"
                    @update:model-value="handleCPF"
                    :rules="[cpfInput]"

                />

                <q-input 
                    v-model="form.dateOfFoundation"
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
    import checks from 'src/services/Exists/checkExists' 

    interface IIsuerData
    {
        companyName: string,
        tradeName: string,
        dateOfFoundation: string,
        cnpj: string,
        cpf: string,
        cep: string,
        uf: string,
        codIbge: number,
        city: string,
        address: string,
        number: number,
        codCrt: number,
        crt: string,
        codCnae: number,
        cnae: string,
        ie: string,
        im: string,
        mainActivity: string,
        uuse_id: number
        
    };

    const $q = useQuasar();
    const router = useRouter();
    
    const form = ref<IIsuerData>({
        companyName: '',
        tradeName: '',
        dateOfFoundation: '',
        cnpj: '',
        cpf: '',
        cep: '',
        uf: '',
        codIbge: 0,
        city: '',
        address: '',
        number: 0,
        codCrt: 0,
        crt: '',
        codCnae: 0,
        cnae: '',
        ie: '',
        im: '',
        mainActivity: '',
        uuse_id: 0,

    });

    let showLoanding = ref<boolean>(false);

    function formateCPF(cpf: string): string
    {
        return cpf.replace(/\D/g, '');    
    };
    
    const getDataCNPJ = async () =>
    {
        const cnpj = form.value.cnpj.replace(/\D/g, '')

        if(
            cnpj.length == 14 && 
            form.value.companyName == '' && 
            form.value.tradeName == ''
        )
        {
            const res = await api.get(`/registers/issuer/last-cnpj/${cnpj}`);
            const exists = res.data
''
            if(!exists.data)
            {
                const data = await axios.get(`${process.env.API_CNPJ}/${cnpj}`)
                console.log(data);
                // zip = cep
                // municipality = cod IBGE
                // street = bairro
                if (
                    data.data.zip !== "" &&
                    data.data.state !== "" && 
                    data.data.municipality !== "" &&
                    data.data.city !== "" &&
                    data.data.address !== "" && 
                    data.data.street !== "" &&
                    data.data.number !== "" &&
                    data.data.district !== "" &&
                    data.data.mainActivity.id !== "" &&
                    data.data.mainActivity.text !== ""
                ) {
                    console.log('Tem essa caralhada de coisa');
                    
                    form.value = {
                        companyName: data.data.alias,
                        tradeName: data.data.alias,
                        dateOfFoundation: data.data.founded,
                        cnpj: form.value.cnpj,
                        cpf: form.value.cpf,
                        cep: data.data.address.zip,
                        uf: data.data.address.state,
                        codIbge: data.data.address.municipality,
                        city: data.data.address.city,
                        address: data.data.address.street,
                        number: data.data.address.number,
                        cnae: data.data.mainActivity.text,
                        codCrt: 0,
                        codCnae: data.data.mainActivity.id,
                        mainActivity: data.data.mainActivity.text,    
                        crt: '',
                        ie: '',
                        im: '',
                        uuse_id: LocalStorage.getItem("uuse_id")

                    };
                    LocalStorage.set("_completed", true)
                };
                
            } else {
                $q.notify({
                    color: 'red',
                    message: 'CNPJ já cadastrado!',
                    position: 'top',
                    timeout: 1800
                });
                
                form.value.companyName = '';
                form.value.tradeName = '';
                form.value.cnpj = '';
                form.value.dateOfFoundation = '';

            };
        };
    };

    const createIssuer = async () =>
    {
        showLoanding.value = true;
        try {
            console.log('Dados de envio:', form.value);
            const res = await api.post('/registers/issuer/create', form.value);

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
        form.value.companyName = val.toUpperCase();
        form.value.tradeName = form.value.companyName;

    };

    const handleCPF = async (cpf: string) =>
    {
        const existis = await checks.checkIssuerExistsCPF(cpf);
        const formatedCPF = formateCPF(cpf);

        if(formatedCPF.length === 11) 
        {
            if(!existis)
            {
                $q.notify({
                    color: 'red',
                    message: 'CPF já cadastrado!',
                    position: 'top',
                    timeout: 1800
                });
                form.value.cpf = '';
                
            };
        };
    };

    const cpfInput = (val: string) =>
    {
        const cnpjFilled = !!form.value.cnpj;
        const cpfFilled = !!val;

        if(cnpjFilled)
        {
            return true;  
        };
        
        if(!cpfFilled)
        {
            return 'Informe o CPF ou o CNPJ!';
        };

        if(!validateCPF(val))
        {
            return 'CPF inválido';
        };
        return true;  
    };

</script>