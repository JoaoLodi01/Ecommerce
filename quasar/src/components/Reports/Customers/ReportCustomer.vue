<template>
    <button @click="reportCustomer('exportAllClients')">Listagem completa de todos clientes</button> |
    <button @click="reportCustomer('exportAllDesactiveClients')">Listagem completa de todos os clientes </button>|
    <button @click="reportCustomer('exportAllActiveClients')">Lis</button>

</template>

<script>
    import { api } from 'src/boot/axios';

    export default {
        methods: {
            async reportCustomer(type) {
                switch (key) {
                    case 'exportAllClients':
                        const response = await api.get('/customers/report/all', {
                            responseType: 'blob',
                        });

                        const blob = new Blob([response.data], { type: response.headers['content-type'] });
                        const url = window.URL.createObjectURL(blob);
                        const link = document.createElement('a');

                        link.href = url;
                        
                        link.setAttribute('download', 'Listagem de Clientes.xlsx');
                        document.body.appendChild(link);
                        link.click();
                        document.body.removeChild(link);

                        
                        break;
                
                    default:
                        break;
                }
            }
        }
    }
</script>