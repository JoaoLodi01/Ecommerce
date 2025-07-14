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
                                        label="Envio de e-mail - XML"

                                    /> 
                                </q-item-label>
                            </q-item-section>
                        </q-item>

                        <q-item v-ripple clickable v-close-popup>
                            <q-item-section>
                                <q-item-label>
                                    <q-btn 
                                        class="bg-blue-500 text-white"
                                        @click=""
                                        label="Outra função"

                                    /> 
                                </q-item-label>
                            </q-item-section>
                        </q-item>
                    </q-list>
                </q-btn-dropdown>
            </div>

        </div>
            <div class="items-center mb-6 mt-5">            
                <div class="">
                    <span>Aqui</span>
                </div>
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

<script setup lang="ts">
    import { LocalStorage } from "quasar";
    import { api } from "src/boot/axios";
    import ReportErros from "src/components/PDV/Errors/ReportErros.vue";
    import { ref } from 'vue';
    import { useRouter } from "vue-router";
    
    type SearchFill = {
        all: boolean,
        finaly_: boolean,
        noFinaly: boolean
        
    };

    type PDV = {
        id: number
    };  

    const router = useRouter();

    const showReportPDV = ref(false);
    const showListPDV = ref(true);
    const searchFill = ref<SearchFill | null>({
        all: true,
        finaly_: false,
        noFinaly: false
    });

    const countErros = ref(0);
    const savedPDVs = ref([]);
    const itensPDVs = ref([]);

    const getPDVsSaved = async () => {
        const res = await api.get(`/ecommerce/pdv/all/${LocalStorage.getItem("issuer_id")}`);
        savedPDVs.value = res.data.data

    }

    const openPDV = (pdv: PDV) => {
        router.push({
            name: 'PDVID',
            params: { idPDV: pdv.id },
            state: { isOpenedPDV: true }
        })
    }

    const openReportErros = () => {
        showReportPDV.value = true
        showListPDV.value = false

    }

    const closeReportErros = (event: any) => {
        showReportPDV.value = event 
        showListPDV.value = event 
    }
</script>