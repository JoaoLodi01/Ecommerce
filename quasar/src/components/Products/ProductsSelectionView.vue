<template>
    <div class="relative overflow-x-auto ml-16 border w-max text-xl p-5">
        <div class="flex justify-between">
            <h3 class="m-2 p-2">Seleção de produtos</h3>
            <button @click="this.$emit('close')">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M6 18 18 6M6 6l12 12" />
                </svg>
            </button> 
        </div>

        <div class="flex border border-black rounded-sm shadow-lg">
            <div class="ml-5 mt-auto">
                <button @click="showSearchBar">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                        <path stroke-linecap="round" stroke-linejoin="round" d="m21 21-5.197-5.197m0 0A7.5 7.5 0 1 0 5.196 5.196a7.5 7.5 0 0 0 10.607 10.607Z" />
                    </svg> <!-- <-- Icone de lupa-->
                </button>
            </div>

            <div class="">
                <!-- Busca de produto -->
                <input 
                    type="text"
                    placeholder="Pesquisar registro" 
                    class="p-1 w-48 text-start border-none"

                />

            </div>
        </div>
        <table class="text-left rtl:text-right">
            <thead class="uppercase">
                <tr>
                    <th scope="col" class="px-6 py-3">Cód.Produto</th>
                    <th scope="col" class="px-6 py-3">Produto</th>
                    <th scope="col" class="px-6 py-3">CFOP</th>
                    <th scope="col" class="px-6 py-3 text-center"> {{ hotelCodCRT === 1 ? 'CSOSN' : 'CST' }} </th>
                    <th scope="col" class="px-6 py-3">Preço de venda</th>
                    <th scope="col" class="px-6 py-3">Quantidade</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="(product, id) in products" :key="id">
                    <th scope="row" class="px-6 py-3">{{ product.id }}</th>
                    <th scope="row" class="px-6 py-3 text-center">{{ product.product }}</th>
                    <td scope="row" class="px-6 py-3 text-center">{{ product.cfop }}</td>
                    <td scope="row" class="px-6 py-3 text-center">{{ product.csosn }}</td>
                    <td scope="row" class="px-6 py-3 text-center">R$ {{ product.sale_price }}</td>
                    <td scope="row" class="px-6 py-3 text-center">{{ product.amount }}</td>
                    <td>
                    <input 
                        label="Teal" color="teal"
                        type="checkbox"
                        v-model="product.isSelected"
                        @change="selectProducts(product)"
                    />
                    
                    </td>
                </tr>
            </tbody>

        </table>

        <div
            v-if="checkBoxMarked"
            class="flex justify-end ml-4 mt-1 p-2 bg-slate-600 text-white rounded-lg"
        >
            <p class="mt-auto mb-auto mr-auto">Produtos selecionados: {{ selectedProducts.length }}</p>

            <button class="ml-2 bg-white text-black p-2 rounded-lg hover:text-red-300" @click="this.checkBoxMarked = !this.checkBoxMarked">Fechar</button>
            <button class="ml-2 bg-slate-500 p-2 rounded-lg hover:text-blue-300" v-if="selectedProducts.length === 1">Editar</button>
            <button class="ml-2 bg-slate-500 p-2 rounded-lg hover:text-green-300" @click="emitProducts()">Adicionar</button> 
            
        </div>
    </div>

    
</template>

<script>
    import axios from 'axios';

    export default {
        data(){
            return {
                products: [],
                selectedProducts: [],
                checkBoxMarked: false,
                api: process.env.VUE_APP_API_URL

            }
        },

        emits: [
            'close',
            'update:selectProducts'

        ],

        props: {
            witdhScreen: {
                type: Number,

            },

            hotelCodCRT: {
                type: Number,
                required: true
            },
            

        },

        methods: {
            async getProducts(){
                try {
                    const response = await axios.get(`${this.api}/ecommerce/products/all`)
                    
                    this.products = response.data.data.map(product => ({
                        ...product,
                        isSelected: false

                    }));

                } catch (error) {
                    console.error('Erro ao buscar todos os produtos', error)
                        
                }
            },

            selectProducts(product)
            {
                this.checkBoxMarked = this.products.some(filterProduct => filterProduct.isSelected)

                if(product.isSelected)
                {
                    if(!this.selectedProducts.some(p => p.id === product.id)) {
                            this.selectedProducts.push({ 
                            ...product,
                            amount: 1
                        
                        })                        
                    }
                    
                } else {
                    this.selectedProducts = this.selectedProducts.filter(p => p.id !== product.id)
                }

                if(!this.checkBoxMarked)
                {
                    this.selectedProducts = []
                }
            },

            emitProducts()
            {
                this.$emit('close')
                this.$emit('update:selectProducts', this.selectedProducts);
            },

        },
        
        mounted(){
            this.getProducts()
            
        }
    }

</script>