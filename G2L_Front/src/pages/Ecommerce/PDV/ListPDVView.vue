<template>
    <div class="w-[165vh] mx-auto mt-5 p-6 ml-14 bg-white rounded-lg shadow-lg">
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
        <q-separator color="grey" />

        <div class="mb-6 mt-5 bg-white">
            <q-table
                title="Vendas"
                :data="data"
                :columns="columns"
                row-key="name"
            />
        </div>        
    </div>
        
    <div class="" v-if="showReportPDV">
        <ReportErros
            @close="closeReportErros($event)"
        />
    </div>
    
</template>

<script setup lang="ts">
    import { LocalStorage } from "quasar";
    import { api } from "src/boot/axios";
    import ReportErros from "src/components/PDV/Errors/ReportErros.vue";
    import { onMounted, ref } from 'vue';
    import { useRouter } from "vue-router";
    
    type TSearchFill = {
        all: boolean,
        finaly_: boolean,
        noFinaly: boolean
        
    };

    type TPDV = {
        id: number
    };  

    const router = useRouter();

    const showReportPDV = ref(false);
    const showListPDV = ref(true);
    
    const searchFill = ref<TSearchFill | null>({
        all: true,
        finaly_: false,
        noFinaly: false
    });

    const countErros = ref(0);
    let savedPDVs = ref([]);

    const getAllPDVs = async () => {
        const res = await api.get(`/ecommerce/pdv/all/${LocalStorage.getItem("issuer_id")}`);
        savedPDVs.value = res.data;
        console.log('savedPDVs:', res.data);
    };

    const openPDV = (pdv: TPDV) => {
        router.push({
            name: 'PDVID',
            params: { idPDV: pdv.id },
            state: { isOpenedPDV: true }
        });
    };

    const openReportErros = () => {
        showReportPDV.value = true;
        showListPDV.value = false;

    };

    const closeReportErros = (event: any) => {
        showReportPDV.value = event;
        showListPDV.value = event;
    };

    onMounted(() => {
        getAllPDVs();
    });
</script>