<template>
    <div>
        <h1>Cadastro de espécie</h1>
        <q-form
            @submit="onSubmit"
            class="q-gutter-md"
        >
            <q-input 
                v-model="formData.especie" 
                type="text" 
                label="Descrição" 
                color="grey-7"

            />

            <q-radio 
                v-model="formData.tipoLancamento"
                val="Caixa" 
                label="À vista" 
                color="grey-7"

            />
            
            <q-radio 
                v-model="formData.tipoLancamento"
                val="Receber" 
                label="À prazo" 
                color="grey-7"

            />

            <q-select 
                v-model="formData.paymentsFormType" 
                :options="paymentsFormType" 
                label="Tipo da espécie" 
                color="grey-7"
                filled 
            />

            <div v-if="formData.paymentsFormType === 'PIX'">
                <h4>Chave PIX</h4>
                <q-select 
                    v-model="keyPIXType_" 
                    :options="keyPIXType" 
                    label="Tipo de chave PIX" 
                    color="grey-7"
                    @update:model-value="formData.pixKey = ''"
                    filled 
                />

                <div v-if="keyPIXType_ === 'CPF'">
                    <q-input 
                        v-model="formData.pixKey" 
                        type="text" 
                        mask="###.###.###-##"
                        color="grey-7"
                        label="Chave PIX ( CPF )" 
                        :rules="[
                            val => !val || validateCPF(val) || 'CPF inválido'
                        ]"
                        
                    />

                </div>

                <div v-if="keyPIXType_ === 'E-mail'">
                    <q-input 
                        v-model="formData.pixKey" 
                        type="email"
                        color="grey-7"
                        label="Chave PIX ( E-mail )" 
                    />

                </div>

                <div v-if="keyPIXType_ === 'Telefone' " class="">
                    <q-input 
                        v-model="formData.pixKey" 
                        type="tel"
                        mask="(##) #####-####"
                        color="grey-7"
                        label="Chave PIX ( Telefone )" 
                    />

                </div>

            </div>
            
            <div>
                <q-btn 
                    label="Registrar espécie"
                    type="submit" 
                    :style="`background-color: ${buttonColor}; color: ${textColor}`"

                />
            </div>
        </q-form>
    </div>

</template>

<script setup lang="ts">
    import { LocalStorage } from 'quasar';
    import { api } from 'src/boot/axios';
    import { ref, onMounted } from 'vue';
    import validateCPF from 'src/utils/validateCPF';
    import camelcaseKeys from 'camelcase-keys'; 

    interface ISpecies {
        paymentCode?: number,
        issuerID: number,
        especie: string,
        tipoLancamento: string,
        paymentsFormType: string,
        pixKey: string,
        bankKey: string,
        otherKey: string
    };

    const props = defineProps<{
        operation: string,
        speciesCode?: number

    }>();

    const paymentsFormType = ref([
        'DINHEIRO',
        'PIX',
        'CARTAO DE CREDITO',
        'CARTAO DE DEBITO',
        'VALE ALIMENTACAO',
        'TRANSICAO BANCARIA',
        'OUTROS',

    ]);

    const keyPIXType_ = ref(null);
    const keyPIXType = ref([
        'CPF',
        'E-mail',
        'Telefone'
    ]);

    const formData = ref<ISpecies>({
        paymentCode: 0,
        issuerID: LocalStorage.getItem("issuer_id"),
        especie: '',
        tipoLancamento: '',
        paymentsFormType: '',
        pixKey: '',
        bankKey: '',
        otherKey: '',
                
    });

    const issuerID = LocalStorage.getItem("issuer_id");

    const buttonColor = ref<string>(LocalStorage.getItem("buttonColor"));
    const textColor = ref<string>(LocalStorage.getItem("textColor"));

    const onSubmit = async () => {
        const apiURL = props.operation === 'crate' ? `species/create` : `species/${props.speciesCode}`;

        const res = props.operation === 'crate' ? await api.post(apiURL, formData.value) : await api.put(apiURL, formData.value);
        console.log(res);

    };

    const getData = async () => 
    {
        const res = await api.get(`/species/find/${issuerID}/${props.speciesCode}`);
        const data: ISpecies = camelcaseKeys(res.data.data, { deep: true });

        formData.value = {
            paymentCode: data.paymentCode,
            issuerID: data.issuerID,
            bankKey: data.bankKey,
            especie: data.especie,
            otherKey: data.otherKey,
            paymentsFormType: data.paymentsFormType,
            pixKey: data.pixKey,
            tipoLancamento: data.tipoLancamento,
        };
    };

    onMounted(() => {
        props.operation === 'update' ? getData() : null;
    });
</script>