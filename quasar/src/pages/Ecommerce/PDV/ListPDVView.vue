<template>
    <div
        class="flex borderborder-black mt-2 w-max ml-14" 
        
    >
        <div class="p-2 ml-4" v-if="showListPDV">
            <h1 class="text-xl">Listagem PDV <span class="text-sm">(NFC-e/Nota Manual)</span></h1>
            <div class="">
                <!--
                <input
                    type="checkbox"
                    v-model="searchFill.all"
                    @change="filterPDVs('all')"
                    
                /> <span class="mr-5">Todas</span>
                
                <input
                    type="checkbox"
                    v-model="searchFill.finaly"
                    @change="filterPDVs('finaly')"

                /> <span class="mr-5">Emitidas</span>

                <input
                    type="checkbox"
                    v-model="searchFill.noFinaly"
                    @change="filterPDVs('noFinaly')"

                /> <span>Não emitidas</span>-->
                <div class="">
                    <q-btn 
                        color="grey" 
                        @click="openReportErros()" 
                        class="mb-5"

                    > 
                        <span>Conferir relatórios de erros</span> 
                    </q-btn>
                    <span class="relative bottom-4 right-2 bg-gray-500 p-1 rounded-xl text-white">{{ countErros }}</span>
                </div>
                
            </div>
            
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
                        <td><button @click="openPDV(pdv)">Reabrir PDV</button></td>
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
                    const response = await api.get('/ecommerce/pdv/get-saved-sales')
                    this.savedPDVs = response.data.pdvs
    
                    for (let i = 0; i < response.data.pdvs.length; i++) {
                        this.itensPDVs = response.data.pdvs[i]['get_itens']
                        
                    }

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