<template>
    <div v-if="!showPage">
        <LoandingPage
            @show-page="showPage = $event"
            :text="'Carregando registros do receber ...'"
                        
        />

    </div>


    <div v-if="showPage"
        class="mt-10 mb-5 p-6 bg-white rounded-lg shadow-lg mx-auto"
        :class="{
            'w-[90%] max-w-[1400px]': true
    }">

        <div class="flex justify-between items-center mb-6">
            <h1 class="text-2xl font-semibold">Receber</h1>
            <div class="flex space-x-4">
                <q-btn 
                    class="p-2 rounded-lg"
                    :style="`background-color: ${buttonColor}; color: ${textColor ?? '#fff'}`"

                >
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor" class="w-6 h-6">
                        <path fill-rule="evenodd" d="M6.455 1.45A.5.5 0 0 1 6.952 1h2.096a.5.5 0 0 1 .497.45l.186 1.858a4.996 4.996 0 0 1 1.466.848l1.703-.769a.5.5 0 0 1 .639.206l1.047 1.814a.5.5 0 0 1-.14.656l-1.517 1.09a5.026 5.026 0 0 1 0 1.694l1.516 1.09a.5.5 0 0 1 .141.656l-1.047 1.814a.5.5 0 0 1-.639.206l-1.703-.768c-.433.36-.928.649-1.466.847l-.186 1.858a.5.5 0 0 1-.497.45H6.952a.5.5 0 0 1-.497-.45l-.186-1.858a4.993 4.993 0 0 1-1.466-.848l-1.703.769a.5.5 0 0 1-.639-.206l-1.047-1.814a.5.5 0 0 1 .14-.656l1.517-1.09a5.033 5.033 0 0 1 0-1.694l-1.516-1.09a.5.5 0 0 1-.141-.656L2.46 3.593a.5.5 0 0 1 .639-.206l1.703.769c.433-.36.928-.65 1.466-.848l.186-1.858Zm-.177 7.567-.022-.037a2 2 0 0 1 3.466-1.997l.022.037a2 2 0 0 1-3.466 1.997Z" clip-rule="evenodd" />
                    </svg>
                </q-btn>

                <q-btn
                    class="p-2 rounded-lg"
                    :style="`background-color: ${buttonColor}; color: ${textColor ?? '#fff'}`"
                    label="Relatórios"
                />

                <q-btn
                    class="p-2 rounded-lg"
                    :style="`background-color: ${buttonColor}; color: ${textColor ?? '#fff'}`"
                    @click="manageClick(0, 'register', false)"
                    label="Cadastrar"
                />

            </div>
        </div>

        <div class="filterDate flex justify-start mb-6 p-4 border border-gray-300 rounded-lg w-max">
            <q-input
                class="mr-10 cursor-text"
                type="date"
                @keydown="dateSearch()"
                v-model="startDate"
                label="Data Inicial"
            />

            <q-input
                class="cursor-pointer"
                @keydown="dateSearch()"
                type="date"
                v-model="endDate"
                label="Data Final"
            />

            <q-btn
                class="transition text-white ml-5 h-max mb-auto mt-auto rounded-lg"
                :style="`background-color: ${buttonColor}; color: ${textColor ?? '#fff'}`"
                label="Filtrar"
                @click="dateSearch()"
            />

            <div class="flex gap-4 border rounded p-3 w-max ml-10">
                <div>
                    <q-option-group
                        v-model="filterTypeReceives"
                        type="radio"
                        toggle
                        class="flex text-xs"
                        :options="[
                            {label: 'Todas', value: 'all'},
                            {label: 'Em Aberto', value: 'aberto'},
                            {label: 'Vencidas', value: 'vencidas'},
                            {label: 'Quitadas', value: 'quitadas'},
                            {label: 'Atrasadas', value: 'atrasadas'},
                        ]"
                    />    

                </div>
            </div>
        </div>

        <div class="flex flex-col md:flex-row md:justify-between gap-4 items-center border p-3 rounded-lg mb-4 mx-auto w-full">
            <!-- Legenda  -->
            <div class="flex gap-4">
            <div class="flex items-center gap-2 text-xs">
                <div class="bg-black h-3 w-3 rounded-full"></div>
                <span>Em Aberto</span>
            </div>

            <div class="flex items-center gap-2 text-xs">
                <div class="bg-green-500 h-3 w-3 rounded-full"></div>
                <span>Quitadas</span>
            </div>

            <div class="flex items-center gap-2 text-xs">
                <div class="bg-blue-500 h-3 w-3 rounded-full"></div>
                <span>Quitada com atraso</span>
            </div>

            <div class="flex items-center gap-2 text-xs">
                <div class="bg-orange-500 h-3 w-3 rounded-full"></div>
                <span>Canceladas</span>
            </div>

            <div class="flex items-center gap-2 text-xs">
                <div class="bg-red-500 h-3 w-3 rounded-full"></div>
                <span>Atrasadas</span>
            </div>
            </div>

            <!-- Totalizadores -->
            <div class="flex gap-4">
            <span class="border rounded px-3 py-1 bg-green-200 text-green-900">
                <q-icon name="check_circle" color="green-700" class="mr-2" />
                Recebidas: R$ {{ totalQuitadas }}
            </span>

            <span class="border rounded px-3 py-1 bg-yellow-200 text-yellow-900">
                <q-icon name="hourglass_empty" color="orange" />
                Pendentes: R$ {{ totalEmAberto }}
            </span>

            <span class="border rounded px-3 py-1 bg-red-300 text-red-900">
                <q-icon name="warning" color="red" />
                Atrasadas ( + juros ): R$ {{ totalVencidas }}
            </span>
            </div>
        </div>

        <div>
            <q-table
                :rows="receives"
                :columns="columns"
                row-key="receiveCod"
                flat
                bordered
                class="q-mt-md shadow-lg rounded-lg"
                >

                <template v-slot:header="props">
                    <q-tr :props="props" :style="`background-color: ${painelColor}; color: white;`">
                    <q-th
                        v-for="col in props.cols"
                        :key="col.name"
                        :props="props"
                        :class="`text-${col.align}`">

                        {{ col.label }}
                    </q-th>
                    </q-tr>
                </template>

                <template v-slot:body="props">
                    <q-tr :props="props" :class="getColorReceive(props.row)">
                        <q-td key="document" :props="props" class="text-left">
                        {{ props.row.document }}
                        </q-td>

                        <q-td key="description" :props="props" class="text-left">
                        {{ props.row.description }}
                        </q-td>

                        <q-td key="installmentAmount" :props="props" class="text-center">
                        {{ props.row.installmentAmount }}
                        </q-td>

                        <q-td key="installmentNumber" :props="props" class="text-center">
                        {{ props.row.installmentNumber }}
                        </q-td>

                        <q-td key="installmentValue" :props="props" class="text-right">
                        R$ {{ Number(props.row.installmentValue).toFixed(2) }}
                        </q-td>

                        <q-td key="installmentPaid" :props="props" class="text-right">
                        R$ {{ Number(props.row.installmentPaid).toFixed(2) }}
                        </q-td>

                        <q-td key="name" :props="props" class="text-left">
                        {{ props.row.name }}
                        </q-td>

                        <q-td key="dueDate" :props="props" class="text-center">
                        {{ props.row.dueDate }}
                        </q-td>

                        <q-td key="especie" :props="props" class="text-center">
                        {{ props.row.especie.toUpperCase() }}
                        </q-td>

                        <q-td key="status" :props="props" class="text-center">
                        <q-badge
                            :color="getStatusBadge(props.row).color"
                            text-color="white"
                            class="text-xs"
                            outline
                            :label="getStatusBadge(props.row).label"
                            :icon="getStatusBadge(props.row).icon"
                        />
                        </q-td>

                        <q-td key="actions" :props="props" class="text-center">
                        <q-btn
                            @click="manageClick(props.row.receiveCod, 'update', false)"
                            icon="edit"
                            color="green"
                            size="sm"
                            class="q-mr-xs"
                        />
                        <q-btn
                            @click="manageClick(props.row.receiveCod, 'view', true)"
                            icon="visibility"
                            color="blue"
                            size="sm"
                            class="q-mr-xs"
                        />
                        <q-btn icon="more_vert" size="sm">
                            <q-menu>
                            <q-list>
                                <!-- ... opções do menu ... -->
                            </q-list>
                            </q-menu>
                        </q-btn>
                        </q-td>
                    </q-tr>
                    </template>
            </q-table>
        </div>

        <div
            v-if="showReceiveClosing"
            class="fixed inset-0 z-50 flex items-center justify-center bg-opacity-40 backdrop-blur-sm">

            <div class="bg-white border border-gray-400 rounded-xl">
                <RegisterReceive 
                    :receives="receives"
                    :action="selectOperation"
                    :readonly="selectReadonly"
                    @close="closeRegister($event)"
                    :width-screen="widthScreen"
                    :receive-cod="selectedReceiveCod"
                    :selected-register="selectedRegister"
                />
            </div>
        </div>
    </div>
</template>

<script setup lang="ts">
import dayjs from 'dayjs';
    import { QTableColumn } from "quasar";
    import { api } from "src/boot/axios";
    import { useQuasar } from "quasar";
    import { ref, onMounted, computed } from "vue";
    import { LocalStorage } from "quasar";
    import isBetween from 'dayjs/plugin/isBetween';
    import camelcaseKeys from "camelcase-keys";
    import LoandingPage from "src/components/Loanding/LoandingPage.vue";
    import RegisterReceive from "src/components/Register/Financial/RegisterReceive.vue";
    dayjs.extend(isBetween);

    const today = dayjs();
    const $q = useQuasar();
    const loading = ref(false);
    const issuerID = ref<number>(LocalStorage.getItem("issuer_id"));
    const textColor = ref<string>(LocalStorage.getItem("textColor"));
    const buttonColor = ref<string>(LocalStorage.getItem("buttonColor"));
    const painelColor = ref<string>(LocalStorage.getItem("painelColor"));
    const filterTypeReceives = ref<'all' | 'aberto' | 'vencidas' | 'quitadas' | 'atrasadas'>('all');

    let selectOperation = ref<string>('');
    let selectReadonly = ref<boolean>(false);
    let selectedReceiveCod = ref<number>(0);
    let selectedRegister = ref<IReceiveBody | null>(null);
    let receives = ref<IReceiveBody[]>([]);
    let startDate = ref<string>(today.startOf('month').format('YYYY-MM-DD'));
    let endDate = ref<string>(today.endOf('month').format('YYYY-MM-DD'));
    let widthScreen = ref<number>(0);
    let showReceiveClosing = ref<boolean>(false);
    let showPage = ref<boolean>(false);

    const getRegister = async () => {
        loading.value = true;
        try {
            const res = await api.get(`/ecommerce/receive/all/${issuerID.value}`);
            receives.value = camelcaseKeys(res.data.data, { deep: true });
        } catch (error) {
            $q.notify({ color: 'red', message: 'Erro ao carregar dados' });
        } finally {
            loading.value = false;
        }
    }
    
    const dateSearch = () => {};
    //#region Q-TABLE
    const columns: QTableColumn[] = [
        { name: 'document', label: 'Documento', field: 'document', align: 'left' },
        { name: 'description', label: 'Descrição', field: 'description', align: 'left' },
        { name: 'installmentAmount', label: 'Qtde Parcela', field: 'installmentAmount', align: 'center' },
        { name: 'installmentNumber', label: 'Nº Parcela', field: 'installmentNumber', align: 'center' },
        { name: 'installmentValue', label: 'Valor Bruto', field: row => `R$ ${row.installmentValue.toFixed(2)}`, align: 'right' },
        { name: 'installmentPaid', label: 'Valor Líquido', field: row => `R$ ${row.installmentPaid.toFixed(2)}`, align: 'right' },
        { name: 'name', label: 'Cliente', field: 'name', align: 'left' },
        { name: 'dueDate', label: 'Data Vencimento', field: 'dueDate', align: 'center' },
        { name: 'especie', label: 'Espécie', field: row => row.especie.toUpperCase(), align: 'center' },
        { name: 'status', label: 'Status', field: row => row.status.toUpperCase(), align: 'center' },
        { name: 'actions', label: 'Ações', field: 'actions', align: 'center' }
    ];

    const getStatusBadge = (row: IReceiveBody) => {
        const isPaid = row.paid;
        const isLatePayment = isPaid && isLate(row.dueDate);
        const isVencida = !isPaid && isLate(row.dueDate);
        const isCancelada = row.status === 'cancelada';

        if (isCancelada) {
            return { label: 'Cancelada', color: 'orange', icon: 'cancel' };
        } else if (isPaid && isLatePayment) {
            return { label: 'Quitada com atraso', color: 'blue', icon: 'schedule' };
        } else if (isPaid) {
            return { label: 'Quitada', color: 'green', icon: 'check_circle' };
        } else if (isVencida) {
            return { label: 'Atrasada', color: 'red', icon: 'warning' };
        } else {
            return { label: 'Em Aberto', color: 'grey', icon: 'hourglass_empty' };
        }
    };

    const getColorReceive = (row: IReceiveBody): string => {
        const isPaid = row.paid;
        const isVencida = dayjs(row.dueDate).isBefore(dayjs(), 'day');
        const isCancelada = row.status === 'cancelada';

        if(isCancelada) return 'text-orange-600';
        if(isPaid && isVencida) return 'text-blue-600';
        if(isPaid && !isVencida) return 'texte-green-600';
        if (!isPaid && isVencida) return 'text-red-600';
        return 'text-black';
    };
    //#endregion
    const manageClick = (receiveCod: number, action: string, readonly: boolean) => {
        selectedReceiveCod.value = receiveCod;
        selectOperation.value = action;
        selectReadonly.value = readonly;
        showReceiveClosing.value = true;
        selectedRegister.value = receives.value.find(r => r.receiveCod === receiveCod) || null;
    };
    
    const closeRegister = (event: boolean) =>
    {
        showReceiveClosing.value = event;
        if (!event) {
            getRegister();
        }
    };

    const totalQuitadas = computed(() => 
        receives.value.reduce((acc, r) => acc + (r.paid ? r.installmentValue : 0), 0)
    );

    const totalVencidas = computed(() => 
        receives.value.reduce((acc, r) => {
            const vencida = !r.paid && dayjs(r.dueDate).isBefore(dayjs(), 'day');
            return acc + (vencida ? r.installmentValue : 0);
        }, 0)
    );

    const totalEmAberto = computed(() => {
        const total = receives.value
            .filter(inst => !inst.paid && !isLate(inst.dueDate))
            .reduce((sum, inst) => sum + Number(inst.installmentValue || 0), 0);

        return total.toFixed(2);
    });

    const isLate = (dueDate: string): boolean => {
        return dayjs(dueDate).isBefore(dayjs(), 'day');
    };
    
    const parseCurrency = (value: number): number =>
    {
        if (!value) return 0;

        return parseFloat(
            value
            .toString()
            .replace(/\s/g, '')
            .replace('R$', '')
            .replace(/\./g, '')
            .replace(',', '.')
        ) || 0;
    };

    onMounted(() => {
        getRegister();
        widthScreen.value = screen.width;
        
    });

</script>

<style scoped>
    .container {
        max-width: 85%;
        width: 100%;
        height: 90vh;
    }


    button {
        transition: background-color 0.3s ease;
    }

    button:hover {
        background-color: #4b5563;
    }

    @media (max-width: 768px) {
        table {
            font-size: 0.875rem;
        }

        th, td {
            padding: 0.5rem;
        }

        .to-receive-register-grid
        {
            height: 65vh;
            max-height: 90vh;
        }
    }
</style>