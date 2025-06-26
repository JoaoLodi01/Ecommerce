<template>
    <div
        class="fixed inset-0 z-50 flex items-center justify-center bg-opacity-40 backdrop-blur-sm"
    >
        <div class="bg-white p-10">
            <div class="">
                <h1>Configurações</h1>
                <div class="">
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
                    color="primary" 
                    label="OK"
                    @click="saveConfig()"
                />

                <q-btn 
                    color="primary" 
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
    
    const emits = defineEmits<{
        (e: 'close', value: boolean);
    }>();
    
    type TOptions = {
        validateCNPJ: boolean,
        validateCPF: boolean,
        validateAddres: boolean
    };
    
    const $q = useQuasar();
    const issuerId = ref<number>(LocalStorage.getItem("issuer_id"));

    const options = ref<TOptions>({
        validateAddres: false,
        validateCNPJ: false,
        validateCPF: false

    });

    const lastFilter = ref<'all' | 'active' | 'disabled' >('all');

    const returnValue = (value: boolean | number ) => { return value === 1 ? true : false };
    
    const saveConfig = async () =>
    {
        const res = await api.put(`/config/customer/update-config/${issuerId.value}`, {
            validateCNPJ: options.value.validateCNPJ,
            validateCPF: options.value.validateCPF,
            validateAddres: options.value.validateAddres,
            lastFilter: lastFilter.value

        });

        console.log(res)
    };

    const getConfigs = async () =>
    {
        const res = await api.get(`/config/all-configs/${issuerId.value}`);
        const data = camelcaseKeys(res.data.data.customers[0], { deep: true });
        console.log('Data: ', data);
        options.value = {
            validateAddres: returnValue(data.validateCNPJ),
            validateCNPJ: returnValue(data.validateCNPJ),
            validateCPF: returnValue(data.validateCPF),
            
        };

        lastFilter.value = data.lastFilter;
    };

    onMounted(() => {
        getConfigs();

    });

</script>