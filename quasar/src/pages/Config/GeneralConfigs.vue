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
                    v-model="buttonColors" 
                    :default-value="buttonColors"
                    class="my-picker" 
                    style="max-width: 250px;"
                />

                <div class="mt-4">
                    <span>Cor usada: {{ buttonColors }}</span>
                    <br>
                    <span>
                        Exemplo: 
                        <q-btn 
                            :style="`background-color: ${buttonColors}; color: ${buttonColors === '#ffffff' ? '#000' : '#ffffff'}`"
                            label="Finalizar venda" 
                            
                        /> 
                    
                    </span>

                </div>
            </div>
            
            <div class="mt-5 border border-black p-3 rounded-lg bg-white">
                <h3>Cor dos painéis</h3>
                <q-color    
                    v-model="painelColor" 
                    :default-value="painelColor"
                    class="my-picker" 
                    style="max-width: 250px;"
                />

                <div class="mt-4">
                    <span>Cor usada: {{ painelColor }}</span>
                    <br>
                    <span>
                        Exemplo: 
                        <q-btn 
                            color="primary" 
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

    const $q = useQuasar();
    let showPage = ref<boolean>(false);
    let buttonColors = ref<string>('');
    let painelColor = ref<string>('');
    const issuerID = ref<number>(LocalStorage.getItem("issuer_id"));

    const getConfigs = async () => 
    {
        const res = await api.get(`/configs/all-configs/${issuerID.value}`);
        console.log(res.data);
        
    };

    const saveMyColor = async () =>
    {
        const res = await api.put(`/configs/color/update-config/${issuerID.value}`, {
            color: buttonColors.value
        });
    };

    onMounted(() => {
        getConfigs();
        
    });

</script>