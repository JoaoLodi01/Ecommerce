<template>
    <div class="">
        <q-btn @click="reportCustomer('all')" class="mr-5 bg-white" :class="{
            'mb-5': props.widthScreen <= 1080
        }">    
            <span v-if="props.widthScreen <= 1080">Listagem dos clientes ativos</span>
            <span v-else>Listagem completa de todos clientes</span>
        </q-btn>

        <q-btn @click="reportCustomer('all-disabled')" class="bg-white">
            <span v-if="props.widthScreen <= 1080">Listagem dos clientes inativos</span>
            <span v-else>Listagem completa de todos os clientes inativos</span>
        </q-btn>
    </div>
</template>

<script setup lang="ts">
    import { api } from 'src/boot/axios';
    import { useQuasar } from 'quasar';
    import { defineProps } from 'vue';

    let timer;

    const props = defineProps<{
        widthScreen: number,
        issuerID: number
    }>();

    const $q = useQuasar();

    const showLoading = () =>
    {
        $q.loading.show({
            message: 'Gerando relatório...'
        });

        timer = setTimeout(() => {
            $q.loading.hide()
            timer = void 0
        }, 2000);
    };

    const hideLoanding = () =>
    {
        $q.loading.hide()
    };

    const reportCustomer = async (type: string) =>
    {
        try {
            const apiURL = `/report/customers/${type}/${props.issuerID}`;
            const res = await api.get(apiURL, { 
                headers: {
                    responseType: 'blob'
                }
            });

            const url = window.URL.createObjectURL(new Blob([res.data], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' }));
            const link = document.createElement('a');
    
            link.href = url;
            link.setAttribute('download', `Listagem_de_Clientes.xlsx`);
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
            
        } catch (error) {
            hideLoanding();

        } finally {
            hideLoanding();

        };
    };
</script>