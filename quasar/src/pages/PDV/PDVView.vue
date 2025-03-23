<template>
    <div
        class="w-max flex mx-auto border rounded-lg border-black mt-10" 
        id="pdv-view"
        v-if="showGrid"
        :class="{
            'ml-10': witdhScreen === 1920,
            'ml-14': witdhScreen !== 1920,
            'flex-col': witdhScreen <= 1080,
            'p-4': witdhScreen <= 1080,
            
            'text-xl': textSize === 4,
            'text-2xl': textSize === 8,
            'text-3xl': textSize === 16,
                
        }"   
    >
        <div :class="{
            'absolute left-96 right-auto top-40 z-20': witdhScreen > 1080,
            'absolute right-auto top-5 z-50': witdhScreen <= 1080
        }">
            <PaymentsForm
                v-if="showPaymentsForm"
                :witdhScreen="this.witdhScreen"
                :typeOperation=this.typeOperation
                :totalOperation=this.totalOperation
                :pdvID=this.pdvID
                @resetTotal="totalOperation = $event"
                @close="cancelOperation"
                @update:selectProducts="resetSale($event)"


            />
        </div>
        
        <div class="relative overflow-x-auto max-h-96 overflow-y-auto">
            <div 
                class="border border-gray-500 m-3"
                :class="{
                    'w-14': witdhScreen <= 1080,
                    
                }"
            >
                <div class="inline-flex p-3">
                    <div 
                        class="mt-auto mb-auto mr-8 cursor-pointer"
                        v-if="witdhScreen !== 0"
                        @click="showproductts"
                        
                    >
                        <div class="border border-red-500 w-6 mb-1"></div>
                        <div class="border border-black w-5 mb-1"></div>
                        <div class="border border-gray-500 w-4 mb-1"></div>        

                    </div>
                    
                    <div v-if="witdhScreen > 1366" class="border border-black mr-20 rounded-md text-center">
                        <input
                            type="text"
                            class="border-none outline-none ml-2 mt-1 mb-1 w-96"
                            placeholder="Buscar"
                        />
                    </div>

                    <div v-if="witdhScreen > 1366">
                        <button class="bg-slate-600 text-white p-1 mr-5 rounded-lg">Configuarações</button>
                        <button class="bg-slate-600 text-white p-1 mr-5 rounded-lg"><router-link to="">Voltar para a listagem</router-link></button>
                        <button class="bg-slate-600 text-white p-1 mr-5 rounded-lg">Fechamento</button>

                    </div>
                    
                </div>

            </div>

            <div class="m-5 w-max shadow-lg">                
                <table class="block text-left rounded-t-xl rtl:text-right ">
                    <thead class="uppercase shadow-lg sticky top-0 bg-white z-10">
                            <tr class="bg-white">
                                <th v-if="witdhScreen > 1080" scope="col" class="px-6 py-3">Cód.</th>
                                <th scope="col" class="px-6 py-3 text-left">Produto</th>
                                <th v-if="witdhScreen > 1080" scope="col" class="px-6 py-3 text-center">CFOP</th>
                                <th v-if="witdhScreen > 1080" scope="col" class="px-6 py-3 text-center">{{ csosncst }}</th>
                                <th v-if="witdhScreen > 1080" scope="col" class="px-6 py-3 text-center">Qtde</th>
                                <th v-if="witdhScreen > 1080" scope="col" class="px-6 py-3 text-center">Valor unitário</th>
                                <th v-if="witdhScreen > 1080" scope="col" class="px-6 py-3">Valor líquido</th>
                                <th scope="col" class="px-6 py-3">Ações</th>

                            </tr>
                        
                    </thead>

                    <tbody v-for="products in productsSeletion">
                        <tr
                            v-for="(product, id) in products" :key="id"
                            class="border border-black"
                        >    

                            <td v-if="witdhScreen > 1080" class="px-6" scope="row">{{ idPDV ? product.product_id : product.id }}</td>
                            <td class="px-6 py-3">{{ product.product }}</td>

                            <td v-if="witdhScreen > 1080"  class="px-6 py-3 text-center">
                                <input 
                                    v-model="product.cfop"
                                    :placeholder=product.cfop
                                    type="text"
                                    class="w-12 text-center border-b-4 border-b-gray-500"
                                    maxlength="4"
                                    minlength="4"
                                    @input="changeCFOP(product.id, product.cfop)"

                                />
                            </td>

                            <td v-if="witdhScreen > 1080" class="px-6 py-3 text-center">
                                <input 
                                    v-model="product.csosn"
                                    :placeholder=product.csosn
                                    type="number"
                                    :maxlength="maxlength(csosncst)"
                                    :minlength="maxlength(csosncst)"
                                    class="w-10 text-center border-b-4 border-b-gray-500"
                                    id="csosnInput"
                                    @input="changeCSOSN(product.id, product.csosn)"

                                />
                            </td>

                            <td v-if="witdhScreen > 1080" class="px-6 py-3 text-center">
                                <input 
                                    v-model="product.amount"
                                    :placeholder=product.amount 
                                    type="text"
                                    class="w-10 text-center border-b-4 border-b-gray-500 "
                                    @input="changeAmount(product.id, product.amount)"
                                    
                                />
                            </td>
                            <td v-if="witdhScreen > 1080" class="px-6 py-3 text-center">R$ {{ product.sale_price }}</td>
                            <td v-if="witdhScreen > 1080" class="text-center">R$ {{ Math.round(product.sale_price * product.amount).toFixed(2) }}</td>
                            <td class="text-center">
                                <div class="m-auto">
                                    <button>
                                        <svg 
                                            xmlns="http://www.w3.org/2000/svg"
                                            fill="none" 
                                            viewBox="0 0 24 24" 
                                            stroke-width="1.5" 
                                            stroke="currentColor" 
                                            class="size-4 text-red-500 mr-4">
                                            <path stroke-linecap="round" stroke-linejoin="round" d="m14.74 9-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 0 1-2.244 2.077H8.084a2.25 2.25 0 0 1-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 0 0-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 0 1 3.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 0 0-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 0 0-7.5 0" />
                                        </svg>
                                    </button>

                                    <button @click="productOptions">
                                        <svg
                                            xmlns="http://www.w3.org/2000/svg"
                                            viewBox="0 0 16 16" fill="currentColor"
                                            class="size-4 text-blue-600 mr-4">
                                            <path fill-rule="evenodd" d="M15 8A7 7 0 1 1 1 8a7 7 0 0 1 14 0ZM8 9a1 1 0 1 0 0-2 1 1 0 0 0 0 2ZM5.5 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0Zm6 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2Z" clip-rule="evenodd" />
                                        </svg>
                                    </button>

                                    <button>
                                        <svg 
                                            v-if="witdhScreen <= 1080"
                                            xmlns="http://www.w3.org/2000/svg"
                                            fill="none"
                                            viewBox="0 0 24 24" 
                                            stroke-width="1.5" 
                                            stroke="currentColor" 
                                            class="size-4">
                                            <path stroke-linecap="round" stroke-linejoin="round" d="m21 21-5.197-5.197m0 0A7.5 7.5 0 1 0 5.196 5.196a7.5 7.5 0 0 0 10.607 10.607Z" />
                                        </svg>

                                    </button>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                        
                </table>                
                
            </div>

            <div v-if="showProductOptions" class="relative w-64 p-2 mr-5 ml-auto bg-slate-500 text-white">
                <div class="text-left">
                    <span>Desconto: R$
                        <input 
                            type="text"
                            class="w-16 bg-slate-400"
                            
                        />
                    
                    </span>
                </div>
                
            </div>
        </div>
    <div>
        </div>
        
                <div 
                    class="flex max-w-max text-3xl rounded-t-lg rounded-b-lg border border-black "
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
                                placeholder="Funcionário Padrão"
                                v-model="emitProducts.userID"
                                id="discount"
                                type="text"
                                class="text-black border border-black w-full"
                            />

                            <br>

                            <label class="text-black" for="discount">Cliente</label>
                            <input 
                                placeholder="Consumidor Padrão"
                                v-model="emitProducts.customerID"
                                @input="findCustomer(emitProducts.customerID)"
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
                        
                        class="text-black border border-black w-20 p-0.5"
                    />
                    
                    <br>
                    <label class="text-black" for="discount">Desconto R$</label>
                    <input 
                        id="discount"
                        v-model.number="emitProducts.discount"
                        type="text"
                        
                        class="text-black border border-black w-20 p-0.5"
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
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6 text-gray-300">
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
                            v-if="productsSeletion.length <= 0"
                            disabled
                            title="Sem vendas no momento"
                            class="mr-1 ml-2 bg-slate-600 rounded-md"
                        >
                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6 text-gray-300">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M17.593 3.322c1.1.128 1.907 1.077 1.907 2.185V21L12 17.25 4.5 21V5.507c0-1.108.806-2.057 1.907-2.185a48.507 48.507 0 0 1 11.186 0Z" />
                            </svg>
                        </button>
                        <button 
                            class="mr-1 ml-2 bg-slate-600 rounded-md"
                            title="Salvar venda"
                            @click="saveSale()"
                            v-else
                        >
                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6 text-blue-600">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M17.593 3.322c1.1.128 1.907 1.077 1.907 2.185V21L12 17.25 4.5 21V5.507c0-1.108.806-2.057 1.907-2.185a48.507 48.507 0 0 1 11.186 0Z" />
                            </svg>
                        </button>

                        <div class="mb-auto ml-auto text-xl w-auto">
                            <span class="mr-1 text-white p-1 bg-slate-600 rounded-md">Total: R$ {{ calculateTotal.subtotal + calculateTotal.addition - calculateTotal.discount }}</span>
                        
                        </div>
                    </div>

                    <div class="flex text-white p-1 rounded-lg border border-gray-700 w-full">
                        <button @click="finalizeSale('nm')" class="mr-1 ml-2 p-1 bg-slate-600 rounded-md">Finalizar</button>
                        <button @click="finalizeSale('nfce')" class="mr-1 ml-2 p-1 bg-slate-600 rounded-md">Finalizar e emitir NFC-e</button>
                        
                    </div>

                </div>
            </div>
        </div>

        <!-- oder options>
        <div class="bg-purple-400">
            <div 
                class="m-2 p-2"
            >
                <p>
                    <button>12</button>
                </p>
                <p>
                    <button>12</button>
                </p>

                <p>
                    <button>12</button>
                </p>
            </div>
        </div-->
    </div>

    <div
        v-if="showGrid && witdhScreen > 1366"
        class="flex border border-black w-9  ml-10"
    >
        <select id="textSize" v-model.number="textSize">
            <option selected value=4>4</option>
            <option value=8>8</option>
            <option value=16>16</option>
        </select>
    </div>

    <div>
        <ProductsSelectionView
            v-if="show"
            :witdhScreen="this.witdhScreen"
            :hotelCodCRT="this.hotelCodCRT"
            @close="showGridEmit()"
            @update:selectProducts="updateProductsSeletion"
        />
    </div>
</template>

<script>
    
    import axios from 'axios';
    import PaymentsForm from 'src/components/PaymentsForm.vue';
    import ProductsSelectionView from 'src/components/Products/ProductsSelectionView.vue';
    import { toRaw } from 'vue'   
    
    export default{
        data(){
            return {
                productsSeletion: [],
                hotelCodCRT: 0,
                emitProducts: {
                    addition: 0,
                    discount: 0,
                    userID: 0,
                    customerID: 0,

                },
                
                totalOperation: 0,
                witdhScreen: 0,
                textSize: 4,
                pdvID: 0,
                show: false,
                showGrid: true,
                showPaymentsForm: false,
                showProductOptions: false,
                isOpenedPDV: false,
                success: null,
                typeOperation: '',
                csosncst: '',
                api: process.env.VUE_APP_API_URL
            }
        },

        watch: {
            '$route'(to, from) {
                if(to.fullPath === '/sale/pdv'){
                    this.productsSeletion = []

                } 
            }
        },  

        computed: {
            calculateTotal(){
                const rawproductsSeletion = toRaw(this.productsSeletion)
                
                let subtotal = 0
                
                rawproductsSeletion.forEach(products => {
                    for (let i = 0; i < products.length; i++) {
                        const p = products[i];
                        subtotal += p.sale_price * p.amount
                        
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
                const saveSale = confirm('Deseja salvar a venda?')
                if (saveSale) {
                    try {
                        if(!this.isOpenedPDV)
                        {
                            console.log('É uma nova venda')
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

                        } else {
                            console.log('Já era uma venda que estava guardada')
                            alert('Venda guardarda para enviar posteriormente!')
                            this.productsSeletion = []
                            this.$router.push({ name: "PDV" })
                        }
                        
                    } catch (error) {
                        console.error('Erro saveSale() = error.response', error)
                        
                    }
                }
            },

            async getHotel()
            {
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
                        alert('Por favor faça o cadastro do hotel!')
                        this.$router.push('/hotel/create')
                        
                    }
                }
            },
            
            async finalizeSale(type)
            {
                // Só vai chamar a forma de pagamento
                console.log('emitProducts', this.emitProducts)    
                this.totalOperation += this.calculateTotal.subtotal + this.calculateTotal.addition - this.calculateTotal.discount
                try {
                    if(this.idPDV)
                    {
                        console.log('this.idPDV', this.idPDV)
                        if(type === 'nm')
                        {
                            this.typeOperation = 'saleNM'
                            this.showPaymentsForm = !this.showPaymentsForm
                            this.pdvID = Number(this.idPDV)

                        }   

                        if(type === 'nfce')
                        {
                            this.typeOperation = 'saleNFCe'
                            this.showPaymentsForm = !this.showPaymentsForm
                            this.pdvID = Number(this.idPDV)
                        }
                        
                        
                    } else {
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

                            console.log('response.dat PDVView, line 415: ', response.data)

                            if(response.data.success === true)
                            {
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
                                description: 'Venda NFC-e N°',
                                is_nfce_nm: type
                                
                            })
                            console.log('response.dat PDVView, line 415: ', response.data)
                            if(response.data.success === true)
                            {
                                this.typeOperation = 'saleNFCe'
                                this.showPaymentsForm = !this.showPaymentsForm
                                this.pdvID = response.data.pdvID

                            }
                        }
                    }
                    
                } catch (error) {
                    console.error('Erro finalizeSale', error)   
                }
            },

            async importSale()
            {
                try {
                    const response = await axios.get(`${this.api}/ecommerce/pdv/get-saved-sale/${this.idPDV}`)
                    console.log(response.data.pdvs.get_itens)
                    
                    this.updateProductsSeletion(response.data.pdvs.get_itens)

                } catch (error) {
                    console.error('Erro importSale', error)
                    
                }
            },

            async findCustomer(clientID)
            {
                console.log('this.emitProducts.customerID', clientID)
            },

            showproductts(){
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
                    productFound.amount_sold = newAmount

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

            cancelOperation()
            {
                this.showPaymentsForm = false

            },

            productOptions()
            {
                this.showProductOptions = !this.showProductOptions
            },

            resetSale(confirmed)
            {
                if(confirmed)
                {
                    this.emitProducts = [],
                    this.productsSeletion = [],
                    this.emitProducts.addition = 0
                    this.emitProducts.discount = 0
                    
                }
            },

            maxlength(csosncst)
            {
                if(csosncst === 'CSOSN')
                {
                    return 2
                        
                } else if (csosncst === 'CST'){
                    return 2
                }

            },

            cancelSale()
            {
                const option = confirm('Deseja realmente cancelar a venda? ')
                if (option === true) {
                    this.emitProducts = [],
                    this.productsSeletion = [],
                    this.emitProducts.addition = 0
                    this.emitProducts.discount = 0
                    if(this.idPDV)
                    {
                        this.$router.push({ name: 'PDV' })
                    }
                }
            }
        },
        
        components: {
            ProductsSelectionView,
            PaymentsForm

        },

        props: [
            'idPDV',
    
        ],

        mounted(){
            this.getHotel()
            this.witdhScreen += screen.width
            this.isOpenedPDV = history.state?.isOpenedPDV

            if(this.idPDV)
            {
                this.importSale()            
                
            }
        }
      }
</script>

<style>
    *{
        outline: none;
    }

    #csosnInput::-webkit-outer-spin-button,
    #csosnInput::-webkit-inner-spin-button{
        margin: 0;
        -webkit-appearance: none !important; 
    }

    @media (max-width: 1080px) {
        * {
            position: relative;

        }

        body{
            display: flex;
            margin-right: 100px;
        }

        #pdv-view{
            left: 0;
            right: 100px;
        }
    }

    #pdv-view{
        height: 100%;

    }

</style>