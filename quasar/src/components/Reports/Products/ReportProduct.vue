<template>
    <div class="fixed inset-0 z-50 flex items-center justify-center bg-opacity-40 backdrop-blur-sm ">        
        <div class="bg-white p-12 rounded ">
            <q-btn 
                icon="close"
                class="flex justify-end ml-auto mr-1 -mt-4"
                color="red"
                @click="emits('close', true)"
                
            />
            
            <h1 class="border-b w-max text-3xl text-center -mb-8">Geração de relatórios</h1>

            <div class="p-5 mt-5">
                <div class="flex mt-5">
                    <q-btn 
                        @click="reportProducts('all')" 
                        class="transition text-white font-semibold rounded-lg m flex"
                        :style="`background-color: ${buttonColor}; color: ${textColor}`"
                        
                    >
                        <span>Listagem completa dos produtos</span>
                    </q-btn>
                </div>

                <div class="flex mt-5">
                    <q-btn 
                        @click="reportProducts('all-disabled')" 
                        class="transition text-white font-semibold rounded-lg m flex"
                        :style="`background-color: ${buttonColor}; color: ${textColor}`"
                        
                    >
                        <span>Listagem completa dos produtos inativos</span>
                        
                    </q-btn>
                </div>
    
                <div class="flex mt-5">
                    <q-btn 
                        @click="reportProducts('Listagem_Completa')" 
                        class="transition text-white font-semibold rounded-lg m flex"
                        :style="`background-color: ${buttonColor}; color: ${textColor}`"
                    >
                        <span>Listagem completa de todos os produtos</span>
                        
                    </q-btn>
                </div>
            </div>
        </div>
    </div>

    <ReportLoanding
        v-if="generate"
        :generate="generate"
        :report="'products'"        
    />
</template>

<script setup lang="ts">
    import { api } from 'src/boot/axios';
    import { useQuasar, LocalStorage } from 'quasar';
    import { ref, defineEmits, onMounted } from 'vue';
    import ReportLoanding from 'src/components/Loanding/ReportLoanding.vue';

    const emits = defineEmits<{
        (e: 'close', value: boolean);

    }>();

    const $q = useQuasar();

    let generate = ref<boolean>(false);
    const buttonColor = ref<string>(LocalStorage.getItem("buttonColor"));
    const textColor = ref<string>(LocalStorage.getItem("textColor"));
    const issuerID = ref<number>(LocalStorage.getItem("issuerID"));

    const updateProgress = () =>
    {

    };

    const reportProducts = async (type: string) =>
    {
        generate.value = true;
        try {
            const apiURL = `/report/products/${type}/${issuerID.value}`
            const res = await api.get(apiURL, {
                responseType: 'blob'

            });

            const url = window.URL.createObjectURL(new Blob([res.data], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' }));
            const link = document.createElement('a');
    
            link.href = url;
            link.setAttribute('download', `Listagem_de_Produtos.xlsx`);
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);

            if(res.status === 200)
            {
                generate.value = false;
                $q.notify({
                    color: 'green',
                    message: 'Relatório gerado com sucesso!',
                    timeout: 2000,
                    position: 'top'
                    
                });
            };
            
        } catch (error) {
            console.error('Erro: ', error);
            $q.notify({
                color: 'red',
                message: 'Erro ao gerar relatório!',
                timeout: 2000,
                position: 'top'

            });

        } finally {
            generate.value = false;
            
        };  

        onMounted(() => {
            buttonColor.value = LocalStorage.getItem("buttonColor");
            textColor.value = LocalStorage.getItem("textColor") ?? '#ffffff';
        });
    }
</script>