<template>
    <div class="fixed inset-0 z-50 flex items-center justify-center bg-opacity-40 backdrop-blur-sm">
        <div class="bg-white p-8 rounded-xl shadow-lg flex flex-col items-center gap-4">
            <q-file 
                v-model="file" 
                :color="buttonColor"
                label="Selecione um arquivo"
                accept=".xlsx, .xls, .csv"
            >
                
            </q-file>

            <div>
                <q-avatar 
                    :style="`background-color: ${buttonColor}; color: ${buttonColor === '#ffffff' ? '#000' : '#ffffff'}`"
                    @click="importProducts" 
                    class="mr-4"
                >
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M12 16.5V9.75m0 0 3 3m-3-3-3 3M6.75 19.5a4.5 4.5 0 0 1-1.41-8.775 5.25 5.25 0 0 1 10.233-2.33 3 3 0 0 1 3.758 3.848A3.752 3.752 0 0 1 18 19.5H6.75Z" />
                    </svg>
                </q-avatar>

                <q-btn 
                    color="red" 
                    icon="close" 
                    @click="emits('close', true)"
                />
            </div>
        </div>
    </div>
</template>

<script setup lang="ts">
    import { ref, defineEmits } from 'vue';
    import { LocalStorage, useQuasar } from 'quasar';
    import { api } from 'src/boot/axios';

    const emits = defineEmits<{
        (e: 'close', value: true)

    }>();

    const $q = useQuasar();
    const buttonColor = ref<string>(LocalStorage.getItem("buttonColor"));
    const issuerID = ref<number>(LocalStorage.getItem("issuer_id"));

    let file = ref<File | any>(null);

    const importProducts = async () =>
    {
        if(file.value)
        {
            $q.notify({
                color: 'green',
                message: 'Enviando arquivo ...',
                position: 'top',
                timeout: 2000

            });

            try {
                const formData = new FormData();
                formData.append('importFile', file.value);
                const res = await api.post(
                    `/ecommerce/products/import-products/${issuerID.value}`, 
                    formData,
                    {
                        headers: {
                            'Content-Type': 'multipart/form-data'

                        }
                    }
                );

                const data = res.data;

                $q.notify({
                    color: 'green',
                    message: data.message,
                    position: 'top',
                    timeout: 2000

                });
            } catch (error) {
                console.error('Erro: ', error);
            }            
        };
    };
</script>