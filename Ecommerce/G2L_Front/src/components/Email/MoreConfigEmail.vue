<template>
    <q-dialog v-model="show" persistent>
        <q-card>
            <q-card-section class="h-auto overflow-hidden">
                <div class="w-96 ml-4">
                    <span class="border-b text-lg">E-mails adicioneis</span>
                    <div class="flex mt-2">
                        <div class="mt-2">
                            <q-input 
                                v-model="email" 
                                type="text" 
                                label="Endereço de e-mail" 
                                class="border-b"
                                borderless
                            />
                        </div>

                        <div class="mt-auto mb-auto ml-4 cursor-pointer text-blue-700" @click="appendEmail()">
                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v6m3-3H9m12 0a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z" />
                            </svg>
                        </div>
                    </div>

                    <div class="mt-4 border rounded w-48">
                        <div v-for="mail in allEmails" v-if="!removeLoandig">
                            <div class="flex justify-center p-1">
                                {{ mail.aditionalEmailCode }} - {{ mail.mail }} | 
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-5 mt-auto mb-auto text-red-500 cursor-pointer" @click="removeEmail(mail.aditionalEmailCode)">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M15 12H9m12 0a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z" />
                                </svg>

                            </div>
                        </div>

                        <div class="flex justify-center p-1" v-if="removeLoandig">
                            <span>Removendo e-mail ...</span>
                            <span class="loader"></span>
                        </div>

                        <div v-if="allEmails.length === 0" class="flex justify-center">
                            <span class="p-2">Sem e-mails cadastrados! {{ allEmails.length }}</span>
                        </div>
                    </div>
                </div>
            </q-card-section>
            <q-card-actions align="right">
                <q-btn flat label="Fechar" color="primary" @click="close()" /> <!-- Fazer o emits -->
            </q-card-actions>
        </q-card>
    </q-dialog>
</template>
<script setup lang="ts">
    import { onMounted, ref } from 'vue'
    import { LocalStorage, useQuasar } from 'quasar';
    import { api } from 'src/boot/axios';
    import camelcaseKeys from 'camelcase-keys';

    interface IMail {
        readonly issuerID: number,
        aditionalEmailCode: number,
        mail: string
        active: number,
    }

    const emits = defineEmits<{
        (e: 'close', value: boolean)
    }>();

    const $q = useQuasar();
    const issuerID = ref<number>(LocalStorage.getItem("issuer_id"));
    let show = ref<boolean>(true);
    let email = ref<string>('');
    let allEmails = ref<IMail[]>([]);
    let removeLoandig = ref<boolean>(false);

    const appendEmail = async () => 
    {
        const emailExists = allEmails.value.find(e => e.mail === email.value);
        if(emailExists)
        {
            $q.notify({
                position: 'top',
                color: 'red',
                message: 'E-mail já adicionado!',
                timeout: 1200

            });
            return;
            
        } else if(email.value === '' || !email.value.includes('@')) {
            $q.notify({
                position: 'top',
                color: 'red',
                message: 'E-mail inválido!',
                timeout: 1200
            });
            return;
        };
        
        try {
            const payLoad = {
                'mail': email.value,
                'issuerID': issuerID.value
            };

            const res = await api.post('/configs/email/create/aditional', payLoad);
            const data = camelcaseKeys(res.data.data, { deep: true });

            $q.notify({
                position: 'top',
                color: 'green',
                message: 'E-mail adicionado com sucesso!',
                timeout: 1200
            });

            allEmails.value = [...allEmails.value, {
                issuerID: data.issuerID,
                aditionalEmailCode: data.aditionalEmailCode,
                mail: data.mail,
                active: data.active
                
            }];

            email.value = '';
            
        } catch (e) {};
    };

    const removeEmail = async (mailCode: number) => 
    {
        removeLoandig.value = true;
        try {
            if(mailCode !== 0)
            {
                const payLoad = {
                    'issuerID': issuerID.value,
                    'mailCode': mailCode
                };
                
                const res = await api.put('/configs/email/delete/aditional', payLoad);
                getEmails();

            };

        } catch (e) {}
        finally {
            removeLoandig.value = false;
        };
    };

    const getEmails = async () =>
    {
        const mails = await api.get(`/configs/email/all/aditional/${issuerID.value}`);
        
        allEmails.value = camelcaseKeys(mails.data.data, { deep: true });
    };

    const close = () =>{
        show.value = false;
        emits('close', true);
    }

    onMounted(async() => {
        getEmails();

    });
</script>