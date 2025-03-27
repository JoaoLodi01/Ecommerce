<template>
    <div
        class="border border-black mt-12 text-2xl w-auto" 
        :class="
        {
            'ml-14 mr-16': withScreen === 1920,
            'ml-16': withScreen !== 1920
        }"   
    >

    <div class="inline-flex">
        <h2 class="w-max h-max mt-2 ml-2">Receber</h2>
        <button>
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor" 
            class="size-4 ml-1 mt-4">
                <path fill-rule="evenodd" d="M6.455 1.45A.5.5 0 0 1 6.952 1h2.096a.5.5 0 0 1 .497.45l.186 1.858a4.996 4.996 0 0 1 1.466.848l1.703-.769a.5.5 0 0 1 .639.206l1.047 1.814a.5.5 0 0 1-.14.656l-1.517 1.09a5.026 5.026 0 0 1 0 1.694l1.516 1.09a.5.5 0 0 1 .141.656l-1.047 1.814a.5.5 0 0 1-.639.206l-1.703-.768c-.433.36-.928.649-1.466.847l-.186 1.858a.5.5 0 0 1-.497.45H6.952a.5.5 0 0 1-.497-.45l-.186-1.858a4.993 4.993 0 0 1-1.466-.848l-1.703.769a.5.5 0 0 1-.639-.206l-1.047-1.814a.5.5 0 0 1 .14-.656l1.517-1.09a5.033 5.033 0 0 1 0-1.694l-1.516-1.09a.5.5 0 0 1-.141-.656L2.46 3.593a.5.5 0 0 1 .639-.206l1.703.769c.433-.36.928-.65 1.466-.848l.186-1.858Zm-.177 7.567-.022-.037a2 2 0 0 1 3.466-1.997l.022.037a2 2 0 0 1-3.466 1.997Z" clip-rule="evenodd" />
            </svg>
        </button>
    </div>

    <div class="flex justify-center border border-purple-950 m-2">
        <div class="flex justify-between border border-gray-700 w-max p-3">
            <p class="mr-2">Saldo total de entrada</p> 
            <span class="mr-4">R${{ '0.00' }}</span> 
            
            <p class="mr-2">Saldo Total</p>
            <span class="mr-5">R${{ '0.00' }}</span>

            <p class="mr-2">Saldo total</p>
            <span class="mr-4">R${{ '0.00' }}</span>

        </div>

        </div>
        <div class="flex max-w-full border-collapse container">
            <main class="relative overflow-x-auto border border-yellow-400 ml-2 w-max">
                <table class="text-left rounded-t-xl rtl:text-right table-auto">
                    <thead class="uppercase shadow-lg">
                        <tr>
                            <th scope="col" class="px-6 py-3 sticky right-0 bg-gray-200">Tipo</th>
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
                            <th scope="col" class="px-6 py-3">B</th>
                            <th scope="col" class="px-6 py-3">C</th>
                            <th scope="col" class="px-6 py-3">D</th>
                            <th scope="col" class="px-6 py-3">E</th>
                            
                        </tr>
                    </thead>
                    <tbody>
                        <tr class="border border-b-black" v-for="(register, id) in cashs" :key="id">
                            <td
                                scope="row"
                                class="px-6 py-3 sticky right-0 bg-gray-200"

                            >
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
                            <td scope="row" class="px-5 py-3 text-center">{{ register.input_value }}</td>
                            <td scope="row" class="px-6 py-3 text-center">{{ register.output_value }}</td>
                            <td scope="row" class="px-6 py-3 text-center">{{ register.real_balance }}</td>
                            <td scope="row" class="px-6 py-3 text-center">{{ register.especie_id }}</td>
                            <td scope="row" class="px-6 py-3">{{ register.especie }}</td>
                            <td scope="row" class="px-6 py-3">{{ register.origem }}</td>
                            <td scope="row" class="px-6 py-3">-</td>
                            <td scope="row" class="px-6 py-3">-</td>
                            <td scope="row" class="px-6 py-3">-</td>
                            <td scope="row" class="px-6 py-3">-</td>
                            <td scope="row" class="px-6 py-3">-</td>
                            
                        </tr>
                    </tbody>
                </table>
            </main>
        </div>
    </div>
</template>

<script>
import axios from "axios";

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
            api: process.env.VUE_APP_API_URL
        };
    },

    methods: {
        async getRegister(){
            try {
                const response = await axios.get(`${this.api}/ecommerce/cash-register/all/receive`)
                this.cashs = response.data.data
                
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

<style>
    @media (min-width: 1920px) {
        .container{       
            height: 30rem;
        }
        
    }

    body{
        max-width: 100%;
        width: max-content;
    }
</style>