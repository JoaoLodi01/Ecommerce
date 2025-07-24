<template>
    <div v-if="!showPage">
        <LoandingPage
            @show-page="showPage = $event"
            :text="'Carregando registros do receber ...'"
                        
        />

    </div>


    <div 
        v-if="showPage" 
        class="h-[95vh] mx-auto mt-5 p-6 ml-14 bg-white rounded-lg shadow-lg"
        :class="{
            'mt-10 p-6 ml-16 mb-5 bg-white rounded-lg shadow-lg w-[150vh]': widthScreen > 1366,
            'mt-10 ml-14 mr-6 mb-5 bg-white rounded-lg shadow-lg w-[120vh]': widthScreen <= 1680
            
        }"  
    >
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
        </div>

        <div class="flex justify-between mb-6 p-4 border border-gray-300 rounded-lg">
            <div><p>Total Quitadas: <span class="font-semibold">R${{ totalQuitadas }}</span></p></div>

            <div><p>Total Vencidas: <span class="font-semibold">R${{ totalVencidas }}</span></p></div>

            <div><p>Total Em aberto: <span class="font-semibold">R${{ totalEmAberto }}</span></p></div>
        </div>

        <div class="to-receive-register-grid relative overflow-y-auto border rounded-lg shadow-lg">
            <table class="table-auto border-collapse border border-gray-300 bg-white ">
                <thead class="font-semibold sticky top-0 z-10">
                    <tr 
                        class="text-white"
                        :style="`background-color: ${painelColor}; color: ${textColor}`"
                    >
                        <th scope="col" class="text-center px-6 py-3">Documento</th>
                        <th class="px-6 py-3 text-center">Descrição</th>
                        <th class="px-6 py-3 text-center">Qtde Parcela</th>
                        <th class="px-6 py-3 text-center">Valor</th>
                        <th class="px-6 py-3 text-center">Cliente</th>
                        <th class="px-6 py-3 text-center">Cód. Espécie</th>
                        <th class="px-6 py-3 text-center">Espécie</th>
                        <th class="px-6 py-3 text-center">Origem</th>
                        <th class="px-6 py-3 text-center">Ações</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(register, id) in receives" :key="register.receiveCod" class="border-t text-center">
                        <td class="px-6 py-3 text-center">{{ register.document }}</td>
                        <td class="px-6 py-3 text-center">{{ register.description }}</td>
                        <td class="px-6 py-3 text-center">{{ register.installmentNumber }}</td>
                        <td class="px-6 py-3 text-center">{{ register.installmentValue }}</td>
                        <td class="px-6 py-3 text-center">{{ register.name }}</td>
                        <td class="px-6 py-3 text-center">{{ register.especieID }}</td>
                        <td class="px-6 py-3 text-center">{{ register.especie.toUpperCase() }}</td>
                        <td class="px-6 py-3 text-center">{{ register.origem.toUpperCase() }}</td>
                        <td class="px-6 py-3 text-center">
                            <q-btn
                                @click="manageClick(register.receiveCod, 'update', false)"
                                icon="edit"
                                color="green"
                                class="mr-1"
                                size="sm"
                            />
                            
                            <q-btn 
                                @click="manageClick(register.receiveCod, 'view', true)"
                                icon="visibility"
                                color="blue"
                                class="mr-1"
                                size="sm"
                            />

                            <q-btn icon="more_vert" size="sm">
                                <q-menu>
                                    <q-list style="min-width: 100px">
                                        <q-item clickable v-close-popup>
                                            <q-item-section>Imprimir (A4)</q-item-section>
                                        </q-item>
                                        <q-item clickable v-close-popup>
                                            <q-item-section>Térmica (80mm)</q-item-section>
                                        </q-item>
                                        <q-item clickable v-close-popup>
                                            <q-item-section>Desfazer quitação</q-item-section>
                                        </q-item>
                                    </q-list>
                                </q-menu>
                            </q-btn>
                        </td>
                    </tr>
                </tbody>
            </table>
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
    import { api } from "src/boot/axios";
    import { useQuasar } from "quasar";
    import { ref, onMounted, computed } from "vue";
    import { LocalStorage } from "quasar";
    import RegisterReceive from "src/components/Register/Financial/RegisterReceive.vue";
    import LoandingPage from "src/components/Loanding/LoandingPage.vue";
    import dayjs from 'dayjs';
    import isBetween from 'dayjs/plugin/isBetween';
    import camelcaseKeys from "camelcase-keys";
    dayjs.extend(isBetween);

    const today = dayjs();
    const $q = useQuasar();
    const loading = ref(false);
    const issuerID = ref<number>(LocalStorage.getItem("issuer_id"));
    const buttonColor = ref<string>(LocalStorage.getItem("buttonColor"));
    const painelColor = ref<string>(LocalStorage.getItem("painelColor"));
    const textColor = ref<string>(LocalStorage.getItem("textColor"));

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
            const vencida = !r.paid && dayjs(r.dueDate).isBefore(dayjs());
            return acc + (vencida ? r.installmentValue : 0);
        }, 0)
    );

    const totalEmAberto = computed(() => 
        receives.value.reduce((acc, r) => {
            const emAberto = !r.paid && !dayjs(r.dueDate).isBefore(dayjs());
            return acc + (emAberto ? r.installmentValue : 0);
        }, 0)
    );
        
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

    table {
        width: 100%;
        border-collapse: collapse;
    }

    thead {
        background-color: #f3f4f6;
    }

    tbody tr:hover {
        background-color: #f9fafb;
    }

    th, td {
        padding: 0.75rem;
        text-align: left;
    }

    th {
        font-weight: bold;
        text-transform: uppercase;
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