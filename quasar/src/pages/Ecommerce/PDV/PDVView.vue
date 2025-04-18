<template>
    <div
        class="w-max mx-auto border border-black rounded-lg mt-9" 
        id="pdv-view"
        v-if="showGrid"
        :class="{
            'flex ml-14': witdhScreen > 1080 && witdhScreen >= 1472,
            'relative left-10': witdhScreen <= 1080,
            
            'text-xl': textSize === 4,
            'text-2xl': textSize === 8,
            'text-3xl': textSize === 16,
            
        }"   
    >
        <div class="payMentForm" :class="{
            'absolute top-24 z-20': witdhScreen > 1080,
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

            <CashClosing
                v-if="showCashClosing"
                @closeCashClosing="closeCashClosing($event)"
            />

        </div>
        
        <div class="h-4">
            <div 
                class="m-3 border border-black"
                :class="{
                    'w-14': witdhScreen <= 1080,
                    
                }"
            >
                <div 
                    class="inline-flex p-3"
                >
                    <div 
                        v-if="witdhScreen > 1366"
                        class="mr-16 mt-1"
                    >
                        <button @click="showOptions" class="bg-slate-600 text-white p-1 mr-5 rounded-lg">Configurações</button>
                        <button class="bg-slate-600 text-white p-1 mr-5 rounded-lg"><router-link to="/sale/list-pdv">Voltar para a listagem</router-link></button>
                        <button @click="closeCashClosing(true)" class="bg-slate-600 text-white p-1 mr-5 rounded-lg">Fechamento</button>

                    </div>
                </div>

            </div>
            <div class="flex m-3 border border-black">
                <div 
                    class="ml-3 mt-4 mb-auto mr-5 cursor-pointer"
                    @click="showProductsSelection"
                    
                >
                    <div class="border border-red-500 w-6 mb-1"></div>
                    <div class="border border-black w-5 mb-1"></div>
                    <div class="border border-gray-500 w-4 mb-1"></div>        

                </div>
                
                <div class="mr-1">
                    <ProductsSearchBar
                        v-if="showProductsSearch"
                        :witdhScreen="witdhScreen"
                        @update:selectProducts="updateProductsSeletion($event)"

                    />
                    <!--Busca de produto-->
                </div>

            </div>
  
            <div 
                class="products-grid m-5 shadow-lg relative overflow-y-auto"
            >
                <table class="block text-left rounded-t-xl rtl:text-right ">
                    <thead class="uppercase shadow-lg sticky top-0 bg-white z-10">
                            <tr class="bg-white">
                                <th scope="col" class="px-6 py-3">Cód.</th>
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

                            <td class="px-6" scope="row">{{ idPDV ? product.product_id : product.id }}</td>
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
                                    v-model="product.csosncst"
                                    :placeholder=product.csosncst
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
                                    <button @click="productOptions(product, 'delete')">
                                        <svg 
                                            xmlns="http://www.w3.org/2000/svg"
                                            fill="none" 
                                            viewBox="0 0 24 24" 
                                            stroke-width="1.5" 
                                            stroke="currentColor" 
                                            class="size-4 text-red-500 mr-4">
                                            <path stroke-linecap="round" stroke-linejoin="round" d="m14.74 9-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 0 1-2.244 2.077H8.084a2.25 2.25 0 0 1-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 0 0-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 0 1 3.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 0 0-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 0 0-7.5 0" 
                                        />
                                            delete
                                        </svg>
                                    </button>

                                    <button @click="productOptions(product, 'options')">
                                        <svg
                                            xmlns="http://www.w3.org/2000/svg"
                                            viewBox="0 0 16 16" fill="currentColor"
                                            class="size-4 text-blue-600 mr-4">
                                            <path fill-rule="evenodd" d="M15 8A7 7 0 1 1 1 8a7 7 0 0 1 14 0ZM8 9a1 1 0 1 0 0-2 1 1 0 0 0 0 2ZM5.5 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0Zm6 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2Z" clip-rule="evenodd"
                                        />
                                            options
                                        </svg>
                                    </button>

                                    <button @click="productOptions(product, 'view')">
                                        <svg 
                                            v-if="witdhScreen < 1080"
                                            xmlns="http://www.w3.org/2000/svg"
                                            fill="none"
                                            viewBox="0 0 24 24" 
                                            stroke-width="1.5" 
                                            stroke="currentColor" 
                                            class="size-4">
                                            <path stroke-linecap="round" stroke-linejoin="round" d="m21 21-5.197-5.197m0 0A7.5 7.5 0 1 0 5.196 5.196a7.5 7.5 0 0 0 10.607 10.607Z" />
                                            view
                                            
                                        </svg>

                                    </button>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                        
                </table>                
                
            </div>
        </div>

        <div v-if="viewProduct.show" class="absolute top-40 left-9 w-64 p-2 mr-5 ml-autobg-white z-50 rounded-lg bg-slate-700 text-white">
            <div class="flex justify-end">
                <div @click="viewProduct.show = !viewProduct.show">Voltar</div>

            </div>
            <div class="text-left">
                <p><span>Cód: {{ viewProduct.id }}</span></p>
                <p><span>Preço unitário: R${{ viewProduct.salePrice }}</span></p>
                <p>
                    <input 
                        v-model="viewProduct.amount"
                        :placeholder=viewProduct.amount
                        type="text"
                        class="w-10 text-center border-b-4 border-b-gray-500 text-black"
                        @input="changeAmount(viewProduct.id, viewProduct.amount)"
                        
                    />
                
                </p>
                
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
                    'm-auto': witdhScreen <= 1080
                }"   
            >
                <div>
                    <div>
                        <div 
                            class="m-2 p-2 rounded-lg border border-gray-700"
                        >
                            <label class="text-black" for="discount">Vendedor</label>
                            <input 
                                :placeholder="sellerData.name"
                                disabled
                                id="discount"
                                type="text"
                                class="text-black border border-black w-full"
                            />

                            <br>

                            <span>Cliente</span>
                            <CustomerSearchBar
                                @update:selectCustomer="updateCustomerSelection($event)"

                            />
                            <!-- COMPONENTE BUSCA DE CLIENTE -->                            
                        </div>

                        <div class="p-4 ">
                            <img 
                                src="https://imgs.search.brave.com/nJmykNUP9XwPUajqhDgGwIOVJBgf1x5N3Fi6go7pp04/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9sbmNp/bWcubGFuY2UuY29t/LmJyL2Nkbi1jZ2kv/aW1hZ2Uvd2lkdGg9/ODUwLHF1YWxpdHk9/NzUsZm9ybWF0PXdl/YnAvdXBsb2Fkcy8y/MDI0LzA5L2VzY3Vk/by1wYWxtZWlyYXMu/anBn" 
                                class="rounded-lg"
                                height="420px"
                                width="420px"
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
                            class="text-black rounded-lg border border-black w-20 p-0.5 ml-1 m-1"
                        />
                        <br>
                        <label class="text-black" for="discount">Desconto R$</label>
                        <input 
                            id="discount"
                            v-model.number="emitProducts.discount"
                            type="text"
                            class="text-black rounded-lg border border-black w-20 p-0.5 ml-3.5 m-1"
                        />
                        <br>
                        <label class="text-black" for="discount">Frete R$</label>
                        <input 
                            id="freight"
                            v-model.number="emitProducts.freight"
                            type="text"
                            class="text-black rounded-lg  border border-black w-20 p-0.5 ml-3.5 m-1"
                        />
                    </div>
                <div
                    class="m-2 p-2 rounded-lg border border-gray-700"
                    id="total"

                >
                    <p class="flex justify-between">Subtotal <span>R$  {{ calculateTotal.subtotal.toFixed(2) }}</span></p>
                    <p class="flex justify-between">Desconto <span>R$ {{ calculateTotal.discount.toFixed(2) }}</span></p>
                    <p class="flex justify-between">Acréscimo <span>R$ {{ calculateTotal.addition.toFixed(2) }}</span></p>
                    <p class="flex justify-between">Frete <span>R$ {{ calculateTotal.freight.toFixed(2) }}</span></p>
                
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
                            <span class="mr-1 text-white p-1 bg-slate-600 rounded-md">Total: R$ {{ Math.max((calculateTotal.subtotal + calculateTotal.freight + calculateTotal.addition - calculateTotal.discount), 0).toFixed(2) }}</span>
                        
                        </div>
                    </div>

                    <div 
                        class="flex text-white p-1 rounded-lg border border-gray-700 w-full"
                    
                    >
                    
                    <q-btn class="ml-5" outline size="1.2rem">
                        <button
                            v-if="configs.nmFinaly"
                            :class="{
                                'ml-8': witdhScreen > 1080 && witdhScreen <= 1920
                            }" 
                            @click="finalizeSale('nm')"
                            class="mr-1 ml-2 p-1 bg-slate-600 rounded-md"
                        >
                            Finalizar
                        </button>
                    </q-btn>
                    <q-btn class="ml-5" outline size="1.2rem">
                        <button @click="finalizeSale('nfce')" class="mr-1 ml-2 p-1 bg-slate-600 rounded-md">Finalizar e emitir NFC-e</button>
                    </q-btn>
                    </div>

                </div>
            </div>
        </div>

        <!-- oder options -->
        
    </div>
    <div>
        <ConfigPDV
            v-if="showOptionsPDV"
            @close="closeConfig($event)"
        />

        <ProductsSelectionView
            v-if="show"
            :witdhScreen="witdhScreen"
            :hotelCodCRT="this.hotelCodCRT"
            @close="showGridEmit()"
            @update:selectProducts="updateProductsSeletion($event)"
        />
    </div>
</template>

<script>
    import PaymentsForm from 'src/components/PaymentsForm.vue';
    import ProductsSelectionView from 'src/components/Products/ProductsSelectionView.vue';
    import CashClosing from 'src/components/PDV/CashClosing.vue'
    import ConfigPDV from 'src/components/Config/ConfigPDV.vue';
    import ProductsSearchBar from 'src/components/Products/ProductsSearchBar.vue';
    import CustomerSearchBar from 'src/components/Search/CustomerSearchBar.vue';
    
    import { api } from "boot/axios"
    import { onBeforeUnmount, toRaw } from 'vue'   
    import { useQuasar, LocalStorage } from 'quasar';
    
    export default{
        setup(){
            const $q = useQuasar()
            let timer
            onBeforeUnmount(() => {
                if(timer !== void 0) {
                    clearTimeout(timer)
                    $q.loading.hide()

                }
            })

            return { 
                showLoading () {
                    $q.loading.show({
                        message: 'Carregando pagamento e validando a venda ...'
                    })

                    timer = setTimeout(() => {
                        $q.loading.hide()
                        timer = void 0
                    }, 3000)
                }
            }
        },  

        data(){
            return {
                productsSeletion: [],
                errorMessages: [],
                clients: [],
                

                emitProducts: {
                    addition: 0,
                    discount: 0,
                    freight: 0,
                    userID: 0,
                    
                },

                hotelCodCRT: 0,

                sellerData: {
                    id: 0,
                    name: ''
                },

                clientsData: {
                    id: 0,
                    name: ''
                },

                totalOperation: 0,
                witdhScreen: 0,
                textSize: 4,
                pdvID: 0,
                show: false,
                showGrid: true,
                isLoanding: true,
                showPaymentsForm: false,
                showProductsSearch: true,
                showCashClosing: false,
                
                showOptionsPDV: false,
                
                viewProduct: {
                    show: false,
                    id: '',
                    name: '',
                    amount: 0,
                    salePrice: 0,
                    total: 0
                    
                },

                isOpenedPDV: false,
                success: null,
                typeOperation: '',
                csosncst: '',
            
                configs: {
                    nmFinaly: false,
                    saleNegativeorReset: false
                }
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
                const freight = typeof this.emitProducts.freight === 'number' ? this.emitProducts.freight : 0
                
                return {
                    subtotal: subtotal,
                    addition: addition,
                    discount: discount,
                    freight: freight
                    
                }
            },
        },
        
        methods: {
            async saveSale()
            {
                const saveSale = confirm('Deseja salvar a venda?')
                if (saveSale) {
                    try {
                        if (this.totalOperation > 1000){
                            if(!this.isOpenedPDV)
                            {
                                const response = await api.post('/ecommerce/pdv/save-sale', { // Salva apenas a venda
                                    products: this.productsSeletion, // Produtos da 
                                    user_id: this.sellerData.id,
                                    customer_id: this.clientsData.id,
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

                                } else {
                                    console.log(response.data)
                                }

                            } else {

                                alert('Venda guardarda para enviar posteriormente!')
                                this.productsSeletion = []
                                this.$router.push({ name: "PDV" })
                            }
                        } else {
                            alert('Não calculou o total')
                        }
                        
                    } catch (error) {
                        console.error('Erro saveSale() = error.response', error)
                        
                    }
                }
            },

            async getHotel()
            {
                try {
                    const response = await api.get('/hotel/all')

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
            
            async finalizeSale(type) // Só vai chamar a forma de pagamento
            {
                this.showLoading()
                try {
                    if(this.clientsData.id && this.sellerData.id)
                    {
                        console.log('Pode calcular o total')
                        this.totalOperation += this.calculateTotal.subtotal + this.calculateTotal.freight + this.calculateTotal.addition - this.calculateTotal.discount
                    }

                    if(this.idPDV)
                    {
                        if(type === 'nm')
                        {
                            this.typeOperation = type
                            this.showPaymentsForm = !this.showPaymentsForm
                            this.pdvID = Number(this.idPDV)

                        }   

                        if(type === 'nfce')
                        {
                            this.typeOperation = type
                            this.showPaymentsForm = !this.showPaymentsForm
                            this.pdvID = Number(this.idPDV)
                        }
                    
                    } else {
                        console.log('Finalizar venda')
                        if(type === 'nm')   
                        { 
                            const response = await api.post('/ecommerce/pdv/save-sale', { // Salva apenas a venda
                                products: this.productsSeletion, // Produtos da 
                                user_id: this.sellerData.id,
                                customer_id: this.clientsData.id,
                                total: this.calculateTotal.subtotal - this.calculateTotal.discount + this.calculateTotal.addition,
                                sub_total: this.calculateTotal.subtotal,
                                addition: this.calculateTotal.addition,
                                discount: this.calculateTotal.discount,
                                description: 'Venda Nota Manual N°',
                                is_nfce_nm: type,
                                
                            })

                            if(response.data.success === true)
                            {
                                this.typeOperation = type
                                this.showPaymentsForm = !this.showPaymentsForm
                                this.pdvID = response.data.pdvID

                            }
                        
                        } 
                    
                        if(type === 'nfce')
                        {  
                            const response = await api.post('/ecommerce/pdv/save-sale', {
                                products: this.productsSeletion, // Produtos da 
                                user_id: this.sellerData.id,
                                customer_id: this.clientsData.id,
                                total: this.calculateTotal.subtotal - this.calculateTotal.discount + this.calculateTotal.addition,
                                sub_total: this.calculateTotal.subtotal,
                                addition: this.calculateTotal.addition,
                                discount: this.calculateTotal.discount,
                                description: 'Venda NFC-e N°',
                                is_nfce_nm: type
                                
                            })
                            console.log('response.dat PDVView, line 686: ', response.data)

                            if(response.data.success === true)
                            {
                                this.typeOperation = type
                                this.showPaymentsForm = !this.showPaymentsForm
                                this.pdvID = response.data.pdvID

                            }
                        }
                    
                    }
                    
                } catch (error) {
                    console.error('Erro finalizeSale', error.response.data.errors)
                    alert(error.response.data.errors)
                    this.errorMessages.push(error.response.data.errors)
                    
                }
            },

            async importSale()
            {
                try {
                    const response = await api.get(`/ecommerce/pdv/get-saved-sale/${this.idPDV}`)
                    
                    this.updateProductsSeletion(response.data.pdvs.get_itens)

                } catch (error) {
                    console.error('Erro importSale', error)
                    
                }
            },

            showOptions(){
                this.showOptionsPDV = true
                this.showPaymentsForm = false
                this.showGrid = false
                this.show = false
                
            },

            showProductsSelection(){
                this.showPaymentsForm = false
                this.showGrid = !this.showGrid
                this.show = !this.show
                
            },
            
            showGridEmit(){
                this.showGrid = !this.showGrid
                this.show = !this.show
                
            },  

            closeConfig(event)
            {
                this.showOptionsPDV = event
                this.showGrid = !event

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
                    productFound.amount = newAmount

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

            updateCustomerSelection(client)
            {  
                this.clientsData = {
                    id: client.id,
                    name: client.name
                }
            },

            cancelOperation()
            {
                this.showPaymentsForm = false

            },

            productOptions(product, action)
            {
                let rawProducts = toRaw(this.productsSeletion)

                switch (action) {
                    case 'delete':
                        for (let i = 0; i < rawProducts.length; i++) {
                            const products = rawProducts[i];
                            const index = products.findIndex(p => p.id === product.id)                            

                            if(index !== -1)
                            {
                                products.splice(index, 1)
                                
                                while (products.length <= 0 ) {
                                    this.productsSeletion = []
                                    break
                                }
                                break
                            }
                        }
                        break;
                        
                    case 'view':
                        this.viewProduct ={
                            id: product.id,
                            name: product.product,
                            amount: product.amount,
                            salePrice: product.sale_price,
                            total: product.amount * product.sale_price
                        }
                        this.viewProduct.show = !this.viewProduct.show
                        
                        break;

                    case 'options':
                        
                        break;
                
                    default:
                        break;
                }
            },

            closeCashClosing(event)
            {
                this.showCashClosing = event
            },

            resetSale(confirmed)
            {
                if(confirmed)
                {
                    this.emitProducts = [],
                    this.productsSeletion = [],
                    this.emitProducts.addition = 0
                    this.emitProducts.discount = 0
                    this.emitProducts.freight = 0
                    this.clientsData.id = null
                    this.clientsData.name = null
                    
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
            PaymentsForm,
            CashClosing,
            ConfigPDV,
            ProductsSearchBar,
            CustomerSearchBar

        },

        props: [
            'idPDV',
    
        ],

        mounted(){
            this.getHotel()
            this.witdhScreen += screen.width
            this.isOpenedPDV = history.state?.isOpenedPDV
            
            const getUser = async () => { 
                const response = await api.get('/auth/me', {
                    headers: {
                        'Authorization': `Bearer ${LocalStorage.getItem("auth_token")}`
                    }
                })
                const details = response.data   

                this.sellerData = {
                    id: details.user.id,
                    name: details.user.name,
                }

            }
            getUser()

            const getConfig = async () => {
                const config = await api.get('/config/all-configs');
                this.configs.nmFinaly = config.data.configPDV[0].nm_finaly
                
            }
            getConfig()

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
    
    @media (max-width: 1366px) {
        .payMentForm{
            position: absolute;
            left: 90rem;
        }
    }

    @media (max-width: 1080px) {
        * {
            position: relative;

        }
        
        .payMentForm{
            position: absolute;
            left: 90rem;
        }

        body{
            display: flex;
            margin-right: 100px;
        }
        
    }

    #pdv-view .products-grid table{
        max-height: 55vh;
    }

    #pdv-view{
        height: auto;
        
    }

</style>