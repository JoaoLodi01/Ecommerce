<template>
    <q-dialog v-model="show" persistent>
        <q-card>
            <q-card-section class="items-center h-44 w-96 q-ml-sm">
                <div class="mb-4">
                    <h1 class="text-xl border-b w-max">Envio de relatórios</h1>

                </div>
                <div class="ml-auto">
                    <q-checkbox 
                        left-label 
                        v-model="isNFCe" 
                        label="Envio de NFC-e" 
                    />

                    <q-checkbox 
                        left-label 
                        v-model="isNM" 
                        label="Envio de Notas Manuais" 
                    />

                    <q-checkbox 
                        left-label 
                        v-model="forMoreMails" 
                        label="Envio para e-mails adicionais" 
                    />

                    <q-input 
                        v-model="period" 
                        type="number" 
                        label="Período de envio"
                        class="w-max"
                    />
                </div>
            </q-card-section>
                
            <q-card-actions align="right">
                <q-btn flat label="Enviar" color="primary" />
            </q-card-actions>
        </q-card>
    </q-dialog>
</template>

<script setup lang="ts">
    import { apiEmail } from 'src/boot/axios';
    import { ref } from 'vue';

    let show = ref<boolean>(true);
    let isNFCe = ref<boolean>(false);
    let isNM = ref<boolean>(false);
    let forMoreMails = ref<boolean>(false);
    let period = ref<string>('');


    const sendReport = async () => 
    {
        //const res = await apiEmail.post();

    };
</script>