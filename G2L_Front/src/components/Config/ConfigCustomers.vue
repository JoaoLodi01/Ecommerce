<template>
    <div
        class="fixed inset-0 z-50 flex items-center justify-center bg-opacity-40 backdrop-blur-sm"
    >
        <div class="bg-white p-8 rounded-md">
            <div class="">
                <h1>Configurações </h1>
                <div class="mb-2">
                    <q-checkbox 
                        v-model="options.validateAddres" 
                        label="Permitir endereço nulo"

                    />

                    <q-checkbox 
                        v-model="options.validateCNPJ" 
                        label="Permitir CNPJ nulo" 

                    />
                    
                    <q-checkbox 
                        v-model="options.validateCPF" 
                        label="Permitir CPF nulo" 

                    />

                    <q-option-group
                        v-model="lastFilter"
                        type="radio"
                        toggle
                        class="flex"
                        :options="[
                            {label: 'Todos', value: 'all'},
                            {label: 'Ativos', value: 'active'},
                            {label: 'Inativos', value: 'disabled'},
                        ]"

                    />
                </div>
            </div>

            <div class="">
                <q-btn 
                    :style="`background-color: ${buttonColor}; color: ${textColor}`"
                    label="OK"
                    @click="saveConfig()"
                />

                <q-btn 
                    :style="`background-color: ${buttonColor}; color: ${textColor}`"
                    label="Voltar"
                    @click="emits('close', true)" 
                    class="ml-5"
                />
            </div>  
        </div>
    </div>
</template>

<script setup lang="ts">
    import { api } from 'src/boot/axios';
    import { ref, defineEmits, onMounted } from 'vue'  
    import { LocalStorage, useQuasar } from 'quasar';
    import camelcaseKeys from 'camelcase-keys';
    
    type TOptions = {
        validateCNPJ: boolean,
        validateCPF: boolean,
        validateAddres: boolean
    };
    
    const emits = defineEmits<{
        (e: 'close', value: boolean);
    }>();
    
    const $q = useQuasar();
    const issuerID = ref<number>(LocalStorage.getItem("issuer_id"));

    const options = ref<TOptions>({
        validateAddres: false,
        validateCNPJ: false,
        validateCPF: false

    });

    const lastFilter = ref<'all' | 'active' | 'disabled' >('all');

    const buttonColor = ref<string>(LocalStorage.getItem("buttonColor"));
    const textColor = ref<string>(LocalStorage.getItem("textColor") ?? '#ffffff');

    const returnValue = (value: boolean | number ) => { return value === 1 ? true : false };

    const closeNotify = (text: string, success: boolean) =>
    {
        $q.notify({
            position: 'top',
            message: text,
            color: success ? 'green' : 'red',
            timeout: 2000
        });

        if(success) return emits('close', true);
        return emits('close', false);
    };
    
    const saveConfig = async () =>
    {
        console.log(options.value);

        const res = await api.put(`/configs/customer/update-config/${issuerID.value}`, {
            validateCNPJ: options.value.validateCNPJ,
            validateCPF: options.value.validateCPF,
            validateAddres: options.value.validateAddres,
            lastFilter: lastFilter.value

        });

        closeNotify(res.data.message, res.data.success);
    };

    const getConfigs = async () =>
    {
        const res = await api.get(`/configs/all-configs/${issuerID.value}`);
        const data = camelcaseKeys(res.data.data.customers, { deep: true });
        

        options.value = {
            validateAddres: returnValue(data.validateAddres),
            validateCNPJ: returnValue(data.validateCnpj),
            validateCPF: returnValue(data.validateCpf),
            
        };

        lastFilter.value = data.lastFilter;

        console.log(options.value)
    };

    onMounted(() => {
        getConfigs();

    });

</script>