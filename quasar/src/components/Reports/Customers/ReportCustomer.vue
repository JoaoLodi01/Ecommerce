<template>
    <div>
        <q-btn @click="reportCustomer('all')" class="mr-5 bg-blue-500 hover:bg-blue-400 text-white" :class="{
            'mb-5': props.widthScreen <= 1080
        }">    
            <span v-if="props.widthScreen <= 1080">Listagem dos clientes ativos</span>
            <span v-else>Listagem completa de todos os clientes</span>
        </q-btn>

        <q-btn @click="reportCustomer('all-disabled')" class="bg-blue-500 hover:bg-blue-400 text-white">
            <span v-if="props.widthScreen <= 1080">Listagem dos clientes inativos</span>
            <span v-else>Listagem completa de todos os clientes inativos</span>
        </q-btn>
    </div>

    <ReportLoanding
        :generate="generate"
        :report="'customer'"        
    />

</template>

<script setup lang="ts">
    import { api } from 'src/boot/axios';
    import { useQuasar } from 'quasar';
    import { ref, defineProps } from 'vue';
    import ReportLoanding from 'src/components/Loanding/ReportLoanding.vue';

    const props = defineProps<{
        widthScreen: number,
        issuerID: number

    }>();

    const $q = useQuasar();
    let generate = ref<boolean>(false);

    const reportCustomer = async (type: string) =>
    {
        generate.value = true;
        try {
            const apiURL = `/report/customers/${type}/${props.issuerID}`;
            const res = await api.get(apiURL, { 
                responseType: 'blob'
            });

            const url = window.URL.createObjectURL(new Blob([res.data], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' }));
            const link = document.createElement('a');
    
            link.href = url;
            link.setAttribute('download', `Listagem_de_Clientes.xlsx`);
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
    };
</script>