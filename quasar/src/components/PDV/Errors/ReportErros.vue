<template>
    <div class="mt-4">
        <q-btn 
            color="primary" 
            icon="close"
            @click="close()" 
        />
        <h1>Relatório de erros</h1>

        <table class="min-w-full table-auto border-collapse border border-gray-200">
            <thead class="bg-gray-100">
                <tr>
                    <th scope="col" class="px-6 py-3">Status</th>
                    <th scope="col" class="px-6 py-3">Titulo</th>
                    <th scope="col" class="px-6 py-3">CFOP</th>
                    <th scope="col" class="px-6 py-3">CSOSN/CST</th>
                    <th scope="col" class="px-6 py-3">Controle PDV</th>
                    
                </tr>
            </thead>

            <tbody>
                <tr class="border border-b-black" v-for="error in errors">
                    <td 
                        scope="row" 
                        class="px-6 py-3 right-0 bg-gray-200"
                        :class="{
                            'bg-green-500 text-white': error.completed,
                            'bg-red-600 text-white': !error.completed
                        }"
                    >
                        {{ error.completed === 1 ? 'Resolvido' : 'Pendente' }}
                    </td>
                    <td scope="row" class="px-6 py-3 right-0 bg-gray-200">{{ error.title }}</td>
                    <td scope="row" class="px-6 py-3 right-0 bg-gray-200">{{ error.incorret_cfop ?? 'Sem problemas'}} </td>
                    <td scope="row" class="px-6 py-3 right-0 bg-gray-200">{{ error.incorret_csosn_cst ?? 'Sem problemas'}}</td>
                    <td scope="row" class="text-center px-6 py-3 right-0 bg-gray-200">{{ error.pdv_id }}</td>
                </tr>
            
            </tbody>
        </table>
    </div>
</template>

<script>
    import { api } from 'src/boot/axios'

    export default{
        data()
        {
            return {
                errors: []
            }
        },

        methods:{ 
            close()
            {
                this.$emit('close', false)
            }
        },

        emits: [
            'close'
            
        ],

        mounted()
        {
            const getErrors = async () => {
                const response = await api.get('/ecommerce/pdv/get-all-errors')
                this.errors = response.data.all.errors
                
            }
            getErrors()
            
        }
    }
</script>