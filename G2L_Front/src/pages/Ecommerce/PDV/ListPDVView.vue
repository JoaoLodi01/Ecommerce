<template>
    <div class="w-[145vh]  mx-auto mt-5 p-6 ml-14 bg-white rounded-lg shadow-lg">
        <div class="flex justify-between items-center mb-6" v-if="showListPDV">
            <h1 class="text-2xl font-semibold mt-5">Listagem de vendas
                <span class="text-sm">(NFC-e/Nota Manual)</span>
            </h1>

            <div class="flex space-x-4">
                <q-btn-dropdown 
                    label="Ações"
                    class="mt-5" 
                    :style="`background-color: ${buttonColor}; color: ${textColor}`"
                    menu-anchor="bottom end"
                >
                    <q-list class="bg-white">
                        <q-item v-ripple clickable v-close-popup>
                            <q-item-section>
                                <q-item-label>
                                    <q-btn 
                                        @click="openReportErros()"
                                        :style="`background-color: ${buttonColor}; color: ${textColor}`"
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
                                        :style="`background-color: ${buttonColor}; color: ${textColor}`"
                                        label="Envio de e-mail - XML"
                                        @click=""

                                    /> 
                                </q-item-label>
                            </q-item-section>
                        </q-item>

                        <q-item v-ripple clickable v-close-popup>
                            <q-item-section>
                                <q-item-label>
                                    <q-btn 
                                        :style="`background-color: ${buttonColor}; color: ${textColor}`"
                                        label="Outra função"
                                        @click=""

                                    /> 
                                </q-item-label>
                            </q-item-section>
                        </q-item>
                    </q-list>
                </q-btn-dropdown>
            </div>
        </div>
        <q-separator color="grey" />

        <div 
            class="mb-6 mt-5 bg-white h-[70vh]"
            
        >
             <q-table
                flat
                :rows="allPDVs"
                :columns="columns"
                class="my-sticky-column-table h-[74vh]"
            >

                <template v-slot:header="props">
                    <q-tr 
                        :props="props"
                        :style="`background-color: ${buttonColor}; color: ${textColor}`"
                    >
                        <q-th
                            v-for="col in props.cols"
                            :key="col.name"
                            :props="props"
                            :style="`color: ${textColor}`"
                        >
                            {{ col.label }}
                        </q-th>
                    </q-tr>
                </template>

                <template v-slot:no-data>
                    <div class="flex justify-center w-full">
                        Sem dados no momento ...
                    </div>
                </template>

                <template v-slot:body-cell-actions="props">
                    <q-td :props="props" class="q-gutter-sm shadow-lg">
                        <q-btn dense flat icon="more_vert">
                            <q-menu>
                                <q-list style="min-width: 120px;" class="text-xs">
                                    <q-item clickable v-close-popup class=" bg-red-500">
                                        <q-item-section>
                                            <div class="flex">
                                                <span class="mt-auto mb-auto text-white">Cancelar</span>
                                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-5 ml-auto text-white">
                                                    <path stroke-linecap="round" stroke-linejoin="round" d="M6 18 18 6M6 6l12 12" />
                                                </svg>
                                            </div>
                                        </q-item-section>
                                    </q-item>
                                    
                                    <q-item clickable v-close-popup class=" bg-blue-500">
                                        <q-item-section>
                                            <div class="flex">
                                                <span class="mt-auto mb-auto text-white">Visualizar</span>
                                                 <svg 
                                                    xmlns="http://www.w3.org/2000/svg"
                                                    fill="none" 
                                                    viewBox="0 0 24 24" 
                                                    stroke-width="1.5" 
                                                    stroke="currentColor" 
                                                    class="size-5 ml-auto text-white"
                                                >
                                                    <path stroke-linecap="round" stroke-linejoin="round" d="M2.036 12.322a1.012 1.012 0 0 1 0-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178Z" />
                                                    <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
                                                </svg>
                                            </div>
                                        </q-item-section>
                                    </q-item>
                                </q-list>
                            </q-menu>
                        </q-btn>
                    </q-td>
                </template>
            </q-table>
        </div>        
    </div>
        
    <div v-if="showReportPDV">
        <ReportErros
            @close="closeReportErros($event)"
        />
    </div>
    
</template>

<script setup lang="ts">
    import { LocalStorage, QTableColumn, useQuasar } from "quasar";
    import { api } from "src/boot/axios";
    import { onMounted, ref } from 'vue';
    import { useRouter } from "vue-router";
    import dayjs from "dayjs";
    import ReportErros from "src/components/PDV/Errors/ReportErros.vue";
    
    type TSearchFill = {
        all: boolean,
        finaly_: boolean,
        noFinaly: boolean
        
    };

    type TPDV = {
        id: number
    };  

    const $q = useQuasar()
    const today = dayjs();
    const router = useRouter();
    const showReportPDV = ref(false);
    const showListPDV = ref(true);    
    const buttonColor = LocalStorage.getItem("buttonColor");
    const painelColor = LocalStorage.getItem("painelColor");
    const textColor = LocalStorage.getItem("textColor");
    
    const searchFill = ref<TSearchFill | null>({
        all: true,
        finaly_: false,
        noFinaly: false
    });

    const columns: QTableColumn[] = [
        {
            name: 'actions',
            label: 'Ações',
            field: 'actions',
            align: 'center'
        },
        {name: 'pdv_code', label: 'Cód', field: 'pdv_code', align: 'center' },
        {name: 'description', label: 'Descrição', field: 'description', align: 'center' },
        {name: 'pdv_code', label: 'Nota N°', field: 'pdv_code', align: 'center' },
        {name: 'customer_id', label: 'Cód cliente', field: 'customer_id', align: 'center' },
        {name: 'customer', label: 'Cliente', field: 'customer', align: 'center' },
        {name: 'pdv_code', label: 'Documento', field: 'pdv_code', align: 'center' },
        {
            name: 'gross_value', 
            label: 'Total bruto', 
            field: 'gross_value', 
            align: 'center', 
            format: formatVal
        },
        {
            name: 'net_value', 
            label: 'Tota líquido', 
            field: 'net_value', 
            align: 'center', 
            format: formatVal
        },
        { 
            name: 'issue_date', 
            label: 'Data de emissão',
            field: 'issue_date', 
            format(val) {
                const date = dayjs(val);
                return date.format('DD/MM/YYYY')
            },
        },
        {
            name: 'addition', 
            label: 'Acréscimo', 
            field: 'addition', 
            align: 'center', 
            format: formatVal
        },
        {
            name: 'discount', 
            label: 'Desconto R$', 
            field: 'discount', 
            align: 'center', 
            format: formatVal
        },
        {name: 'user_id', label: 'Cód vendedor', field: 'user_id', align: 'center' },
        {name: 'user', label: 'Vendedor', field: 'user', align: 'center' },
        {
            name: 'is_nfce_nm', 
            label: 'Tipo venda', 
            field: 'is_nfce_nm', 
            align: 'center',
            format(val: string){
                return val.toUpperCase();
            },
            
        },
        {name: 'status', label: 'Status da venda', field: 'status', align: 'center' },
        {
            name: 'canceled', 
            label: 'Cancelada', 
            field: 'canceled', 
            align: 'center',
            format(val){
                return val === 1 ? 'Sim' : 'Não'
            }
        },
        {
            name: 'finished', 
            label: 'Finalizada', 
            field: 'finished', 
            align: 'center',
            format(val){
                return val === 1 ? 'Sim' : 'Não'
            }
        }
    ];

    const countErros = ref(0);

    let allPDVs = ref([]);

    function formatVal(val: number | string) 
    {    
        const num = typeof val === 'string' ? parseFloat(val) : val;
        return new Intl.NumberFormat('pt-BR', {
            style: 'currency',
            currency: 'BRL'
        }).format(num);
    };

    const getAllPDVs = async () => {
        const res = await api.get(`/ecommerce/pdv/all/${LocalStorage.getItem("issuer_id")}`);
        allPDVs.value = res.data;
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

<style lang="sass">
.my-sticky-column-table
  /* specifying max-width so the example can
    highlight the sticky column on any browser window */
  max-width: 160vh

  td:first-child
    background-color: #fff

  th:first-child,
  td:first-child
    position: sticky
    left: 0
    z-index: 1

    
</style>