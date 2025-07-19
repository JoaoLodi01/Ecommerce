<template>
    <div v-if="!showPage">
        <LoandingPage
            @show-page="showPage = $event"
            :text="'Carregando registros do pagar ...'"
                        
        />

    </div>


    <div v-if="showPage" class="w-[165vh] h-[95vh] mx-auto mt-5 p-6 ml-14 bg-white rounded-lg shadow-lg">
        <div class="flex justify-between items-center mb-6">
            <h1 class="text-2xl font-semibold">Pagar</h1>
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
                    @click="showRegister()"
                    label="Cadastrar"
                />

                <q-btn
                    class="p-2 rounded-lg"
                    :style="`background-color: ${buttonColor}; color: ${textColor ?? '#fff'}`"
                    @click="getRegister()"
                    label="Atualizar pagar"

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
            <div><p>Total Quitadas: <span class="font-semibold">R${{ '0.00' }}</span></p></div>

            <div><p>Total Vencidas: <span class="font-semibold">R${{ '0.00' }}</span></p></div>

            <div><p>Total Em aberto: <span class="font-semibold">R${{ '0.00' }}</span></p></div>
        </div>

        <div class="overflow-x-auto">
            <table class="table-auto border-collapse border border-gray-300 bg-white ">
                <thead class="font-semibold sticky top-0 z-10">
                    <tr 
                        class="text-white"
                        :style="`background-color: ${painelColor}; color: ${textColor}}`"
                    >
                        <th class="px-6 py-3 text-left">Controle</th>
                        <th class="px-6 py-3 text-left">Documento</th>
                        <th class="px-6 py-3 text-left">Descrição</th>
                        <th class="px-6 py-3 text-left">Valor entrada</th>
                        <th class="px-6 py-3 text-left">Cliente</th>
                        <th class="px-6 py-3 text-left">Cód. Espécie</th>
                        <th class="px-6 py-3 text-left">Espécie</th>
                        <th class="px-6 py-3 text-left">Origem</th>
                        <th class="px-6 py-3 text-left">Ações</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(register, id) in cashs" :key="id" class="border-t">
                        <td class="px-6 py-3 text-center">{{ register.toPayCode }}</td>
                        <td class="px-6 py-3 text-center">{{ register.document }}</td>
                        <td class="px-6 py-3">{{ register.description }}</td>
                        <td class="px-6 py-3 text-center">{{ register.installmentValue }}</td>
                        <td class="px-6 py-3 text-center">{{ register.name }}</td>
                        <td class="px-6 py-3 text-center">{{ register.especieID }}</td>
                        <td class="px-6 py-3">{{ register.especie }}</td>
                        <td class="px-6 py-3">{{ register.origem.toUpperCase() }}</td>
                        <td class="px-6 py-3">
                            <q-btn @click="editRegister(register)" class="">
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="m16.862 4.487 1.687-1.688a1.875 1.875 0 1 1 2.652 2.652L10.582 16.07a4.5 4.5 0 0 1-1.897 1.13L6 18l.8-2.685a4.5 4.5 0 0 1 1.13-1.897l8.932-8.931Zm0 0L19.5 7.125M18 14v4.75A2.25 2.25 0 0 1 15.75 21H5.25A2.25 2.25 0 0 1 3 18.75V8.25A2.25 2.25 0 0 1 5.25 6H10" />
                                </svg>
                            </q-btn>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div
            v-if="showPayClosing"
            class="fixed inset-0 z-50 flex items-center justify-center bg-opacity-10 backdrop-blur-sm">

            <div class="bg-white border border-black rounded-xl">
                <RegisterPay 
                    @close="closeRegister($event)"
                    :width-screen="withScreen"
                />
            </div>
        </div>
    </div>
</template>

<script setup lang="ts">
    import { api } from "src/boot/axios";
    import { useQuasar } from "quasar";
    import { ref, onMounted } from "vue";
    import { LocalStorage } from "quasar";
    import dayjs from 'dayjs';
    import isBetween from 'dayjs/plugin/isBetween';
    import LoandingPage from "src/components/Loanding/LoandingPage.vue";
    
    dayjs.extend(isBetween);

    const $q = useQuasar();
    const today = dayjs();
    const cashs = ref<IPayBody[]>([]);
    const issuerID = ref<number>(LocalStorage.getItem("issuer_id"));
    const buttonColor = LocalStorage.getItem("buttonColor");
    const textColor = LocalStorage.getItem("textColor");
    const painelColor = LocalStorage.getItem("painelColor");

    let startDate = today.startOf('month').format('YYYY-MM-DD');
    let endDate = today.endOf('month').format('YYYY-MM-DD');
    let withScreen = ref<number>(0);
    let showPage = ref<boolean>(false);
    let showPayClosing = ref<boolean>(false);
    
    const getRegister = async() =>
    {
        try {
            const response = await api.get(`ecommerce/pay/all/${issuerID.value}`);
            cashs.value = response.data.data;

        } catch (error) {
            console.error("Erro ao buscar registros:", error)
            
        }
    };

    const dateSearch = () =>
    {
        
    };  

    const showRegister = () =>
    {
        showPayClosing.value = true;
    };

    const closeRegister = (event) =>
    { 
        showPayClosing.value = event;

    };

    const editRegister = (register) =>
    {

    };

    onMounted(() => {
        getRegister();
        withScreen.value = screen.width;
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
    }
</style>