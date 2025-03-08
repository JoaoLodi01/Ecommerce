<template>
    <div class="relative overflow-x-autoauto ml-16 border w-max" v-if="showGrid">
        <div class="flex">
            <div class="ml-6 mt-4 mb-4 cursor-pointer" @click="showProdutcts">
                <div class="border border-red-500 w-6 mb-1"></div>
                <div class="border border-black w-5 mb-1"></div>
                <div class="border border-gray-500 w-4 mb-1"></div>        
            </div>

            <input
                type="text"
                placeholder="Busca"
                class="w-full ml-auto text-right pr-3.5"
            />
        </div>

        <div class="m-5 w-max">
            <table class="text-left rounded-t-xl rtl:text-right">
                    <thead class="uppercase relative shadow-lg">
                        <tr>
                            <th scope="col" class="px-6 py-3 ">Cód.</th>
                            <th scope="col" class="px-6 py-3 text-left">Produto</th>
                            <th scope="col" class="px-6 py-3 text-center">CFOP</th>
                            <th scope="col" class="px-6 py-3 text-center">CSOSN</th>
                            <th scope="col" class="px-6 py-3 text-center">Qtde</th>
                            <th scope="col" class="px-6 py-3 text-center">Valor unitário</th>
                            <th scope="col" class="px-6 py-3">Valor líquido</th>

                        </tr>
                    </thead>
                    <tbody v-for="products in productsSeletion">
                        <tr v-for="(product, id) in products" :key="id" >       
                            <td class="px-6" scope="row">{{ product.id }}</td>
                            <td class="px-6 py-3">{{ product.produto }}</td>

                            <td class="px-6 py-3 text-center">
                                <input 
                                    v-model="product.cfop"
                                    :placeholder=product.cfop
                                    type="text"
                                    class="w-10 text-center border-b-4 border-b-gray-500"
                                    @input="changeCFOP(product.id, product.cfop)"

                                />
                            </td>

                            <td class="px-6 py-3 text-center">
                                <input 
                                    v-model="product.csosn"
                                    :placeholder=product.csosn
                                    type="text"
                                    class="w-10 text-center border-b-4 border-b-gray-500"
                                    @input="changeCSOSN(product.id, product.csosn)"

                                />
                            </td>

                            <td class="px-6 py-3 text-center">
                                <input 
                                    v-model="product.quantidade"
                                    :placeholder=product.quantidade
                                    type="text"
                                    class="w-10 text-center border-b-4 border-b-gray-500 "
                                    @input="changeAmount(product.id, product.quantidade)"
                                    
                                />
                            </td>
                            <td class="px-6 py-3 text-center">R$ {{ product.preco_venda }}</td>
                            <td class="text-center">R$ {{ product.preco_venda * product.quantidade }}</td>
                        </tr>    
                    </tbody>
                </table>
            </div>

        <div class="flex justify-end">
            <div class="m-5 top-auto">
                <div class="inline-flex bg-slate-800 text-white p-2 rounded-md">
                    <label for="addition">Acréscimo</label>
                    <input 
                        id="addition"
                        v-model.number="addition"
                        type="text"
                        class="text-black border border-black w-10"
                    />
                    <label for="discount">Desconto</label>
                    <input 
                        id="discount"
                        v-model.number="discount"
                        type="text"
                        class="text-black border border-black w-10"
                    />

                    <button
                        v-if="productsSeletion.length <= 0"
                        disabled
                        title="Sem vendas no momento"
                        class="mr-1 ml-2 bg-slate-600 rounded-md"

                    >
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6 text-white">
                            <path stroke-linecap="round" stroke-linejoin="round" d="m14.74 9-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 0 1-2.244 2.077H8.084a2.25 2.25 0 0 1-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 0 0-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 0 1 3.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 0 0-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 0 0-7.5 0" />
                        </svg>
                    </button>
                    <button
                        v-else @click="cancelSale()"
                        class="mr-1 ml-2 bg-slate-600 rounded-md"
                    >
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6 text-red-500">
                            <path stroke-linecap="round" stroke-linejoin="round" d="m14.74 9-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 0 1-2.244 2.077H8.084a2.25 2.25 0 0 1-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 0 0-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 0 1 3.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 0 0-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 0 0-7.5 0" />
                        </svg>
                    </button>

                    <button 
                        class="mr-1 ml-2 bg-slate-600 rounded-md"
                        title="Salvar venda"
                        @click="saveSale()"
                    >
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6 text-blue-600">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M17.593 3.322c1.1.128 1.907 1.077 1.907 2.185V21L12 17.25 4.5 21V5.507c0-1.108.806-2.057 1.907-2.185a48.507 48.507 0 0 1 11.186 0Z" />
                        </svg>
                    </button>
                        <button @click="saleNM()" class="p-2 mr-1 ml-2 bg-slate-600 rounded-md">Finalizar</button>
                        <button @click="saleNFCe()" class="p-2 mr-1 ml-2 bg-slate-600 rounded-md">Finalizar e emitir NFC-e</button>
                        <span class="mt-auto mb-auto mr-1 ml-2 p-2 bg-slate-600 rounded-md">Total: R$ {{ calculateTotal() }}</span>
                    </div>
                </div>
            </div>
        </div>
    <div>
      <ProductsSelectionView
            v-if="show"
            :show="this.show"
            @close="showGridEmit()"
            @update:selectProducts="updateProductsSeletion"
        />
    
    </div>

  <div>
    <PaymentsForm
        v-if="showPaymentsForm"
        :show="this.showPaymentsForm"
        :typeOperation=this.typeOperation
        :totalOperation=this.totalOperation
        @close="cancelOperation"

    />
  </div>
</template>

<script>
    import PaymentsForm from '@/views/components/PaymentsForm.vue';
    import ProductsSelectionView from '@/views/components/ProductsSelectionView.vue';
    import axios from 'axios';
    import { toRaw } from 'vue'   
    
    export default{
        data(){
            return {
                productsSeletion: [],
                emitProducts: [],
                userDetails: [],
                show: false,
                showGrid: true,
                showPaymentsForm: false,
                typeOperation: '',
                totalOperation: 0,
                addition: 0,
                discount: 0,

                userID: 1,
                clientID: 1,

                api: process.env.VUE_APP_API_URL
            }
        },

        methods: {
            async saveSale(){
                try {
                    const response = await axios.post(`${this.api}/ecommerce/pdv/save-sale`, { // Salva apenas a venda
                        products: this.productsSeletion, // Produtos da venda
                        userID: this.userID,
                        clientID: this.clientID,
                        addition: this.addition ?? 0,
                        discount: this.discount ?? 0,
                        
                    })
                    
                    console.log(response.data)
                    
                } catch (error) {
                    console.error('Erro saveSale()', error)
                    
                }
            },

            showProdutcts(){
                this.showGrid = !this.showGrid
                this.show = !this.show
                
            },

            
            showGridEmit(){
                this.showGrid = !this.showGrid
                this.show = !this.show

            },  

            changeAmount(id, newAmount)
            {
                const rawProducts = toRaw(this.productsSeletion)

                let productFound = null;
                
                for (let i = 0; i < rawProducts.length; i++) {
                    const productArray = rawProducts[i];
                    productFound = productArray.find(p => p.id === id)
                    if(productFound) break

                }

                if(productFound)
                {
                    productFound.quantidade = newAmount

                }
                
                this.emitProducts = this.productsSeletion
            },

            changeCFOP(id, newCFOP)
            {
                const rawProducts = toRaw(this.productsSeletion)

                let productFound = null;
                
                for (let i = 0; i < rawProducts.length; i++) {
                    const productArray = rawProducts[i];
                    productFound = productArray.find(p => p.id === id)
                    if(productFound) break

                }

                if(productFound)
                {
                    productFound.cfop = newCFOP

                }
                
                this.emitProducts = this.productsSeletion
            },

            changeCSOSN(id, newCSOSN)
            {
                const rawProducts = toRaw(this.productsSeletion)

                let productFound = null;
                
                for (let i = 0; i < rawProducts.length; i++) {
                    const productArray = rawProducts[i];
                    productFound = productArray.find(p => p.id === id)
                    if(productFound) break

                }

                if(productFound)
                {
                    productFound.csosn = newCSOSN

                }
                
                this.emitProducts = this.productsSeletion
            },

            calculateTotal(){
                const rawproductsSeletion = toRaw(this.productsSeletion)
                
                let totalSale = 0
                rawproductsSeletion.forEach(products => {
                    for (let i = 0; i < products.length; i++) {
                        const element = products[i];
                        totalSale += element.preco_venda * element.quantidade 

                    }
                });

                return totalSale + this.addition - this.discount
            },

            updateProductsSeletion(selectedProducts)
            {
                this.productsSeletion = [...this.productsSeletion, selectedProducts]
                
            },

            saleNFCe()
            {
                this.typeOperation = 'saleNFCe'
                this.showPaymentsForm = !this.showPaymentsForm
                console.log('this.emitProducts', this.emitProducts)
                
            },

            saleNM()
            {
                this.typeOperation = 'saleNM'
                this.showPaymentsForm = !this.showPaymentsForm
                console.log('this.emitProducts', this.emitProducts)
                
            },

            cancelOperation()
            {
                this.showPaymentsForm = false

            },

            cancelSale()
            {
                const option = confirm('Deseja realmente cancelar a venda? ')
                if (option === true) {
                    this.emitProducts = [],
                    this.productsSeletion = []
                }
                
            }
        },

        components: {
            ProductsSelectionView,
            PaymentsForm
        },

        mounted(){
            
        }
      }
</script>