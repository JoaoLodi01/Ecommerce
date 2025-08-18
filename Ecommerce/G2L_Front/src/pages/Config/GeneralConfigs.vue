
<template>
    <div v-if="!showPage">
        <LoandingPage
            @show-page="showPage = $event"
            :text="'Carregando configurações gerais ...'"

        />

    </div>
    <div class="ml-16 text-2xl" v-if="showPage">
        <h1>Configurações gerais</h1>

        <div class="bg-white p-4 mb-4 rounded shadow-sm w-[99%]">
            <q-btn 
                :style="`background-color: ${showConfigs.showColorsConfig ? 'green' : buttonColor}; color: ${textColor}`" 
                label="Cores"
                @click="manageShowConfig('color')"
                class="mr-4"

            />

            <q-btn 
                :style="`background-color: ${showConfigs.showIssuanceConfig ? 'green' : buttonColor}; color: ${textColor}`" 
                label="Emissão"
                @click="manageShowConfig('issuance')"
                class="mr-4"

            />

            <q-btn 
                :style="`background-color: ${showConfigs.showStockConfig ? 'green' : buttonColor}; color: ${textColor}`" 
                label="Estoque"
                @click="manageShowConfig('stock')"
                class="mr-4"
                
            />
        </div>
        
        <div v-if="showConfigs.showColorsConfig" class="w-[99%] flex gap-4 p-4 bg-white">
            <div class="border border-black p-3 rounded-lg ">
                <h3>Cor dos botões</h3>
                
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
            
            <div class="border border-black p-3 rounded-lg bg-white">
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
                    <span class="flex">
                        Exemplo: 
                        
                        <div
                            :style="`background-color: ${colorOptions.painelColor}; color: ${colorOptions.painelColor === '#ffffff' ? '#000' : '#ffffff'}`"
                            class="rounded-md ml-2 w-36 h-8 mt-auto mb-auto"
                        >
                            
                        </div>
                    
                    </span>

                </div>
            </div>
            <div class="mt-4">
                <q-btn 
                    color="primary" 
                    icon="check" 
                    class="mr-4"
                    label="Salvar cor" 
                    @click="saveMyColor()" 
                />

                <q-btn 
                    color="primary"
                    label="Exportar cores"
                    @click="exportColors()" 
                />

            </div> 
        </div>       
    </div>

    <ImportFiles
        v-if="showImportFiles"
        :operation="'importColor'"
    />
</template>

<script setup lang="ts">
    import { useQuasar, LocalStorage } from 'quasar';
    import { api } from 'src/boot/axios';
    import { ref, onMounted } from 'vue';
    import ImportFiles from 'src/components/Files/ImportFiles.vue';
    import LoandingPage from 'src/components/Loanding/LoandingPage.vue';
    import camelcaseKeys from 'camelcase-keys';

    type TShowConfigs = {
        showColorsConfig: boolean,
        showIssuanceConfig: boolean,
        showStockConfig: boolean,

    }
    
    const $q = useQuasar();

    const colorOptions = ref<TColorOptions>({
        buttonColor: '',
        painelColor: '',
        textColor: ''

    });

    const issuerID = ref<number>(LocalStorage.getItem("issuer_id"));
    const buttonColor = ref<string>(LocalStorage.getItem("buttonColor"));
    const textColor = ref<string>(LocalStorage.getItem("textColor"));

    let showPage = ref<boolean>(false);
    let showImportFiles = ref<boolean>(false);

    let showConfigs = ref<TShowConfigs>({
        showColorsConfig: false,
        showIssuanceConfig: false,
        showStockConfig: false,

    });

    const manageShowConfig = (config: string): void => 
    {
        switch (config) {
            case 'color':
                showConfigs.value.showColorsConfig = !showConfigs.value.showColorsConfig;
                showConfigs.value.showIssuanceConfig = false;
                showConfigs.value.showStockConfig = false;
                break;
        
            case 'issuance':
                showConfigs.value.showIssuanceConfig = !showConfigs.value.showIssuanceConfig;
                showConfigs.value.showColorsConfig = false;
                showConfigs.value.showStockConfig = false;
                break;

            case 'stock':
                showConfigs.value.showStockConfig = !showConfigs.value.showStockConfig;
                showConfigs.value.showIssuanceConfig = false;
                showConfigs.value.showColorsConfig = false;

                break;
            
            default:
                showConfigs.value = {
                    showColorsConfig: false,
                    showIssuanceConfig: false,
                    showStockConfig: false,
                };
                break;
        }
    }

    const getConfigs = async () => 
    {
        const res = await api.get(`/configs/all-configs/${issuerID.value}`);
        const data: TColorOptions = camelcaseKeys(res.data.data.color, { deep: true });
        console.log(data)
        
        if(res.data.success)
        {
            colorOptions.value.buttonColor = data.buttonColor;
            colorOptions.value.painelColor = data.painelColor;
            colorOptions.value.textColor = data.textColor;
            
        };
    };

    const saveMyColor = async () =>
    {
        const res = await api.put(`/configs/color/update-config/${issuerID.value}`, {
            button_color: colorOptions.value.buttonColor,
            painel_color: colorOptions.value.painelColor

        });
        
        $q.notify({
            color: 'green',
            message: 'Salvando configurações!',
            timeout: 2000,
            position: 'top'

        });

        try {
            if(res.data.success)
            {
                LocalStorage.set("buttonColor", colorOptions.value.buttonColor);
                LocalStorage.set("painelColor", colorOptions.value.painelColor);
                
                $q.notify({
                    color: 'green',
                    message: 'Cores alterados com sucesso!',
                    timeout: 2000,
                    position: 'top'

                });
            };
        } catch (error) {
            $q.notify({
                color: 'red',
                message: error.response,
                timeout: 2000,
                position: 'top'

            });
        };
    };

    const exportColors = async () =>
    {
        const res = await api.get(`/configs/color/export/${issuerID.value}`, {
            responseType: 'blob'
        });
        
        const url = window.URL.createObjectURL(new Blob([res.data], { type: 'application/json' }));

        const link = document.createElement('a');

        link.href = url;
        link.setAttribute('download', `Cores.json`);
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);

    };

    onMounted(() => {
        getConfigs();
        
    });
</script>
