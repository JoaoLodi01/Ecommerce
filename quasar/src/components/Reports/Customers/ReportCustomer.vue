<template>
    <div class="">
        <q-btn @click="reportCustomer('Listagem_Completa')" class="mr-5 bg-white" :class="{
            'mb-5': widthScreen <= 1080
        }">    
            <span v-if="widthScreen <= 1080">Listagem dos clientes ativos</span>
            <span v-else>Listagem completa de todos clientes</span>
        </q-btn>

        <q-btn @click="reportCustomer('Listagem_Completa_Inativos')" class="bg-white">
            <span v-if="widthScreen <= 1080">Listagem dos clientes inativos</span>
            <span v-else>Listagem completa de todos os clientes inativos</span>
        </q-btn>
    </div>
</template>

<script>
    import { api } from 'src/boot/axios';
    import { useQuasar } from 'quasar';
    import { onBeforeUnmount } from 'vue';

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
                this.showLoading()
                try {
                    const prefix = '/report/customers'
                    switch (type) {
                        case 'Listagem_Completa':
                            let responseAll = await api.get(`${prefix}/all`, {
                                responseType: 'blob',

                            });
                            
                            this.downloadFile(responseAll, type)

                            break;

                        case 'Listagem_Completa_Inativos':
                            const responseAllDisabled = await api.get(`${prefix}/all-disabled`, {
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
        },

        props: {
            widthScreen: {
                type: Number,
                required: true
            }
        },

    }
</script>