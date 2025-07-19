<template>
    <div class="fixed inset-0 z-50 flex items-center justify-center bg-opacity-40 backdrop-blur-sm">
        <div class="bg-white p-8 rounded-xl shadow-lg flex flex-col items-center gap-4">
            <h1 class="text-2xl border-b">{{ title }}</h1>
            <q-file 
                v-model="file" 
                :color="buttonColor"
                label="Selecione um arquivo"
                :accept="acceptedFormat"

            />
            
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
            <div v-if="props.operation === 'alterLogo'">
                <span 
                    class="flex"
                >
                    Escala de imagem recomendada: 512x512|1024x1024
                </span>
                <span 
                    class="flex justify-end cursor-pointer text-blue-500" 
                    @click="downloadLogo"
                >
                    Deseja fazer o download da sua logo?
                </span>
            </div>
        </div>
    </div>
</template>

<script setup lang="ts">
    import { ref, computed, reactive, onMounted } from 'vue';
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
    
    const fileType = reactive({
        'importProducts': 'xlsx',
        'importCustomers': 'xlsx',
        'importColor': 'json',
        'alterLogo': ['jpeg', 'png', 'jpg']
    });

    const titles = reactive({
        'importColor': 'Importar arquivo de cores',
        'importProducts': 'Importar produtos',
        'importCustomers': 'Importar clientes',
        'alterLogo': 'Alterar logo',
    });

    const routes = reactive({
        'importColor': 'configs/color/import-color',
        'importProducts': '/ecommerce/products/import-products',
        'importCustomers': '/customers/import-customers',
        'alterLogo': '/configs/pdv/alter-logo'

    });

    const successMessages = reactive({
        'importColor': 'Cores importadas com sucesso!',
        'importProducts': 'Produtos importados com sucesso!',
        'importCustomers': 'Clientes importados com sucesso!',
        'alterLogo': 'Logo alterada com sucesso, recarregue a página!'
        
    })

    let file = ref<File | any>(null);
    let title = ref<string>('');

    const acceptedFormat = computed(() => {
        const type = fileType[props.operation];

        if (type === 'xlsx') {
            return '.xlsx,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
        }

        if (type === 'json') {
            return '.json,application/json';
        }

        if (Array.isArray(type)) {
            return type.map(ext => `.${ext}`).join(',');
        }

        return ''; // fallback
    });

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

                if(data.success)
                {
                    $q.notify({
                        color: 'green',
                        message: successMessages[props.operation],
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
                message: 'Selecione o arquivo!',
                position: 'top',
                timeout: 2000

            });
        };
    };

    const downloadLogo = async () =>
    {
        try {
            const res = await api.get(`configs/pdv/download-logo/${issuerID.value}`, {
                responseType: 'blob'

            });
            const url = window.URL.createObjectURL(new Blob([res.data], { type: 'image/png' }));
            const link = document.createElement('a');
            
            link.href = url;
            link.setAttribute('download', `Logo.png`);
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
            
        } catch (error) {
            
        };
    };

    onMounted(() => {
        const apiURL: string = `${routes[props.operation]}/${issuerID.value}`;
        title.value = titles[props.operation];
        console.log('apiURL: ', apiURL);
    });
</script>