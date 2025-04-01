<template>
    <q-btn @click="showLoading" class="mr-5">    
        <button @click="reportCustomer('Listagem_Completa')">Listagem completa de todos clientes</button>
    </q-btn>

    <q-btn @click="showLoading">
        <button @click="reportCustomer('Listagem_Completa_Inativos')">Listagem completa de todos os clientes inativos</button>
    </q-btn>
</template>

<script>
    import { api } from 'src/boot/axios';
    import { useQuasar } from 'quasar';
    import { onBeforeUnmount } from "vue";

    export default {
        setup () {
            const $q = useQuasar()
            let timer

            onBeforeUnmount(() => {
                if (timer !== void 0) {
                    clearTimeout(timer)
                    $q.loading.hide()
                }
            })

            return {
                showLoading () {
                    $q.loading.show({
                        message: 'Gerando relatório...'
                    })

                    timer = setTimeout(() => {
                        $q.loading.hide()
                        timer = void 0
                    }, 2000)
                }
            }
        },

        methods: {
            downloadFile(response, type)
            {
                const blob = new Blob([response.data], { type: response.headers['content-type'] });
                const url = window.URL.createObjectURL(blob);
                const link = document.createElement('a');

                link.href = url;
                link.setAttribute('download', `${type}.xlsx`);
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);

            },

            async reportCustomer(type) {
                try {
                    console.log('Vai começar a gerar')
                    switch (type) {
                        case 'Listagem_Completa':
                            
                            let responseAll = await api.get('/customers/report/all', {
                                responseType: 'blob',
                            });
                            
                            this.downloadFile(responseAll, type)

                            break;

                        case 'Listagem_Completa_Inativos':
                            const responseAllDisabled = await api.get('/customers/report/all-disabled', {
                                responseType: 'blob',
                            });
                            
                            this.downloadFile(responseAllDisabled, type)
    
                            break;
                    
                    
                        default:
                            break;
                    }
                    
                } catch (error) {
                    console.error('Erro', error)
                }
            }
        }
    }
</script>