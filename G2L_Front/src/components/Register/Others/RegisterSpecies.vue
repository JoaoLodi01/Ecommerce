<template>
    <div>
        <h1>Cadastro de espécie</h1>
        <q-form
            @submit="onSubmit"
            @reset="onReset"
            class="q-gutter-md"
        >
            <q-input 
                v-model="formData.especie" 
                type="text" 
                label="Descrição" 
                color="grey-7"

            />

            <q-radio 
                v-model="formData.tipo_lancamento"
                val="Caixa" 
                label="À vista" 
                color="grey-7"

            />
            
            <q-radio 
                v-model="formData.tipo_lancamento"
                val="Receber" 
                label="À prazo" 
                color="grey-7"

            />

            <q-select 
                v-model="formData.payments_form_type" 
                :options="paymentsFormType" 
                label="Tipo da espécie" 
                color="grey-7"
                filled 
            />

            <div v-if="formData.payments_form_type === 'PIX'">
                <h4>Chave PIX</h4>
                <q-select 
                    v-model="keyPIXType_" 
                    :options="keyPIXType" 
                    label="Tipo de chave PIX" 
                    color="grey-7"
                    @update:model-value="formData.pix_key = ''"
                    filled 
                />

                <div v-if="keyPIXType_ === 'CPF'" class="">
                    <q-input 
                        v-model="formData.pix_key" 
                        type="text" 
                        mask="###.###.###-##"
                        color="grey-7"
                        label="Chave PIX ( CPF )" 
                        :rules="[
                            val => !val || validateCPF(val) || 'CPF inválido'
                        ]"
                        
                    />

                </div>

                <div v-if="keyPIXType_ === 'E-mail' " class="">
                    <q-input 
                        v-model="formData.pix_key" 
                        type="email"
                        color="grey-7"
                        label="Chave PIX ( E-mail )" 
                    />

                </div>

                <div v-if="keyPIXType_ === 'Telefone' " class="">
                    <q-input 
                        v-model="formData.pix_key" 
                        type="tel"
                        mask="(##) #####-####"
                        color="grey-7"
                        label="Chave PIX ( Telefone )" 
                    />

                </div>

            </div>
            
            <div>
                <q-btn label="Submit" type="submit" color="grey-7" />
                <q-btn label="Reset" type="reset" color="grey-7" flat class="q-ml-sm" />
            </div>
        </q-form>
    </div>

</template>

<script setup lang="ts">
    import { LocalStorage } from 'quasar';
    import { api } from 'src/boot/axios';
    import { ref } from 'vue';
    import validateCPF from 'src/utils/validateCPF';

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
    ])

    const formData = ref({
        issuer_id: LocalStorage.getItem("issuer_id"),
        especie: '',
        tipo_lancamento: '',
        payments_form_type: '',
        pix_key: '',
        bank_key: '',
        other_key: '',
        
    })

    const onSubmit = async () => {
        console.log('form data: ', formData.value)
        const res = await api.post('species/create', formData.value)
        console.log('Res: ', res)
    }

    const onReset = () => {

    }

</script>