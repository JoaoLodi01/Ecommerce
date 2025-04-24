<template>
    <div class="mt-10 ml-16">
        <div class="list-pdv" v-if="showListPDV">
            <h1 class="text-2xl font-semibold">Listagem PDV
                <span class="text-sm">(NFC-e/Nota Manual)</span>
            </h1>

            <q-btn-dropdown 
                label="Ações" 
                color="grey"
                menu-anchor="bottom end"
            >
                <q-list class="bg-white">
                    <q-item v-ripple clickable v-close-popup>
                        <q-item-section>
                            <q-item-label>
                                <q-btn 
                                    color="grey" 
                                    @click="openReportErros()"
                                    label="Conferir relatórios de erros"

                                /> 
                                <span 
                                    class="relative bottom-2 right-2 bg-slate-500 p-1 rounded-xl text-white"
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
                                    color="grey" 
                                    @click=""
                                    label="Alguma outra funcão"

                                /> 
                            </q-item-label>                            
                        </q-item-section>
                    </q-item>
                </q-list>
            </q-btn-dropdown>

            <div class="items-center mb-6">            
                <table>
                    <thead>
                        <tr>
                            <th>Opções</th>
                            <th>ID</th>
                            <th>Descrição</th>
                            <th>Total bruto</th>
                            <th>Total líquido</th>
                            <th>Desconto</th>
                            <th>Acréscimo</th>
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