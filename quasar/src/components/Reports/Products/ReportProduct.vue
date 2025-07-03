<template>
    <q-btn 
        @click="reportProducts('all')" 
        class="hover:bg-blue-400 transition text-white font-semibold rounded-lg mr-5"
        :style="`background-color: ${buttonColor}; color: ${textColor}`"
        :class="{ 
            'mb-5': widthScreen <= 1089 
        }"
    >
        <span v-if="widthScreen <= 1080">Listagem completa dos produtos</span>
        <span v-else>Listagem completa dos produtos ativos</span>
    </q-btn>

    <q-btn 
        @click="reportProducts('all-disabled')" 
        class="hover:bg-blue-400 transition text-white font-semibold rounded-lg mr-5"
        :style="`background-color: ${buttonColor}; color: ${textColor}`"
        :class="{ 
            'mb-5': widthScreen <= 1089 
        }"
    >
        <span v-if="widthScreen <= 1080">Listagem completa dos produtos inativos</span>
        <span v-else>Listagem completa de todos os produtos inativos</span>
    </q-btn>

    <q-btn 
        @click="reportProducts('Listagem_Completa')" 
        class="hover:bg-blue-400 transition text-white font-semibold rounded-lg mr-5"
        :style="`background-color: ${buttonColor}; color: ${textColor}`"
    >
        <span v-if="widthScreen <= 1080">Listagem completa de todos os produtos</span>
        <span v-else>Listagem completa de todos os produtos</span>
    </q-btn>

    <ReportLoanding
        v-if="generate"
        :generate="generate"
        :report="'products'"        
    />

</template>

<script setup lang="ts">
    import { api } from 'src/boot/axios';
    import { useQuasar, LocalStorage } from 'quasar';
    import { ref, defineProps, onMounted } from 'vue';
    import ReportLoanding from 'src/components/Loanding/ReportLoanding.vue';

    const $q = useQuasar();

    let generate = ref<boolean>(false);
    const buttonColor = ref<string>(LocalStorage.getItem("buttonColor"));
    const textColor = ref<string>(LocalStorage.getItem("textColor"));
    const issuerID = ref<number>(LocalStorage.getItem("issuerID"));

    const props = defineProps<{
        widthScreen: number,
    }>();
            
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