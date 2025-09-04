<template>
    <q-dialog v-model="show" persistent>
        <q-card>
            <q-card-section class="items-center q-ml-sm">
                <div class="mb-4">
                    <h1 class="text-xl border-b w-max">Envio de relatórios</h1>

                </div>

                <div class="flex">
                    <q-checkbox 
                        left-label 
                        v-model="mailOptions.isNFCe" 
                        label="Envio de NFC-e" 
                    />

                </div>

                <div class="flex">
                    <q-checkbox 
                        left-label 
                        v-model="mailOptions.isNM" 
                        label="Envio de Notas Manuais" 
                    />
                </div>
                
                <div class="flex">
                    <q-checkbox 
                        left-label 
                        v-model="mailOptions.forMoreMails" 
                        label="Envio para e-mails adicionais" 
                    />
                    
                    
                </div>
                <q-input 
                    v-model="period" 
                    type="number" 
                    label="Período de envio"
                    class="w-full"
                />
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

    interface IMailOptions {
        isNFCe: boolean,
        isNM: boolean,
        forMoreMails: boolean,
        
    };

    const mailOptions = ref<IMailOptions>({
        isNFCe: false,
        isNM: false,
        forMoreMails: false
    });

    let show = ref<boolean>(true);
    let period = ref<string>('');

    const sendReport = async () => 
    {
        //const res = await apiEmail.post();

        
    };
</script>