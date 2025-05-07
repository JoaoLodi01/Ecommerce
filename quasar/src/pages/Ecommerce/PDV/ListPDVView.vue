<template>
    <div class="container mx-auto mt-10 p-6 ml-16 bg-white rounded-lg shadow-lg">
        <div class="flex justify-between items-center mb-6" v-if="showListPDV">
            <h1 class="text-2xl font-semibold">Listagem PDV
                <span class="text-sm">(NFC-e/Nota Manual)</span>
            </h1>
            <div class="flex space-x-4">
                <q-btn-dropdown 
                    label="Ações"
                    class="mt-5 bg-blue-500 text-white" 
                    menu-anchor="bottom end"
                >
                    <q-list class="bg-white">
                        <q-item v-ripple clickable v-close-popup>
                            <q-item-section>
                                <q-item-label>
                                    <q-btn 
                                        class="bg-blue-500 text-white"
                                        @click="openReportErros()"
                                        label="Conferir relatórios de erros"

                                    /> 
                                    <span 
                                        class="relative bottom-2 right-2 bg-blue-500 p-1 rounded-xl text-white"
                                        :class="{
                                            'bg-green-700': countErros >= 0,
                                            'bg-orange-700': countErros >= 3,
                                            'bg-red-700': countErros >= 5,

                                        }"
                                    >
                                        {{ countErros }}
                                    </span>
                                </q-item-label>                            
                            </q-item-section>
                        </q-item>
                        <q-item v-ripple clickable v-close-popup>
                            <q-item-section>
                                <q-item-label>
                                    <q-btn 
                                        class="bg-blue-500 text-white"
                                        @click=""
                                        label="Alguma outra funcão"

                                    /> 
                                </q-item-label>                            
                            </q-item-section>
                        </q-item>
                    </q-list>
                </q-btn-dropdown>
            </div>
        </div>

            <div class="items-center mb-6 mt-5">            
                <table class="overflow-x-auto min-w-full table-auto border-collapse border border-gray-200">
                    <thead class="bg-gray-100">
                        <tr>
                            <th scope="col" class="px-6 py-3">Opções</th>
                            <th scope="col" class="px-6 py-3">ID</th>
                            <th scope="col" class="px-6 py-3">Descrição</th>
                            <th scope="col" class="px-6 py-3">Total bruto</th>
                            <th scope="col" class="px-6 py-3">Total líquido</th>
                            <th scope="col" class="px-6 py-3">Desconto</th>
                            <th scope="col" class="px-6 py-3">Acréscimo</th>
                        </tr>
                    </thead>
                    <tbody v-for="(pdv, id) in savedPDVs" :key="id">
                        <tr>
                            <td v-if="!pdv.finished"><button @click="openPDV(pdv)">Reabrir PDV</button></td>
                            <td>{{ pdv.id }}</td>
                            <td>{{ pdv.description }}</td>
                            <td>{{ pdv.gross_value }}</td>
                            <td>{{ pdv.net_value }}</td>
                            <td>{{ pdv.discount }}</td>
                            <td>{{ pdv.addition }}</td>
                        </tr>
                    </tbody>
                </table>

            </div>        
        <div class="" v-if="showReportPDV">
                <ReportErros
                    @close="closeReportErros($event)"
                />
        </div>
    </div>
    
</template>

<script>
    import { api } from "src/boot/axios";
    import ReportErros from "src/components/PDV/Errors/ReportErros.vue";
    
    export default {
        data()
        {
            return {
                showReportPDV: false,
                showListPDV: true,

                searchFill: {
                    all: true,
                    finaly: false,
                    noFinaly: false
                },
                countErros: 0,
                savedPDVs: [],
                itensPDVs: [],                

            }
        },
        
        methods: {
            async getPDVsSaved()
            {   
                try {
                    const response = await api.get('/ecommerce/pdv/all')
                    this.savedPDVs = response.data.data
                    console.log(response.data.data)
                    /*for (let i = 0; i < response.data.pdvs.length; i++) {
                        this.itensPDVs = response.data.pdvs[i]['get_itens']
                        
                    }*/

                } catch (error) {
                    console.error('Erro getPDVs', error)
                    
                }
            },
            
            openPDV(pdv)
            {
                this.$router.push({
                    name: 'PDVID', 
                    params: { idPDV: pdv.id, },
                    state: { isOpenedPDV: true }
                })
                

            },

            openReportErros()
            {
                this.showReportPDV = true
                this.showListPDV = false
            },
            closeReportErros(event)
            {
                this.showReportPDV = event
                this.showListPDV = !event
            }
        },

        mounted()
        {
            this.getPDVsSaved()   
            const countErrorsFun = async () => {
                const response = await api.get('/ecommerce/pdv/get-all-errors')
                this.countErros = response.data.all.count
                console.log(response.data)
            }
            countErrorsFun()

        },

        components: {
            ReportErros
        }
    }
</script>