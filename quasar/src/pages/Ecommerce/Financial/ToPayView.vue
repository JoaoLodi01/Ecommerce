<template>
    <div class="container mx-auto mt-10 p-6 ml-16 bg-white rounded-lg shadow-lg">
        <div class="flex justify-between items-center mb-6">
            <h2 class="text-2xl font-semibold">Pagar</h2>
            <div class="flex space-x-4">
                <button class="bg-blue-500 text-white p-2 rounded-lg">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor" class="w-6 h-6 mr-2">
                        <path fill-rule="evenodd" d="M6.455 1.45A.5.5 0 0 1 6.952 1h2.096a.5.5 0 0 1 .497.45l.186 1.858a4.996 4.996 0 0 1 1.466.848l1.703-.769a.5.5 0 0 1 .639.206l1.047 1.814a.5.5 0 0 1-.14.656l-1.517 1.09a5.026 5.026 0 0 1 0 1.694l1.516 1.09a.5.5 0 0 1 .141.656l-1.047 1.814a.5.5 0 0 1-.639.206l-1.703-.768c-.433.36-.928.649-1.466.847l-.186 1.858a.5.5 0 0 1-.497.45H6.952a.5.5 0 0 1-.497-.45l-.186-1.858a4.993 4.993 0 0 1-1.466-.848l-1.703.769a.5.5 0 0 1-.639-.206l-1.047-1.814a.5.5 0 0 1 .14-.656l1.517-1.09a5.033 5.033 0 0 1 0-1.694l-1.516-1.09a.5.5 0 0 1-.141-.656L2.46 3.593a.5.5 0 0 1 .639-.206l1.703.769c.433-.36.928-.65 1.466-.848l.186-1.858Zm-.177 7.567-.022-.037a2 2 0 0 1 3.466-1.997l.022.037a2 2 0 0 1-3.466 1.997Z" clip-rule="evenodd" />
                    </svg>
                </button>
                <button 
                    class="bg-blue-500 text-white p-1 mr-5 rounded-lg"
                    @click="showRegister()"
                    >Cadastrar
                </button>
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
                class="bg-blue-500 text-white ml-5 h-max mb-auto mt-auto rounded-lg"
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
            <table class="min-w-full table-auto border-collapse border border-gray-200">
                <thead class="bg-gray-100">
                    <tr>
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
                        <td class="px-6 py-3 text-center">{{ register.id }}</td>
                        <td class="px-6 py-3 text-center">{{ register.id }}</td>
                        <td class="px-6 py-3">{{ register.description }}</td>
                        <td class="px-6 py-3 text-center">{{ register.installment_value }}</td>
                        <td class="px-6 py-3 text-center">{{ register.name }}</td>
                        <td class="px-6 py-3 text-center">{{ register.especie_id }}</td>
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

<script>
    import { api } from "src/boot/axios";
    import RegisterPay from "src/components/Register/Financial/RegisterPay.vue";
    import dayjs from 'dayjs';
    import isBetween from 'dayjs/plugin/isBetween';
    dayjs.extend(isBetween);

    export default {
    data(){
        const today = dayjs();
        
        return{
            cash:{
                description: "",
                valor_entrada: "",
                valor_saida: "",
            },
            startDate: today.startOf('month').format('YYYY-MM-DD'),
            endDate: today.endOf('month').format('YYYY-MM-DD'),
            filteredPays: [],
            cashs: [],
            withScreen: 0,
            showPayClosing: false,
            
        };
    },

    methods: {
        async getRegister(){
            try {
                const response = await api.get('/ecommerce/cash-register/all/receive')
                this.cashs = response.data.data
                console.log('response.data.data', response.data.data)
            } catch (error) {
                console.error("Erro ao buscar registros:", error)
                
            }
        },

        dateSearch(){
            if(this.startDate || this.endDate){
                this.filteredPays = this.cashs.filter(register => {
                    const registerDate = dayjs(register.created_at);
                    return registerDate.isBetween(this.startDate, this.endDate, null, '[]')
                });
                this.cashs = this.filteredPays;
            }
        },  

        showRegister(){
            this.showPayClosing = true
        },

        closeRegister(event){
            this.showPayClosing = event
        },

        editRegister(){

        },
    },
    components: {
        RegisterPay
    },

    mounted(){
        this.getRegister()
        this.withScreen += screen.width

    }
};

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