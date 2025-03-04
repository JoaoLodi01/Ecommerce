<template>
    <div class="relative overflow-x-autoauto">
        <table class="text-left rtl:text-right">
            <thead class="uppercase">
                <tr>
                    <th scope="col" class="px-6 py-3">Nome</th>
                    <th scope="col" class="px-6 py-3">CFOP</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="(product, id) in products" :key="id">
                    <th scope="row" class="px-6 py-3">{{ product.produto }}</th>
                    <td class="px-6 py-3">{{ product.CFOP }}</td>
                    <input
                        type="checkbox"
                        v-model="product.isSelected"
                        @change="selectProducts(product)"
                    />
                </tr>
            </tbody>

        </table>

        <div
            v-if="checkBoxMarked"
        >
            <button class="ml-2">Fechar</button> 
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
            }
        },
        
        mounted(){
            this.getProducts()

        }
    }

</script>