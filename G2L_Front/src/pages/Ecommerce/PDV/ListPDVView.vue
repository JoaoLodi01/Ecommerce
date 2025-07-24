<template>
    <div class="w-[145vh]  mx-auto mt-5 p-6 ml-14 bg-white rounded-lg shadow-lg">
        <div class="flex justify-between items-center mb-6" v-if="showListPDV">
            <h1 
                class="text-2xl font-semibold mt-5"
            >
                Listagem de vendas
                <span class="text-sm">(NFC-e/Nota Manual)</span>
                
                <div class="flex gap-4 mt-2 border p-3 rounded">
                    <div class="flex items-center gap-2 text-xs">
                        <div class="bg-orange-500 h-3 w-3 rounded-full"></div>
                        <span>Canceladas</span>
                    </div>

                    <div class="flex items-center gap-2 text-xs">
                        <div class="bg-green-500 h-3 w-3 rounded-full"></div>
                        <span>Finalizadas</span>
                    </div>
                    
                    <div class="flex items-center gap-2 text-xs">
                        <div class="bg-blue-500 h-3 w-3 rounded-full"></div>
                        <span>Emitidas</span>
                    </div>

                    <div class="flex items-center gap-2 text-xs">
                        <div class="bg-yellow-500 h-3 w-3 rounded-full"></div>
                        <span>Erro</span>
                    </div>
                    
                    <div class="flex items-center gap-2 text-xs">
                        <div class="bg-gray-500 h-3 w-3 rounded-full"></div>
                        <span>Abertas</span>
                    </div>
                </div>
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
                row-key="pdv_code"
            >

                <template v-slot:header="props">
                    <q-tr 
                        :props="props"
                        :style="`background-color: ${painelColor}; color: ${textColor}`"
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

                <template v-slot:body="props">
                    <q-tr
                        :props="props"
                        :class="{
                            'bg-orange-500 text-white': props.row.canceled === 1,
                            'bg-green-400 text-white': props.row.canceled === 0
                        }"
                    >
                        <q-td
                            v-for="col in props.cols"
                            :key="col.name"
                            :props="props"
                        >
                        <!-- Verifica se é a coluna de ações -->
                        <template v-if="col.name === 'actions'">
                            <q-btn dense flat icon="more_vert" class="text-black">
                                <q-menu>
                                    <q-list style="min-width: 120px;" class="text-xs">
                                        <q-item
                                            clickable 
                                            v-close-popup 
                                            class="bg-red-500" 
                                            @click.prevent="!props.row.canceled ? showConfirmFn('cancel/pdv', props.row.pdv_code, props.row.issuer_id) : notifyCanceledPDV()"

                                        >
                                            <q-item-section>
                                            <div class="flex items-center justify-between text-white">
                                                <span>Cancelar</span>
                                                <q-icon name="close" size="xs" />
                                            </div>
                                            </q-item-section>
                                        </q-item>

                                        <q-item clickable v-close-popup class="bg-blue-500">
                                            <q-item-section>
                                                <div class="flex items-center justify-between text-white">
                                                    <span>Visualizar</span>
                                                    <q-icon name="visibility" size="xs" />
                                                </div>
                                                </q-item-section>
                                        </q-item>
                                    </q-list>
                                    </q-menu>
                                </q-btn>
                            </template>

                            <!-- Demais colunas normalmente -->
                            <template v-else>
                                <div class="text-xs">
                                    {{ col.value }}

                                </div>
                            </template>
                        </q-td>
                    </q-tr>
                </template>
            </q-table>
        </div>        
    </div>
        
    <div v-if="showReportPDV">
        <ReportErros
            @close="closeReportErros($event)"
        />
    </div>

    <ConfirmPage
        v-if="showConfirm"
        :operation="typeOperation"
        @confirm="handleOptionsPDV($event)"

    />
    
</template>

<script setup lang="ts">
    import { LocalStorage, QTableColumn, useQuasar } from "quasar";
    import { api } from "src/boot/axios";
    import { onMounted, ref } from 'vue';
    import { useRouter } from "vue-router";
    import dayjs from "dayjs";
    import ReportErros from "src/components/PDV/Errors/ReportErros.vue";
    import ConfirmPage from "src/components/Confirm/ConfirmPage.vue";
    
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
        {name: 'customer_code', label: 'Cód cliente', field: 'customer_code', align: 'center' },
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
    let showConfirm = ref<boolean>(false);
    let typeOperation = ref<string>('');

    let pdvCodeSelected = ref<number>(0);
    let issuerIDSelected = ref<number>(0);

    const notifyCanceledPDV = () =>
    {
        $q.notify({
            icon: 'warning',
            color: 'yellow-14',
            message: 'PDV já cancelado!',
            position: 'top',
            timeout: 1500
        });
    };

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

    const showConfirmFn = (operation: string, pdvCode: number, issuerID: number) => 
    {   
        pdvCodeSelected.value = pdvCode;
        issuerIDSelected.value = issuerID;
        typeOperation.value = operation;
        showConfirm.value = true;
    
    };

    const handleOptionsPDV = async (event: TEmit[]|boolean) =>
    {
        const operation = event[0]['operation'];
        const value = event[0]['value'];

        if(!value)
        {
            $q.notify({ color: 'red', message: 'Operação cancelada!', position: 'top', timeout: 2000 }); 
            showConfirm.value = false;
            return;

        } else {
            try {
                const res = await api.put(`ecommerce/pdv/${operation}/${issuerIDSelected.value}/${pdvCodeSelected.value}`);

                const data = res.data;

                if(data.success)
                {
                    showConfirm.value = false;
                    pdvCodeSelected.value = 0;
                    issuerIDSelected.value = 0;
                       
                    $q.notify({
                        color: 'green',
                        message: data.message,
                        position: 'top',
                        timeout: 2000

                    });
                };
                
            } catch (error) {
                
            };
        };
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