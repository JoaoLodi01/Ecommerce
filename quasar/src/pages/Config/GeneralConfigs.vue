
<template>
    <div v-if="!showPage">
        <LoandingPage
            @show-page="showPage = $event"
            :text="'Carregando configurações gerais ...'"

        />

    </div>
    <div class="ml-16 text-2xl" v-if="showPage">
        <h1>Configurações gerais</h1>
        
        <div class="">
            <div class="border border-black p-3 rounded-lg bg-white">
                <h3>
                    Cor dos botões
                    
                </h3>
                <q-color    
                    v-model="colorOptions.buttonColor" 
                    :default-value="colorOptions.buttonColor"
                    class="my-picker" 
                    style="max-width: 250px;"
                />

                <div class="mt-4">
                    <span>Cor usada: {{ colorOptions.buttonColor }}</span>
                    <br>
                    <span>
                        Exemplo: 
                        <q-btn 
                            :style="`background-color: ${colorOptions.buttonColor}; color: ${colorOptions.buttonColor === '#ffffff' ? '#000' : '#ffffff'}`"
                            label="Finalizar venda" 
                            
                        /> 
                    
                    </span>

                </div>
            </div>
            
            <div class="mt-5 border border-black p-3 rounded-lg bg-white">
                <h3>Cor dos painéis</h3>
                <q-color    
                    v-model="colorOptions.painelColor" 
                    :default-value="colorOptions.painelColor"
                    class="my-picker" 
                    style="max-width: 250px;"
                />

                <div class="mt-4">
                    <span>Cor usada: {{ colorOptions.painelColor }}</span>
                    <br>
                    <span>
                        Exemplo: 
                        <q-btn 
                            :style="`background-color: ${colorOptions.painelColor}; color: ${colorOptions.painelColor === '#ffffff' ? '#000' : '#ffffff'}`"
                            label="Finalizar venda" 
                            
                        /> 
                    
                    </span>

                </div>
            </div>

            <div class="mt-4">
                <q-btn 
                    color="primary" 
                    icon="check" 
                    label="Salvar cor" 
                    @click="saveMyColor()" 
                />

            </div>

        </div>        
    </div>
</template>

<script setup lang="ts">
    import { useQuasar, LocalStorage } from 'quasar';
    import { api } from 'src/boot/axios';
    import LoandingPage from 'src/components/Loanding/LoandingPage.vue';
    import { ref, onMounted } from 'vue';
    import camelcaseKeys from 'camelcase-keys';
    
    const $q = useQuasar();
    let showPage = ref<boolean>(false);

    const colorOptions = ref<TColorOptions>({
        buttonColor: '',
        painelColor: ''

    });

    const issuerID = ref<number>(LocalStorage.getItem("issuer_id"));

    const getConfigs = async () => 
    {
        const res = await api.get(`/configs/all-configs/${issuerID.value}`);
        const data: TColorOptions = camelcaseKeys(res.data.data.color, { deep: true });
        console.log(data)
        
        if(res.data.success)
        {
            colorOptions.value.buttonColor = data.buttonColor;
            colorOptions.value.painelColor = data.painelColor;
            
        };
    };

    const saveMyColor = async () =>
    {
        const res = await api.put(`/configs/color/update-config/${issuerID.value}`, {
            button_color: colorOptions.value.buttonColor,
            painel_color: colorOptions.value.painelColor

        });

        
        if(res.data.success)
        {
            LocalStorage.set("buttonColor", colorOptions.value.buttonColor);
            LocalStorage.set("painelColor", colorOptions.value.painelColor);

            $q.notify({
                color: 'green',
                message: 'Cores alterados com sucesso!',
                timeout: 2000,
                position: 'top'
            })
        }
    };

    onMounted(() => {
        getConfigs();
        
    });
</script>
