<template>
    <q-btn 
        @click="reportCustomer('Listagem_Completa_Ativos')" 
        class="bg-blue-500 hover:bg-blue-400 transition text-white font-semibold rounded-lg mr-5"
        
        :class="{ 
            'mb-5': widthScreen <= 1089 
        }"
    >
        <span v-if="widthScreen <= 1080">Listagem completa dos produtos</span>
        <span v-else>Listagem completa dos produtos ativos</span>
    </q-btn>

    <q-btn 
        @click="reportCustomer('Listagem_Completa_Inativos')" 
        class="bg-blue-500 hover:bg-blue-400 transition text-white font-semibold rounded-lg mr-5"
        :class="{ 
            'mb-5': widthScreen <= 1089 
        }"
    >
        <span v-if="widthScreen <= 1080">Listagem completa dos produtos inativos</span>
        <span v-else>Listagem completa de todos os produtos inativos</span>
    </q-btn>

    <q-btn 
        @click="reportCustomer('Listagem_Completa')" 
        class="bg-blue-500 hover:bg-blue-400 transition text-white font-semibold rounded-lg mr-5"
    >
        <span v-if="widthScreen <= 1080">Listagem completa de todos os produtos</span>
        <span v-else>Listagem completa de todos os produtos</span>
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

            async reportProduct(type) {
                this.showLoading()
                try {
                    switch (type) {
                        case 'Listagem_Completa_Ativos':
                            let responseAll = await api.get('/report/all', {
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
        },
        props: {
            widthScreen: {
                type: Number,
                required: true
            }

        }
    }
</script>