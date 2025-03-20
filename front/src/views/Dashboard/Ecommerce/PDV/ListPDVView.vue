<template>
    <div
        class="flex borderborder-black mt-2 w-max ml-14" 

    >
        <div class="">
            <h1>Listagem PDV <span class="text-sm">(NFC-e/Nota Manual)</span></h1>
            <div class="">
                <input
                    type="checkbox"
                    v-model="searchFill.all"

                /> <span class="mr-5">Todas</span>
                
                <input
                    type="checkbox"
                    v-model="searchFill.finaly"

                /> <span class="mr-5">Emitidas</span>

                <input
                    type="checkbox"
                    v-model="searchFill.noFinaly"

                /> <span>Não emitidas</span>
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
    </div>
</template>

<script>
    import axios from 'axios';  

    export default {
        data()
        {
            return {
                searchFill: {
                    all: true,
                    finaly: false,
                    noFinaly: false
                },
                savedPDVs: [],
                itensPDVs: [],
                api: process.env.VUE_APP_API_URL

            }
        },

        watch: {
            filterPDVs(selected)
            {   
                Object.keys(this.searchFill).forEach(key => {
                    this.searchFill[key] = (key === selected)

                })

                console.log('selected', selected, ' this.searchFill, ', this.searchFill)
                
            },

        },
        
        methods: {
            async getPDVsSaved()
            {   
                try {
                    const response = await axios.get(`${this.api}/ecommerce/pdv/get-saved-sales`)
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
            }
        },

        mounted()
        {
            this.getPDVsSaved()   
        }
    }
</script>