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
                :rules="[
                    val => !!val || 'O nome da espécie é necessário!'
                ]"

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
                :rules="[
                    val => !!val || 'O tipo da espécie é necessário!'
                ]"

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
    import { useQuasar, LocalStorage, event } from 'quasar';
    import { api } from 'src/boot/axios';
    import { ref, onMounted, reactive } from 'vue';
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

    const emits = defineEmits<{
        (e: 'close', value: true)

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

    const $q = useQuasar();

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
        tipoLancamento: 'Caixa',
        paymentsFormType: '',
        pixKey: null,
        bankKey: null,
        otherKey: null,
                
    });

    const issuerID = LocalStorage.getItem("issuer_id");

    const buttonColor = ref<string>(LocalStorage.getItem("buttonColor"));
    const textColor = ref<string>(LocalStorage.getItem("textColor"));

    const notifyMessage = reactive({
        'create': 'Espécie cadastrada com sucesso!',
        'update': 'Espécie alterada com sucesso!'

    });

    const onSubmit = async () => {
        console.log(formData.value);
        const apiURL = props.operation === 'create' ? `species/create` : `species/${props.speciesCode}`;
        const res = props.operation === 'create' ? await api.post(apiURL, formData.value) : await api.put(apiURL, formData.value);

        const data = res.data

        if(data.success)
        {
            $q.notify({
                color: 'green',
                message: notifyMessage[props.operation],
                position: 'top',
                timeout: 2000,

            });
            emits('close', true);

        };
    };

    const getData = async () => 
    {
        const res = await api.get(`/species/find/${issuerID}/${props.speciesCode}`);
        const data: ISpecies = camelcaseKeys(res.data.data, { deep: true });

        formData.value = {
            paymentCode: data.paymentCode,
            issuerID: data.issuerID,
            especie: data.especie,
            paymentsFormType: data.paymentsFormType,
            tipoLancamento: data.tipoLancamento,
            bankKey: data.bankKey,
            otherKey: data.otherKey,
            pixKey: data.pixKey,
        };
    };

    onMounted(() => {
        props.operation === 'update' ? getData() : null;

        document.addEventListener('keydown', (event: KeyboardEvent) => { if(event.key === 'Escape') emits('close', true); });
    });
</script>