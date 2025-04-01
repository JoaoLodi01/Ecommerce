<template>
    <button @click="reportCustomer('exportAllClients')">Listagem completa de todos clientes</button> |
    <button @click="reportCustomer('exportAllDesactiveClients')">Listagem completa de todos os clientes </button>|
    <button @click="reportCustomer('exportAllActiveClients')">Lis</button>

</template>

<script>
    import { api } from 'src/boot/axios';

    export default {
        methods: {
            downloadFile(response, type)
            {
                const blob = new Blob([response.data], { type: response.headers['content-type'] });
                const url = window.URL.createObjectURL(blob);
                const link = document.createElement('a');

                link.href = url;
                link.setAttribute('download', 'Listagem de Clientes.xlsx');
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);

            },

            async reportCustomer(type) {
                try {
                    switch (type) {
                        case 'exportAllClients':
                            let responseAll = await api.get('/customers/report/all', {
                                responseType: 'blob',
                            });

                            this.downloadFile(responseAll, type)

                            break;

                        case 'exportAllDesactiveClients':
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