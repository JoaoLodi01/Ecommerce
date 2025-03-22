<template>    
    <div
        class="flex border rounded-lg border-black mt-2 w-max" 
        id="pdv-view"
        v-if="showGrid"
        :class="{
            'ml-10': withScreen === 1920,
            'ml-14': withScreen !== 1920,
            
            'text-xl': textSize === 4,
            'text-2xl': textSize === 8,
            'text-3xl': textSize === 16,
                
        }"   
    >
        <div class="relative overflow-x-auto max-h-96 overflow-y-auto ">
            <div class="flex">
                <div class="ml-6 mt-4 mb-4 cursor-pointer" @click="showProdutcts">
                    <div class="border border-red-500 w-6 mb-1"></div>
                    <div class="border border-black w-5 mb-1"></div>
                    <div class="border border-gray-500 w-4 mb-1"></div>        
                </div>

                <input
                    type="text"
                    placeholder="Busca"
                    class="w-full ml-auto mr-2 mt-2 text-right pr-3.5 border border-black"
                />
            </div>

            <div class="m-5 w-max shadow-lg">
                <table class="block text-left rounded-t-xl rtl:text-right ">
                        <thead class="uppercase shadow-lg">
                            <tr class="bg-white sticky z-10">
                                <th scope="col" class="px-6 py-3">Cód.</th>
                                <th scope="col" class="px-6 py-3 text-left">Produto</th>
                                <th scope="col" class="px-6 py-3 text-center">CFOP</th>
                                <th scope="col" class="px-6 py-3 text-center">{{ csosncst }}</th>
                                <th scope="col" class="px-6 py-3 text-center">Qtde</th>
                                <th scope="col" class="px-6 py-3 text-center">Valor unitário</th>
                                <th scope="col" class="px-6 py-3">Valor líquido</th>

                            </tr>
                        </thead>
                        
                        <tbody v-for="products in productsSeletion">
                            <tr
                                v-for="(product, id) in products" :key="id"
                                class="border border-black"
                            >    
                                <td class="px-6" scope="row">{{ product.id }}</td>
                                <td class="px-6 py-3">{{ product.produto }}</td>

                                <td class="px-6 py-3 text-center">
                                    <input 
                                        v-model="product.cfop"
                                        :placeholder=product.cfop
                                        type="text"
                                        class="w-12 text-center border-b-4 border-b-gray-500"
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
            </div>
        <div>
        </div>
        
        <div 
            class="flex max-w-64 text-sm rounded-t-lg rounded-b-lg border border-black"
            :class="{
                'text-xl': textSize === 4,
                'text-2xl': textSize === 8,
                'text-3xl': textSize === 16,
                
            }"   
        >
        <div>
            <div>
                <div 
                    class="m-2 p-2 rounded-lg border border-gray-700"
                >
                <label class="text-black" for="discount">Vendedor</label>
                <input 
                    v-model="emitProducts.userID"
                    placeholder="Funcionário Padrão"
                    id="discount"
                    type="text"
                    class="text-black border border-black w-full"
                />
                <br>
                <label class="text-black" for="discount">Cliente</label>
                <input 
                    placeholder="Consumidor Padrão"
                    v-model="emitProducts.clientID"
                    id="discount"
                    type="text"
                    class="text-black border border-black w-full"
                />
            </div>
            
            <div
                class="m-2 p-2 rounded-lg border border-gray-700" 
                id="values"
                
            >
            <label class="text-black" for="addition">Acréscimo R$</label>
            <input 
                id="addition"
                v-model.number="emitProducts.addition"
                type="text"
                
                class="text-black border border-black w-10"
            />
            
            <br>
            <label class="text-black" for="discount">Desconto R$</label>
            <input 
                id="discount"
                v-model.number="emitProducts.discount"
                type="text"
                
                class="text-black border border-black w-10"
            />
        </div>
        
        <div
            class="m-2 p-2 rounded-lg border border-gray-700"
            id="total"
        >
        <p class="flex justify-between">Subtotal <span>R$  {{ calculateTotal.subtotal.toFixed(2) }}</span></p>
        <p class="flex justify-between">Desconto <span>R$ {{ calculateTotal.discount.toFixed(2) }}</span></p>
        <p class="flex justify-between">Acréscimo <span>R$ {{ calculateTotal.addition.toFixed(2) }}</span></p>
        <p class="flex justify-between">Frete <span>R$ {{ '0.00' }}</span></p>
        
    </div>
    <div class="flex m-2 p-2 rounded-lg border border-gray-700">
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

            <div class="mb-auto ml-auto text-xl w-auto">
                <span class="mr-1 text-white p-1 bg-slate-600 rounded-md">Total: R$ {{ calculateTotal.subtotal + calculateTotal.addition - calculateTotal.discount }}</span>
                
            </div>
        </div>

        <div class="flex text-white p-1 rounded-lg border border-gray-700">
            <button @click="finalizeSale('nm')" class="mr-1 ml-2 p-1 bg-slate-600 rounded-md">Finalizar</button>
            <button @click="finalizeSale('nfce')" class="mr-1 ml-2 p-1 bg-slate-600 rounded-md">Finalizar e emitir NFC-e</button>
            
        </div>

                </div>
            </div>
        </div>
    </div>

    <div
        v-if="showGrid"
        class="flex border border-black w-10 ml-10">
        <select id="textSize" v-model.number="textSize" @change="setTextSize">
            <option selected value=4>4</option>
            <option value=8>8</option>
            <option value=16>16</option>
        </select>
    </div>

    <div>
        <ProductsSelectionView
            v-if="show"
            :show="this.show"
            :hotelCodCRT="this.hotelCodCRT"
            @close="showGridEmit()"
            @update:selectProducts="updateProductsSeletion"
        />
    
    <PaymentsForm
        v-if="showPaymentsForm"
        :show="this.showPaymentsForm"
        :typeOperation=this.typeOperation
        :totalOperation=this.totalOperation
        :pdvID=this.pdvID
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
                hotelCodCRT: 0,
                emitProducts: {
                    addition: 0,
                    discount: 0,
                    userID: 1,
                    customerID: 1,

                },
                
                totalOperation: 0,
                withScreen: 0,
                textSize: 4,
                pdvID: 0,
                show: false,
                showGrid: true,
                showPaymentsForm: false,
                typeOperation: '',
                csosncst: '',
                api: process.env.VUE_APP_API_URL
            }
        },

        computed: {
            calculateTotal(){
                const rawproductsSeletion = toRaw(this.productsSeletion)
                
                let subtotal = 0
                rawproductsSeletion.forEach(products => {
                    for (let i = 0; i < products.length; i++) {
                        const p = products[i];
                        subtotal += p.preco_venda * p.quantidade
                        
                    }
                });

                const addition = typeof this.emitProducts.addition === 'number' ? this.emitProducts.addition : 0
                const discount = typeof this.emitProducts.discount === 'number' ? this.emitProducts.discount : 0

                return {
                    subtotal: subtotal,
                    addition: addition,
                    discount: discount
                    
                }
            },
        },
        //RTCSessionDescription
        methods: {
            async saveSale()
            {
                console.log(toRaw(this.productsSeletion))
                const saveSale = confirm('Deseja salvar a venda?')
                if (saveSale) {
                    try {
                        const response = await axios.post(`${this.api}/ecommerce/pdv/save-sale`, { // Salva apenas a venda
                            products: this.productsSeletion, // Produtos da 
                            user_id: this.emitProducts.userID,
                            customer_id: this.emitProducts.customerID,
                            sub_total: this.calculateTotal.subtotal,
                            total: this.calculateTotal.subtotal - this.calculateTotal.discount + this.calculateTotal.addition,
                            addition: this.calculateTotal.addition,
                            discount: this.calculateTotal.discount,
                            description: 'Venda guardada',
                            is_nfce_nm: null
                            
                        })
                        
                        if(response.data.success === true)
                        {
                            alert('Venda guardarda para enviar posteriormente!')
                            this.productsSeletion = []

                        }
                        
                    } catch (error) {
                        console.error('Erro saveSale() = error.response', error)
                        
                    }
                }
            },

            async getHotel(){
                try {
                    const response = await axios.get(`${this.api}/hotel/all`)
                    if(response.data.success === true)
                    {
                        this.hotelCodCRT += response.data.all.hotel.cod_crt
                        if(Number(this.hotelCodCRT) && this.hotelCodCRT > 0)
                        {
                            if(this.hotelCodCRT == 1 || this.hotelCodCRT >= 4)
                            {
                                this.csosncst = 'CSOSN'

                            } else {
                                this.csosncst = 'CST'
                            }

                        }

                    }

                    if(response.data.success === false){
                        console.log(response.data)

                    }
                } catch (error) {
                    if(error.response.data.message === 'Hotel não encontrado')
                    {
                        alert(error.response.data.message)
                        alert('Por favor faça o cadastro do mesmo')
                        this.$router.push('/hotel/create')
                        
                    }
                }
            },
            
            async finalizeSale(type)
            {
                // Só vai chamar a forma de pagamento
                this.totalOperation += this.calculateTotal.subtotal + this.calculateTotal.addition - this.calculateTotal.discount
                try {
                    if(type === 'nm')
                    {
                        const response = await axios.post(`${this.api}/ecommerce/pdv/save-sale`, { // Salva apenas a venda
                            products: this.productsSeletion, // Produtos da 
                            user_id: this.emitProducts.userID,
                            customer_id: this.emitProducts.customerID,
                            total: this.calculateTotal.subtotal - this.calculateTotal.discount + this.calculateTotal.addition,
                            sub_total: this.calculateTotal.subtotal,
                            addition: this.calculateTotal.addition,
                            discount: this.calculateTotal.discount,
                            description: 'Venda Nota Manual N°',
                            is_nfce_nm: type,
                            
                        })

                        console.log(response.data)
                        if(response.data.success === true)
                        {
                            this.productsSeletion = []
                            this.typeOperation = 'saleNM'
                            this.showPaymentsForm = !this.showPaymentsForm
                            this.pdvID = response.data.pdvID

                        }
                }
                
                if(type === 'nfce')
                {
                    const response = await axios.post(`${this.api}/ecommerce/pdv/save-sale`, { // Salva apenas a venda
                        products: this.productsSeletion, // Produtos da 
                        user_id: this.emitProducts.userID,
                        customer_id: this.emitProducts.customerID,
                        total: this.calculateTotal.subtotal - this.calculateTotal.discount + this.calculateTotal.addition,
                        sub_total: this.calculateTotal.subtotal,
                        addition: this.calculateTotal.addition,
                        discount: this.calculateTotal.discount,
                        description: 'Venda NFC-e N° ',
                        is_nfce_nm: type
                        
                    })

                    console.log(response.data)
                    if(response.data.success === true)
                    {
                        this.productsSeletion = []
                        this.typeOperation = 'saleNFCe'
                        this.showPaymentsForm = !this.showPaymentsForm
                        this.pdvID = response.data.pdvID

                    }
                }
                    
                } catch (error) {
                    console.error('Erro finalizeSale', error)   
                }
            },

            showProdutcts(){
                this.showPaymentsForm = false
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
            },

            updateProductsSeletion(selectedProducts)
            {
                this.productsSeletion = [...this.productsSeletion, selectedProducts]
                
            },

            setTextSize()
            {
                console.log('Texto atual:', this.textSize)
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
            this.getHotel()
            this.withScreen += screen.width
            
        }
      }
</script>

<style>
    #pdv-view{
        height: 100%;

    }

</style>    