<template>
    <div class="relative overflow-x-autoauto w-max">
        <div class="flex justify-between">
            <h3 class="ml-5">Todos os produtos</h3>
            <input type="text" placeholder="( n faz nd )Pesquisar registro " >
            <button @click="this.$emit('close')">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M6 18 18 6M6 6l12 12" />
                </svg>

            </button> 
        </div>
        <table class="text-left rtl:text-right">
            <thead class="uppercase">
                <tr>
                    <th scope="col" class="px-6 py-3">Cód.Produto</th>
                    <th scope="col" class="px-6 py-3">Produto</th>
                    <th scope="col" class="px-6 py-3">CFOP</th>
                    <th scope="col" class="px-6 py-3">CSOSN</th>
                    <th scope="col" class="px-6 py-3">Preço de venda</th>
                    <th scope="col" class="px-6 py-3">Quantidade</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="(product, id) in products" :key="id">
                    <th scope="row" class="px-6 py-3">{{ product.id }}</th>
                    <th scope="row" class="px-6 py-3 text-center">{{ product.produto }}</th>
                    <td scope="row" class="px-6 py-3 text-center">{{ product.cfop }}</td>
                    <td scope="row" class="px-6 py-3 text-center">{{ product.csosn }}</td>
                    <td scope="row" class="px-6 py-3 text-center">R$ {{ product.preco_venda }}</td>
                    <td scope="row" class="px-6 py-3 text-center">{{ product.quantidade }}</td>
                    <td>
                    <input
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
            class="ml-4 bg-slate-500 text-white rounded-lg"
        >
            <button class="ml-2" @click="this.checkBoxMarked = !this.checkBoxMarked">Fechar</button>
            <button class="ml-2" v-if="selectedProducts.length === 1">Editar</button>
            <button class="ml-2" @click="emitProducts()">Adicionar</button> 
            
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
            show: {
                type: Boolean,
                required: true
            }
        },

        methods: {
            async getProducts(){
                try {
                    const response = await axios.get(`${this.api}/ecommerce/products/all`)
                    
                    this.products = response.data.map(product => ({
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
                    this.selectedProducts.push({ 
                        ...product,
                        quantidade: 1
                        
                    })
                    
                } else {
                    this.selectedProducts = this.selectedProducts.filter((selectProduct) => 
                        selectProduct.id !== product.id
                        
                    )
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
            const response = axios.get(`${this.api}/hotel/all`)
            console.log(response)
        }
    }

</script>