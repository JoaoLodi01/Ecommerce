<template>
    <div
        class="w-max mx-auto border border-black rounded-lg mt-3 bg-white" 
        id="pdv-view"
        v-if="showGrid"
        :class="{
            'flex ml-16': witdhScreen > 1080 && witdhScreen >= 1472,
            'relative left-10': witdhScreen <= 1080,
            
            'text-xl': textSize === 4,
            'text-2xl': textSize === 8,
            'text-3xl': textSize === 16,
            
        }"   
    >
        <div 
            class="payMentForm" 
            :class="{
                'absolute top-24 z-20': witdhScreen > 1080,
                'absolute right-auto left-auto top-5 z-50': witdhScreen <= 1080
            }"
        >
            <PaymentsForm
                v-if="showPaymentsForm"
                :witdhScreen="this.witdhScreen"
                :typeOperation=this.typeOperation
                :totalOperation=this.totalOperation
                :pdvID=this.pdvID 
                @resetTotal="totalOperation = $event"
                @resetPDVID="pdvID = $event"
                @close="cancelOperation"
                @update:selectProducts="resetSale($event)"

            />

            <CashClosing
                v-if="showCashClosing"
                @closeCashClosing="closeCashClosing($event)"
            />

            <ErrorsModal
                v-if="errorsOfSale.showErrosModal"
                @close="chooseErrors($event)"
                :errors="errorsOfSale.erros"
                :class="{
                    'transition-transform translate-y-4': errorsOfSale.showErrosModal,
                    'opacity-0 -z-50': !errorsOfSale.showErrosModal
                }"
            />


        </div>
        
        <div class="h-4">
            <div 
                class="m-3 border border-black rounded-lg"
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
                        <button @click="showOptions" class="bg-[#BF3658] text-white p-1 mr-5 rounded-lg">Configurações</button>
                        <button class="bg-[#BF3658] text-white p-1 mr-5 rounded-lg"><router-link to="/sale/list-pdv">Voltar para a listagem</router-link></button>
                        <button @click="closeCashClosing(true)" class="bg-[#BF3658] text-white p-1 mr-5 rounded-lg">Fechamento</button>

                    </div>
                </div>

            </div>
            <div class="flex m-3 border border-black rounded-lg">
                <div 
                    class="ml-3 mt-4 mb-auto mr-5 cursor-pointer"
                    @click="showProductsSelection()"
                    
                >
                    <div class="border border-red-500 w-6 mb-1"></div>
                    <div class="border border-black w-5 mb-1"></div>
                    <div class="border border-gray-500 w-4 mb-1"></div>        

                </div>
                
                <div class="mr-1">
                    <ProductsSearchBar
                        v-if="showProductsSearch"
                        :witdhScreen="this.witdhScreen"
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
                        <tr class="">
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

                    <tbody v-for="(products, i) in productsSeletion">
                        <tr
                            v-for="(product, k) in products" :key="k"
                            class="border border-black"
                        >    

                            <td class="px-6" scope="row">{{ idPDV ? product.product_id : product.product_cod }}</td>
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
                                    :maxlength="maxlength(csosncst.toLowerCase())"
                                    :minlength="maxlength(csosncst.toLowerCase())"
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
                                    <button @click="productOptions(product, i, 'delete')">
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
                            <q-input 
                                :placeholder="sellerData.name"
                                disable
                                type="text"
                            />

                            <br>

                            <span>Cliente</span>
                            <CustomerSearchBar
                                @update:selectCustomer="updateCustomerSelection($event)"
                                :pdv="true"

                            />
                            <!-- COMPONENTE BUSCA DE CLIENTE -->                            
                        </div>
                    <div
                        class="m-2 p-2 rounded-lg border border-gray-700" 
                        
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

                        <p class="flex justify-between">Frete: R$ <input id="freight" v-model.number="emitProducts.freight" type="text" class="text-right"/></p>
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
                
                <div class="mb-0 mt-3 p-2">
                    <img src="" alt="">
                    <div class="bg-black h-[16rem]"></div>
                </div>
                <!-- A imagem vai ter que ficar por aqui -->
                    <div class="fixed bottom-4">
                        <div class="flex m-2 p-2 mt-2 rounded-lg border border-gray-700">
                            <button
                                v-if="productsSeletion.length <= 0"
                                disabled
                                title="Sem vendas no momento"
                                class="mr-1 ml-2 bg-[#EDA8B3] rounded-md"
                                
                            >
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6 text-[#8A485E]">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="m14.74 9-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 0 1-2.244 2.077H8.084a2.25 2.25 0 0 1-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 0 0-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 0 1 3.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 0 0-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 0 0-7.5 0" />
                                </svg>
                            </button>

                            <button
                                v-else @click="cancelSale()"
                                class="mr-1 ml-2 bg-[#EDA8B3] rounded-md"
                            >
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6 text-red-500">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="m14.74 9-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 0 1-2.244 2.077H8.084a2.25 2.25 0 0 1-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 0 0-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 0 1 3.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 0 0-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 0 0-7.5 0" />
                                </svg>
                            </button>

                            <button
                                v-if="productsSeletion.length <= 0"
                                disabled
                                title="Sem vendas no momento"
                                class="mr-1 ml-2 bg-[#EDA8B3] rounded-md"
                            >
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6 text-[#8A485E]">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M17.593 3.322c1.1.128 1.907 1.077 1.907 2.185V21L12 17.25 4.5 21V5.507c0-1.108.806-2.057 1.907-2.185a48.507 48.507 0 0 1 11.186 0Z" />
                                </svg>
                            </button>
                            <button 
                                class="mr-1 ml-2 bg-[#EDA8B3] rounded-md"
                                title="Salvar venda"
                                @click="saveSale()"
                                v-else
                            >
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6 text-blue-600">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M17.593 3.322c1.1.128 1.907 1.077 1.907 2.185V21L12 17.25 4.5 21V5.507c0-1.108.806-2.057 1.907-2.185a48.507 48.507 0 0 1 11.186 0Z" />
                                </svg>
                            </button>

                            <div class="mb-auto ml-auto text-xl w-auto">
                                <span class="mr-1 text-white p-1 bg-[#BF3658] rounded-md">Total: R$ {{ Math.max((calculateTotal.subtotal + calculateTotal.freight + calculateTotal.addition - calculateTotal.discount), 0).toFixed(2) }}</span>
                            
                            </div>
                        </div>

                        <div 
                            class="flex text-white rounded-lg border border-gray-700 w-[26.2rem]"
                        
                        >
                            <q-btn 
                                class="ml-5 border-none" 
                                outline 
                                size="1rem"
                            >
                                <button
                                    v-if="configs.nmFinaly"
                                    :class="{
                                        'ml-8': witdhScreen > 1080 && witdhScreen <= 1920 && configs.nmFinaly
                                    }" 
                                    @click="finalizeSale('nm')"
                                    class="mr-1 ml-2 p-1 bg-[#BF3658] rounded-md"
                                >
                                    Finalizar
                                </button>
                            </q-btn>
                            <q-btn 
                                class="ml-5" 
                                outline 
                                size="1rem"
                            >
                                <button 
                                    @click="finalizeSale('nfce')" 
                                    class="mr-1 ml-2 p-1 bg-[#BF3658] rounded-md"
                                >
                                    Finalizar e emitir NFC-e
                                </button>
        
                            </q-btn>
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div>
        <ConfigPDV
            v-if="showOptionsPDV"
            @close="closeConfig($event)"
        />

        <ProductsSelectionView
            v-if="show"
            :witdhScreen="this.witdhScreen"
            :CRT="this.CRT"
            @close="showGridEmit()"
            @update:selectProducts="updateProductsSeletion($event)"
        />
    </div>
</template>

<script setup lang="ts">
    import PaymentsForm from 'src/components/PaymentsForm.vue';
    import ProductsSelectionView from 'src/components/Products/ProductsSelectionView.vue';
    import CashClosing from 'src/components/PDV/CashClosing/CashClosing.vue'
    import ConfigPDV from 'src/components/Config/ConfigPDV.vue';
    import ProductsSearchBar from 'src/components/Products/ProductsSearchBar.vue';
    import CustomerSearchBar from 'src/components/Search/CustomerSearchBar.vue';
    import ErrorsModal from 'src/components/PDV/Errors/ErrorsModal.vue';
    
    import { api } from "src/boot/axios"
    import { ref, computed, watch, defineProps } from 'vue'   
    import { useRoute, useRouter } from 'vue-router';
    import { useQuasar, LocalStorage } from 'quasar';

    type products = {
        product: string,
        cfop: string,
        csosn: string,
        amount: number,
        sale_price: number,
    };

    const props = defineProps({
        idPDV: {
            type: number,
            required: true
        }
    });

    const $q = useQuasar();
    const route = useRoute();
    const router = useRouter();

    let timer;

    let productsSeletion = ref([]);
    let clients = ref([]);
    let errorsOfSale = ref({
                    showErrosModal: false,
                    erros: []

                });
            
    let emitProducts = ref({
                    addition: 0,
                    discount: 0,
                    freight: 0,
                    userID: 0,
                    
                });

    const CRT = ref(0);

    const sellerData = ref({
                    id: 0,
                    name: ''
                });

    const clientsData = ref({
                    id: 0,
                    name: ''
                })

    let totalOperation= ref(0);
    let witdhScreen= ref( 0);
    let textSize= ref( 4);
    let pdvID= ref( 0);
    let show= ref( false);
    let showGrid= ref( true);
    let isLoanding= ref( true);
    let showPaymentsForm= ref( false);
    let showProductsSearch= ref( true);
    let showCashClosing= ref( false);
    
    let showOptionsPDV= ref( false);
    
    let viewProduct= ref( {
        show: false,
        id: '',
        name: '',
        amount: 0,
        salePrice: 0,
        total: 0
        
    });

    let isOpenedPDV = ref(false);
    let success = ref( null);
    let typeOperation = ref('');
    let csosncst = ref('');
            
    let configs = ref({
        nmFinaly: false,
        saleNegativeorReset: false
    });

    const issuer_id = ref(LocalStorage.getItem("issuer_id"));

    const showLoading = () => {
        $q.loading.show({
            message: 'Carregando pagamento e validando a venda ...'
        })

        timer = setTimeout(() => {
            $q.loading.hide()
            timer = void 0
        }, 3000)
    }

    const hideLoanding = () => {
        if(timer !== void 0) {
            clearTimeout(timer)
            $q.loading.hide()

        }
    }
    
    watch(
        () => route.fullPath,
        (to, from) => {
            if(to === '/sale/pdv') productsSeletion.value = [];
            return;
        }
    );
        
    const calculateTotal = computed(() => {
        let subtotal: number = 0;

        productsSeletion.value.forEach((products: products[]) => {
            for(let i = 0; i < products.length; i++)
            {
                const p = products[i];
                subtotal += p.sale_price * p.amount;
            };
        });

        const addition: number = typeof emitProducts.value.addition === 'number' ? emitProducts.value.addition : 0;
        const discount: number = typeof emitProducts.value.discount === 'number' ? emitProducts.value.addition : 0;
        const freight: number = typeof emitProducts.value.freight === 'number' ? emitProducts.value.addition : 0;

        return { 
            subtotal: subtotal,
            addition: addition,
            discount: discount,
            freight: freight
        };
    });

    const saveSale = async() => {
        const saveSale = confirm('Deseja salvar a venda?');
        if (saveSale) 
        {
            if(isOpenedPDV.value)
            {
                const response = await api.post('/ecommerce/pdv/save-sale', { 
                    issuer_id:  issuer_id,
                    products: productsSeletion, 
                    user_id: sellerData.value.id,
                    customer_id: clientsData.value.id >= 1 ? clientsData.value.id : 1,
                    sub_total: calculateTotal.value.subtotal,
                    total: calculateTotal.value.subtotal- calculateTotal.value.discount + calculateTotal.value.addition,
                    addition: calculateTotal.value.addition,
                    discount: calculateTotal.value.discount,
                    description: 'Venda guardada',
                    is_nfce_nm: '',
                    status: 'Em Aberto'
                    
                })

                if(response.data.success === true)
                {
                    alert('Venda guardarda para enviar posteriormente!')
                    productsSeletion// Salva apenas a venda = []

                } else {
                    console.log(response.data)
                }

            } else {

                alert('Venda guardarda para enviar posteriormente!')
                productsSeletion// Salva apenas a venda = []
                router.push({ name: "PDV" })
            }
        }
    }
    
    const finalizeSale = async (type: string) => {
        showLoading()
            try {
                if(sellerData.value.id)
                {
                    totalOperation.value += calculateTotal.value.subtotal + calculateTotal.value.freight + calculateTotal.value.addition - calculateTotal.value.discount
                    
                } else {
                    console.log('Não deu, clientsData.id: ', clientsData.value.id, ' sellerData.id:', sellerData.value.id)
                }

                if(idPDV)
                {
                    console.log('Venda importada')
                    if(type === 'nm')
                    {
                        typeOperation = type
                        showPaymentsForm.value = !showPaymentsForm
                        pdvID.value = Number(idPDV.value)

                    }   

                    if(type === 'nfce')
                    {
                        typeOperation = type
                        showPaymentsForm = !showPaymentsForm
                        pdvID = Number(idPDV)
                    }
                
                } else {
                    const pdvID = LocalStorage.getItem("pdvID")
                    if(!pdvID)
                    {
                        console.log('Finalizar venda')
                        console.log('Total', this.totalOperation)
                        if(type === 'nm')   
                        { 
                            const response = await api.post('/ecommerce/pdv/save-sale', { // Salva apenas a venda
                                issuer_id: this.issuer_id,
                                products: this.productsSeletion, // Produtos da 
                                user_id: this.sellerData.id,
                                customer_id: this.clientsData.id >= 1 ? this.clientsData.id : 1,
                                total: this.calculateTotal.subtotal - this.calculateTotal.discount + this.calculateTotal.addition,
                                sub_total: this.calculateTotal.subtotal,
                                addition: this.calculateTotal.addition,
                                discount: this.calculateTotal.discount,
                                description: 'Venda Nota Manual N°',
                                is_nfce_nm: type,
                                status: 'Finalizada'
                                
                            })

                            const data = response.data
                            console.log(data)

                            if(data.success)
                            {
                                LocalStorage.setItem("pdvID", response.data.pdvID)
                                this.typeOperation = type
                                this.showPaymentsForm = true
                                this.pdvID = LocalStorage.getItem("pdvID")
                                console.log('this.typeOperation linha 682: ', this.typeOperation)
                                console.log('this.showPaymentsForm linha 683: ', this.showPaymentsForm)
                                console.log('this.pdvID linha 684: ', this.pdvID)

                            }
                        
                            if(!data.success)
                            {
                                console.log(response.data) 
                            }
                        } 
                    
                        if(type === 'nfce')
                        {  
                            const response = await api.post('/ecommerce/pdv/save-sale', {
                                issuer_id: this.issuer_id,
                                products: this.productsSeletion, // Produtos da 
                                user_id: this.sellerData.id,
                                customer_id: this.clientsData.id >= 1 ? this.clientsData.id : 1,
                                total: this.calculateTotal.subtotal - this.calculateTotal.discount + this.calculateTotal.addition,
                                sub_total: this.calculateTotal.subtotal,
                                addition: this.calculateTotal.addition,
                                discount: this.calculateTotal.discount,
                                description: 'Venda NFC-e N°',
                                is_nfce_nm: type,
                                status: 'Finalizada'
                                
                            })

                            console.log('response.dat PDVView, line 718: ', response)
                            const data = response.data

                            if(data.success)
                            {
                                LocalStorage.setItem("pdvID", response.data.pdvID)
                                this.typeOperation = type
                                this.showPaymentsForm = true
                                this.pdvID = LocalStorage.getItem("pdvID")

                            } else {
                                this.errorsOfSale.erros = data.errors
                                this.errorsOfSale.showErrosModal = true

                            }

                        }
                            
                    } else {
                        console.log('Essa venda não foi finalizada, ID: ', LocalStorage.getItem("pdvID"))
                        this.showPaymentsForm = true
                        this.pdvID = LocalStorage.getItem("pdvID")
                    }
                }
                
            } catch (error) {
                console.error('Erro finalizeSale', error)
                this.errorMessages.push(error.response.data.errors)
                
            }

    }
            async getCRT()
            {
                try {
                    const response = await api.get(`/issuer/companie/${LocalStorage.getItem("issuer_id")}`)

                    if(response.data.success === true)
                    {
                        this.CRT += response.data.issuer.cod_crt
                        if(Number(this.CRT) && this.CRT > 0)
                        {
                            if(this.CRT == 1 || this.CRT >= 4)
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
                        this.$router.push('/hotel/create')
                        
                    }
                }
            },

            chooseErrors(choose)
            {
                console.log('chooseErrors: ', choose)
                if(choose === 'after')
                {
                    console.log('Depois')
                    this.productsSeletion = []
                    this.errorsOfSale.showErrosModal = false
                } 

                if(choose === 'now')
                {
                    console.log('agora')
                    this.productsSeletion = []
                    this.$router.push({ path: `${LocalStorage.getItem("issuer_name")}/sale/list-pdv` })
                }

            },

            async importSale()
            {
                try {
                    const response = await api.get(`/ecommerce/pdv/get-saved-sale/${this.idPDV}`)
                    console.log('importSale', response.data)
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

            productOptions(product, i, action)
            {
                switch (action) {
                    case 'delete':
                        console.log('product.id', product.id, ' i: ', i);
                        console.log('p: ', this.productsSeletion.map(p => { return p }));

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
                if(csosncst == 'csosn')
                {
                    return 3
                } else if (csosncst == 'cst'){
                    return 2
                }
            },

            cancelSale()
            {
                const option = confirm('Deseja realmente cancelar a venda? ')
                if (option === true) {
                    this.emitProducts = [];
                    this.productsSeletion = [];
                    this.emitProducts.addition = 0;
                    this.emitProducts.discount = 0;
                    this.emitProducts.freight = 0;

                    if(this.idPDV)
                    {
                        this.$router.push({ name: 'PDV' });
                    }
                }
            },

        },
        
        components: {
            ProductsSelectionView,
            PaymentsForm,
            CashClosing,
            ConfigPDV,
            ProductsSearchBar,
            CustomerSearchBar,
            ErrorsModal

        },

        props: [
            'idPDV',
    
        ],

        mounted(){
            this.getCRT()
            this.witdhScreen += screen.width
            this.isOpenedPDV = history.state?.isOpenedPDV
            
            const getUser = async () => { 
                const response = await api.get('/auth/me', {
                    headers: {
                        'Authorization': `Bearer ${LocalStorage.getItem("auth_token")}`
                    }
                })

                this.sellerData = {
                    id: response.data.user.id,
                    name: response.data.user.name,
                }

            }
            getUser()

            const getConfig = async () => {
                const config = await api.get(`/config/all-configs/${LocalStorage.getItem("issuer_id")}`);
                this.configs.nmFinaly = config.data.configPDV[0].nm_finaly
                
            }
            getConfig()

            if(this.idPDV)
            {
                this.importSale()            
                
            }

            document.addEventListener('keydown', (event) => {
                const keyName = event.key
                
                if(keyName === 'F2')
                {
                    this.showOptions()

                } else if (keyName === 'F8')
                {
                    this.finalizeSale('nm')

                } else if (keyName === 'F9')
                {
                    this.finalizeSale('nfce')
            
                } 
            })
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
        #pdv-view {
            margin-left: 5rem; 
            
        }
        
        .payMentForm{
            position: absolute;
            left: 90rem;
        }
    }

    @media (max-width: 1080px) {
        #pdv-view {
            margin-left: 5rem;   
            
        }

        * {
            position: relative;
            
        }
        
        .payMentForm{
            position: absolute;
            left: 90rem;
        }
        
    }

    #pdv-view .products-grid table{
        max-height: 55vh;
    }

    #pdv-view{
        height: 97.3vh;
        
    }

</style>