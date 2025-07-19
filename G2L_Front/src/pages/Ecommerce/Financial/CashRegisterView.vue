<template>
    <div v-if="!showPage">
        <LoandingPage
            @show-page="showPage = $event"
            :text="'Carregando registros do caixa ...'"
                        
        />

    </div>

    <div v-if="showPage" class="w-[165vh] mx-auto mt-5 p-6 ml-14 bg-white rounded-lg shadow-lg">
        <div class="flex justify-between items-center mb-6">
            <h2 class="text-2xl font-semibold">Caixa</h2>
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
                    class="p-1 mr-5 rounded-lg"
                    :style="`background-color: ${buttonColor}; color: ${textColor ?? '#fff'}`"
                    @click="showRegister()"
                    label="Registrar movimento no caixa"
                />                
            </div>
        </div>
        
        <div class="filterDate inline-flex w-max">
            <div class="flex mb-6 p-4 border border-gray-300 rounded-lg ">
                <q-input
                    class="mr-10 cursor-text"
                    type="date"
                    v-model="startDate"
                    label="Data Inicial"
                />

                <q-input
                    class="cursor-pointer"
                    type="date"
                    v-model="endDate"
                    label="Data Final"
                />

                <q-btn
                    class="ml-5 h-max mb-auto mt-auto rounded-lg"
                    :style="`background-color: ${buttonColor}; color: ${textColor ?? '#fff'}`"
                    label="Filtrar"
                    @click="dateSearch()"
                />
            </div>

            <div class="border border-black">
                <div class="flex">
                    <span class="h-4 w-4 bg-red-600 mr-2"></span>
                    <span class="h-4 w-4 bg-red-600"></span>
                </div>
            </div>
        </div>

        <div class="flex justify-between mb-6 p-4 border border-gray-300 rounded-lg">
            <div><p>Total de entrada: <span class="font-semibold">R${{ String(inputTotal.toFixed(2)).replace('.', ',') }}</span></p></div>

            <div><p>Total de saída: <span class="font-semibold">R${{ String(outputTotal.toFixed(2)).replace('.', ',') }}</span></p></div>

            <div><p>Saldo total: <span class="font-semibold">R${{ String(total.toFixed(2)).replace('.', ',') }}</span></p></div>
            
        </div>

        <div class="cash-register-grid relative overflow-y-auto border rounded-lg shadow-lg">
            <table class="table-auto border-collapse border border-gray-300 bg-white ">
                <thead class="font-semibold sticky top-0 z-10">
                    <tr 
                        class="text-white"
                        :style="`background-color: ${painelColor}; color: ${textColor}}`"
                    >
                        <th scope="col" class="text-center px-6 py-3">Código</th>
                        <th scope="col" class="text-center px-6 py-3">Documento</th>
                        <th scope="col" class="px-6 py-3">Descrição</th>
                        <th scope="col" class="px-6 py-3">Valor entrada</th>
                        <th scope="col" class="px-6 py-3">Valor saída</th>
                        <th scope="col" class="px-6 py-3">Saldo</th>
                        <th scope="col" class="px-6 py-3">Cliente</th>
                        <th scope="col" class="px-6 py-3">Cód Espécie</th>
                        <th scope="col" class="px-6 py-3">Espécie</th>
                        <th scope="col" class="px-6 py-3">Origem</th>
                        <th scope="col" class="px-6 py-3">Tipo</th>
                        <th scope="col" class="px-6 py-3">Ações</th>
                    </tr>
                </thead>
                <tbody>
                    <tr
                        class="border-b border-gray-200"
                        v-for="(register, id) in cashs"
                        :key="id"
                    >
                        <td scope="row" class="text-center ml-4 px-6 py-3">{{ register.cash_register_code }}</td>
                        <td scope="row" class="text-center ml-4 px-6 py-3">{{ register.document }}</td>
                        <td scope="row" class="text-center ml-4 px-6 py-3">{{ register.description }}</td>
                        <td scope="row" class="text-center ml-4 px-6 py-3">R$ {{ String(register.input_value).replace('.', ',') }}</td>
                        <td scope="row" class="text-center ml-4 px-6 py-3">R$ {{ String(register.output_value).replace('.', ',') }}</td>
                        <td scope="row" class="text-center ml-4 px-6 py-3">R$ {{ String(register.real_balance).replace('.', ',') }}</td>
                        <td scope="row" class="text-center ml-4 px-6 py-3">{{ register.name }}</td>
                        <td scope="row" class="text-center ml-4 px-6 py-3">{{ register.especie_cod }}</td>
                        <td scope="row" class="text-center ml-4 px-6 py-3">{{ register.especie }}</td>
                        <td scope="row" class="text-center ml-4 px-6 py-3">{{ register.origem.toUpperCase() }}</td>
                        <td scope="row" class="text-center ml-4 px-6 py-3">
                        <span class="w-[80px] px-4 py-2 rounded-xl text-white text-sm font-medium text-center inline-block"
                            :class="{
                                'bg-green-500': register.input_value > 0,
                                'bg-red-500': register.input_value < 1
                            }"
                        >
                            {{ register.input_value > 0 ? 'Entrada' : 'Saída' }}
                        </span>
                        </td>
                        <td scope="row" class="text-center ml-4 px-6 py-3">
                            <q-btn @click="transferRegister()">
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="m16.862 4.487 1.687-1.688a1.875 1.875 0 1 1 2.652 2.652L10.582 16.07a4.5 4.5 0 0 1-1.897 1.13L6 18l.8-2.685a4.5 4.5 0 0 1 1.13-1.897l8.932-8.931Zm0 0L19.5 7.125M18 14v4.75A2.25 2.25 0 0 1 15.75 21H5.25A2.25 2.25 0 0 1 3 18.75V8.25A2.25 2.25 0 0 1 5.25 6H10" />
                                </svg>

                            </q-btn>
                        </td>
                    </tr>
                </tbody>
            </table>

            <div
                v-if="showCashClosing"
                class="fixed inset-0 z-50 flex items-center justify-center bg-opacity-40 backdrop-blur-sm">

                <div 
                    class="bg-white border border-black rounded-xl"
                
                >
                    <RegisterCash
                        @close="closeRegister($event)"
                        :width-screen="withScreen"
                    />
                </div>
            </div>

        </div>
    </div>
</template>

<script setup lang="ts">
    import { api } from "src/boot/axios";
    import { useQuasar } from "quasar";
    import { ref, onMounted } from "vue";
    import dayjs from 'dayjs';
    import isBetween from 'dayjs/plugin/isBetween';
    import RegisterCash from "src/components/Register/Financial/RegisterCash.vue";
    import LoandingPage from "src/components/Loanding/LoandingPage.vue";
    import { LocalStorage } from 'quasar';
    
    dayjs.extend(isBetween);

    const $q = useQuasar()
    const today = dayjs();
    const buttonColor = LocalStorage.getItem("buttonColor");
    const painelColor = LocalStorage.getItem("painelColor");
    const textColor = LocalStorage.getItem("textColor");

    let cashs = ref<ICashBody[]>([]);
    let withScreen = ref<number>(0);
    let inputTotal = ref<number>(0);
    let outputTotal = ref<number>(0);
    let total = ref<number>(0);
    let showCashClosing = ref<boolean>(false);
    let startDate = today.startOf('month').format('YYYY-MM-DD');
    let endDate = today.endOf('month').format('YYYY-MM-DD');
    let showPage = ref<boolean>(false);

    const getRegister = async () =>
    {
        const res = await api.get(`/ecommerce/cash-register/all/${LocalStorage.getItem("issuer_id")}`)
        const data = res.data.data; /* camelcaseKeys(, { deep: true });*/
        cashs.value = data;

        cashs.value.map((cash: ICashBody) => {
            inputTotal.value += Number(cash.input_value);
            outputTotal.value += Number(cash.output_value);

        });

        total.value = inputTotal.value - outputTotal.value

        console.log(data);
    };

    const dateSearch = () =>
    {
        
    };

    const showRegister = () => 
    {
        showCashClosing.value = true;
    };

    const closeRegister = (event: boolean) => 
    {
        getRegister();
        showCashClosing.value = event;
    };

    const transferRegister = () =>
    {

    }

    onMounted(async () => {
        await getRegister();
        withScreen.value = screen.width;

    });
</script>

<style scoped>
    .container {
        max-width: 85%;
        
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
    }

    @media(min-width: 1366px)
    {
        .cash-register-grid
        {
            height: 65vh;
            max-height: 90vh;
        }
    }
</style>