<template>
    <div class="container mx-auto mt-12 p-6 ml-12">

        <div class="flex justify-between items-center mb-6">
            <h2 class="text-2xl font-semibold">Caixa</h2>
            <div class="flex space-x-4">
                <button class="bg-slate-600 text-white p-2 rounded-lg">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor" class="w-6 h-6 mr-2">
                        <path fill-rule="evenodd" d="M6.455 1.45A.5.5 0 0 1 6.952 1h2.096a.5.5 0 0 1 .497.45l.186 1.858a4.996 4.996 0 0 1 1.466.848l1.703-.769a.5.5 0 0 1 .639.206l1.047 1.814a.5.5 0 0 1-.14.656l-1.517 1.09a5.026 5.026 0 0 1 0 1.694l1.516 1.09a.5.5 0 0 1 .141.656l-1.047 1.814a.5.5 0 0 1-.639.206l-1.703-.768c-.433.36-.928.649-1.466.847l-.186 1.858a.5.5 0 0 1-.497.45H6.952a.5.5 0 0 1-.497-.45l-.186-1.858a4.993 4.993 0 0 1-1.466-.848l-1.703.769a.5.5 0 0 1-.639-.206l-1.047-1.814a.5.5 0 0 1 .14-.656l1.517-1.09a5.033 5.033 0 0 1 0-1.694l-1.516-1.09a.5.5 0 0 1-.141-.656L2.46 3.593a.5.5 0 0 1 .639-.206l1.703.769c.433-.36.928-.65 1.466-.848l.186-1.858Zm-.177 7.567-.022-.037a2 2 0 0 1 3.466-1.997l.022.037a2 2 0 0 1-3.466 1.997Z" clip-rule="evenodd" />
                    </svg>
                </button>
                <button
                    class="bg-slate-600 text-white p-1 mr-5 rounded-lg"
                    @click="showCashClosing = !showCashClosing"
                    >Cadastrar
                </button>
            </div>
        </div>

        <div class="flex justify-between mb-6 p-4 border border-gray-300 rounded-lg">
            <div><p>Total de entrada: <span class="font-semibold">R${{ input_total }}</span></p></div>

            <div><p>Total de saída: <span class="font-semibold">R${{ output_total }}</span></p></div>

            <div><p>Saldo total: <span class="font-semibold">R${{ total }}</span></p></div>
        </div>

        <div class="overflow-x-auto">
                <table class="min-w-full table-auto border-collapse border border-gray-200">
                    <thead class="bg-gray-100">
                        <tr>
                            <th scope="col" class="px-6 py-3">Tipo</th>
                            <th scope="col" class="px-6 py-3 sticky left-0 bg-gray-200">Ações</th>
                            <th scope="col" class="px-6 py-3">Cód</th>
                            <th scope="col" class="px-3 py-4">Documento</th>
                            <th scope="col" class="px-6 py-3">Descrição</th>
                            <th scope="col" class="px-6 py-3">Valor entrada</th>
                            <th scope="col" class="px-6 py-3">Valor saída</th>
                            <th scope="col" class="px-6 py-3">Total</th>
                            <th scope="col" class="px-6 py-3">Cód Espécie</th>
                            <th scope="col" class="px-6 py-3">Espécie</th>
                            <th scope="col" class="px-6 py-3">Origem</th>
                            <th scope="col" class="px-6 py-3">Cliente</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr class="border border-b-black" v-for="(register, id) in cashs" :key="id">
                            <td
                                scope="row"
                                class="px-6 py-3 sticky right-0 bg-gray-200"
                                :class="{
                                    'text-green-500 bg-green-200': register.input_value > 0,
                                    'text-red-500 bg-red-200': register.input_value < 1,
                                }">
                                {{ register.input_value > 0 ? 'Entrada' : 'Saída'}}
                            </td>
                            <td scope="row" class="px-12 sticky left-0 bg-gray-200">
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="m21 21-5.197-5.197m0 0A7.5 7.5 0 1 0 5.196 5.196a7.5 7.5 0 0 0 10.607 10.607Z" />
                                </svg>
                            </td>
                            <td scope="row" class="px-6 py-3 text-center">{{ register.id }}</td>
                            <td scope="row" class="px-6 py-3 text-center">{{ register.document }}</td>
                            <td scope="row" class="px-3 py-4">{{ register.description }}</td>
                            <td scope="row" class="px-5 py-3 text-center">R$ {{ register.input_value }}</td>
                            <td scope="row" class="px-6 py-3 text-center">{{ register.output_value }}</td>
                            <td scope="row" class="px-6 py-3 text-center">{{ register.real_balance }}</td>
                            <td scope="row" class="px-6 py-3 text-center">{{ register.especie_id }}</td>
                            <td scope="row" class="px-6 py-3">{{ register.especie }}</td>
                            <td scope="row" class="px-6 py-3">{{ register.origem }}</td>
                            <td scope="row" class="px-6 py-3">{{ register.name }}</td>
                        </tr>
                    </tbody>
                </table>
        </div>
        <RegisterCash v-if="showCashClosing"/>
    </div>
</template>

<script>
import { api } from "src/boot/axios";
import RegisterCash from "src/components/Register/Financial/RegisterCash.vue";

export default {
    data(){
        return{
            cash:{
                description: "",
                valor_entrada: "",
                valor_saida: "",
            },
            cashs: [],
            withScreen: 0,
            input_total: 0,
            output_total: 0,
            total: 0,

            showCashClosing: false,
        };
    },

    components: {
        RegisterCash
    },

    methods: {
        async getRegister(){
            try {
                const response = await api.get('/ecommerce/cash-register/all')
                this.cashs = response.data.data

                this.cashs.forEach(element => {
                    this.input_total += Number(element.input_value),
                    this.output_total += Number(element.output_value)
                 
                });
                this.total = this.input_total - this.output_total                
            } catch (error) {
            console.error("Erro ao buscar registros:", error)
                
            }
        },
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