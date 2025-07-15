<template>
    <div class="fixed inset-0 z-50 flex items-center justify-center bg-opacity-40 backdrop-blur-sm">
        <div class="bg-white p-8 rounded-xl shadow-lg flex flex-col items-center gap-4">
            <q-file 
                v-model="file" 
                :color="buttonColor"
                label="Selecione um arquivo"
                :accept="props.operation === 'importProducts' ? '.xlsx, .xls, .csv' : 'json'"

            >
                
            </q-file>

            <div>
                <q-avatar 
                    :style="`background-color: ${buttonColor}; color: ${buttonColor === '#ffffff' ? '#000' : '#ffffff'}`"
                    @click="importFile" 
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
    import { ref, defineEmits, defineProps, reactive, onMounted } from 'vue';
    import { LocalStorage, useQuasar } from 'quasar';
    import { api } from 'src/boot/axios';

    const props = defineProps<{
        operation: string

    }>();

    const emits = defineEmits<{
        (e: 'close', value: true)

    }>();

    const $q = useQuasar();
    const buttonColor = ref<string>(LocalStorage.getItem("buttonColor"));
    const issuerID = ref<number>(LocalStorage.getItem("issuer_id"));

    const routes = reactive({
        'importColor': 'configs/color/import-color',
        'importProducts': '/ecommerce/products/import-products'

    });

    let file = ref<File | any>(null);

    const importFile = async () =>
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
                const apiURL: string = `${routes[props.operation]}/${issuerID.value}`;
                console.log('apiURL: ', apiURL);

                const res = await api.post(
                    apiURL, 

                    formData,
                    {
                        headers: {
                            'Content-Type': 'multipart/form-data'

                        }
                    }
                );

                const data = res.data;

                console.log(data);

                $q.notify({
                    color: 'green',
                    message: data.message,
                    position: 'top',
                    timeout: 2000

                });

                if(data.success)
                {
                    $q.notify({
                        color: 'green',
                        message: 'Produtos importados com sucesso!',
                        position: 'top',
                        timeout: 2000

                    });
                    emits('close', true);

                };

            } catch (error) {
                $q.notify({
                    color: 'red',
                    message: error.response.data.message || 'Erro na importação!',
                    position: 'top',
                    timeout: 2200

                });
            }            
        } else {
            $q.notify({
                color: 'red',
                message: 'Selecione o arquivo para importação!',
                position: 'top',
                timeout: 2000

            });
        };
    };

    onMounted(() => {
        const apiURL: string = `${routes[props.operation]}/${issuerID.value}`;
        console.log('apiURL: ', apiURL);
    });
</script>