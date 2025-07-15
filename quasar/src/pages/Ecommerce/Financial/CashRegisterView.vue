<template>
    <div class="container mx-auto mt-5 p-6 ml-16 bg-white rounded-lg shadow-lg">
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
                    label="Cadastrar"
                />

                <q-btn
                    class="p-1 mr-5 rounded-lg"
                    :style="`background-color: ${buttonColor}; color: ${textColor ?? '#fff'}`"
                    @click="getRegister()"
                    label="Atualizar caixa"
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

            <div class="flex">
                <div class="">
                    <span class="h-2 w-2 bg-red-600 mr-2"></span>
                    <span class="h-2 w-2 bg-red-600"></span>
                </div>
            </div>
        </div>

        <div class="flex justify-between mb-6 p-4 border border-gray-300 rounded-lg">
            <div><p>Total de entrada: <span class="font-semibold">R${{ inputTotal }}</span></p></div>

            <div><p>Total de saída: <span class="font-semibold">R${{ outputTotal }}</span></p></div>

            <div><p>Saldo total: <span class="font-semibold">R${{ total }}</span></p></div>
            
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
                        <td scope="row" class="text-center ml-4 px-6 py-3">{{ register.cash_register_cod }}</td>
                        <td scope="row" class="text-center ml-4 px-6 py-3">{{ register.document }}</td>
                        <td scope="row" class="text-center ml-4 px-6 py-3">{{ register.description }}</td>
                        <td scope="row" class="text-center ml-4 px-6 py-3">R$ {{ register.input_value }}</td>
                        <td scope="row" class="text-center ml-4 px-6 py-3">R$ {{ register.output_value }}</td>
                        <td scope="row" class="text-center ml-4 px-6 py-3">R$ {{ register.real_balance }}</td>
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
                            <q-btn @click="transferRegister()" class="text-blue-600 hover:text-blue-100">
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none"
                                    viewBox="0 0 24 24" stroke-width="1.5"
                                    stroke="currentColor" class="w-6 h-6 mx-auto">
                                    <path stroke-linecap="round" stroke-linejoin="round"
                                        d="M12 21v-8.25M15.75 21v-8.25M8.25 21v-8.25M3 9l9-6 9 6m-1.5 12V10.332
                                        A48.36 48.36 0 0 0 12 9.75c-2.551 0-5.056.2-7.5.582V21M3 21h18
                                        M12 6.75h.008v.008H12V6.75Z" />
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
    let filteredCashs = [];

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
        width: 100%;
        height: 95vh;
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