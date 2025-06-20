<template>
    <div v-if="!showPage">
        <LoandingPage
            @show-page="showPage = $event"
            :page="'do PDV'"
                        
        />

    </div>
    <div v-if="showPage"> <!-- SHOW PAGE -->
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
                    :witdhScreen="witdhScreen"
                    :typeOperation=typeOperation
                    :totalOperation=totalOperation
                    :pdvID=pdvID 
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

                                <td class="px-6" scope="row">{{ product.product_cod }}</td>
                                <td class="px-6 py-3">{{ product.product }}</td>

                                <td v-if="witdhScreen > 1080"  class="px-6 py-3 text-center">
                                    <input 
                                        v-model="product.cfop"
                                        :placeholder=String(product.cfop)
                                        type="text"
                                        class="w-12 text-center border-b-4 border-b-gray-500"
                                        maxlength="4"
                                        minlength="4"
                                        @input="changeCFOP(product.id, Number(product.cfop))"

                                    />
                                </td>

                                <td v-if="witdhScreen > 1080" class="px-6 py-3 text-center">
                                    <input 
                                        v-model="product.csosncst"
                                        :placeholder=String(product.csosncst)
                                        type="number"
                                        :maxlength="maxlength(csosncst.toLowerCase())"
                                        :minlength="maxlength(csosncst.toLowerCase())"
                                        class="w-10 text-center border-b-4 border-b-gray-500"
                                        id="csosnInput"
                                        @input="changeCSOSN(product.id, Number(product.csosncst))"

                                    />
                                </td>

                                <td v-if="witdhScreen > 1080" class="px-6 py-3 text-center">
                                    <input 
                                        v-model="product.amount"
                                        :placeholder="String(product.amount)"
                                        type="text"
                                        class="w-10 text-center border-b-4 border-b-gray-500 "
                                        @input="changeAmount(product.id, Number(product.amount))"
                                        
                                    />
                                </td>
                                <td v-if="witdhScreen > 1080" class="px-6 py-3 text-center">R$ {{ product.sale_price }}</td>
                                <td v-if="witdhScreen > 1080" class="text-center">R$ {{ Math.round(product.sale_price * Number(product.amount)).toFixed(2) }}</td>
                                <td class="text-center">
                                    <div class="m-auto">
                                        <button @click="productOptions(product.id, i, 'delete')">
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

                                        <button @click="productOptions(product.id, i, 'options')">
                                            <svg
                                                xmlns="http://www.w3.org/2000/svg"
                                                viewBox="0 0 16 16" fill="currentColor"
                                                class="size-4 text-blue-600 mr-4">
                                                <path fill-rule="evenodd" d="M15 8A7 7 0 1 1 1 8a7 7 0 0 1 14 0ZM8 9a1 1 0 1 0 0-2 1 1 0 0 0 0 2ZM5.5 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0Zm6 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2Z" clip-rule="evenodd"
                                            />
                                                options
                                            </svg>
                                        </button>

                                        <button @click="productOptions(product.id, i, 'view')">
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
                            :placeholder=String(viewProduct.amount)
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
                                    v-model="sellerData.name"

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
                :witdhScreen="witdhScreen"
                :hotelCodCRT="crt"
                @close="showGridEmit()"
                @update:selectProducts="updateProductsSeletion($event)"
            />
        </div>
    </div> <!-- SHOW PAGE -->
</template>

<script setup lang="ts">
    import PaymentsForm from 'src/components/PaymentsForm.vue';
    import ProductsSelectionView from 'src/components/Products/ProductsSelectionView.vue';
    import CashClosing from 'src/components/PDV/CashClosing/CashClosing.vue'
    import ConfigPDV from 'src/components/Config/ConfigPDV.vue';
    import ProductsSearchBar from 'src/components/Products/ProductsSearchBar.vue';
    import CustomerSearchBar from 'src/components/Search/CustomerSearchBar.vue';
    import ErrorsModal from 'src/components/PDV/Errors/ErrorsModal.vue';
    import LoandingPage from 'src/components/Loanding/LoandingPage.vue';
    
    import { api } from "src/boot/axios"
    import { ref, computed, watch, defineProps, onMounted } from 'vue'   
    import { useRoute, useRouter } from 'vue-router';
    import { useQuasar, LocalStorage } from 'quasar';

    const props = defineProps<{
        idPDV?: number;
    }>();

    const $q = useQuasar();
    const route = useRoute();
    const router = useRouter();
    let timer: any;

    let showPage = ref<boolean>(false);
    
    let productsSeletion = ref<IProducts[][]>([]);

    let errorsOfSale = ref<TErrorsOfSale>({
        showErrosModal: false,
        erros: []

    });
            
    let emitProducts = ref<IEmitProducts>({
        addition: 0,
        discount: 0,
        freight: 0,
        userID: 0
        
    });

    let crt = ref<number>(0);

    const sellerData = ref<Iseller>({
        id: 0,
        name: ''
    });

    const customerData = ref<Icustomer>({
        id: 1,
        name: 'Consumidor Padrão'
    });

    let totalOperation = ref<number>(0);
    let witdhScreen = ref<number>(0);
    let textSize = ref<number>(4);
    let pdvID = ref<number>( 0);
    let show = ref<boolean>(false);
    let showGrid = ref<boolean>(true);
    let showPaymentsForm = ref<boolean>(false);
    let showProductsSearch = ref<boolean>(true);
    let showCashClosing = ref<boolean>(false);
    
    let showOptionsPDV = ref<boolean>(false);
    
    let viewProduct = ref<TViewProduct>({
        show: false,
        id: 0,
        amount: 0,
        salePrice: 0
    });

    let isOpenedPDV = ref<boolean>(false);
    let typeOperation = ref<string>('');
    let csosncst = ref<string>('');
            
    let configs = ref<Tconfig>({
        nmFinaly: false,
        saleNegativeorReset: false
    });

    const issuer_id = ref<number>(LocalStorage.getItem("issuer_id"));

    const showLoading = () => {
        $q.loading.show({
            message: 'Carregando pagamento e validando a venda ...'
        });

        timer = setTimeout(() => {
            $q.loading.hide()
            timer = void 0
        }, 3000);
    };

    const hideLoanding = () => {
        if(timer !== void 0) {
            clearTimeout(timer)
            $q.loading.hide();

        };
    };
    
    watch(
        () => route.fullPath,
        (to, from) => {
            if(to === '/sale/pdv') productsSeletion.value = [];
            return;
        }
    );
        
    const calculateTotal = computed(() => {
        let subtotal: number = 0;

        productsSeletion.value.forEach((products: IProducts[]) => {
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
                    customer_id: customerData.value.id >= 1 ? customerData.value.id : 1,
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
                    alert('Venda guardarda para enviar posteriormente!');
                    productsSeletion.value = [];// Salva apenas a venda = [];

                } else {
                    console.log(response.data);
                }

            } else {

                alert('Venda guardarda para enviar posteriormente!');
                productsSeletion// Salva apenas a venda = []
                router.push({ name: "PDV" });
            };
        };
    };
    
    const finalizeSale = async (type: string) => 
    {
        showLoading()
        try {
            if(sellerData.value.id)
            {
                totalOperation.value += calculateTotal.value.subtotal + calculateTotal.value.freight + calculateTotal.value.addition - calculateTotal.value.discount
                if(props.idPDV)
                {
                    console.log('Venda importada');
                    if(type === 'nm')
                    {
                        typeOperation.value = type;
                        showPaymentsForm.value = !showPaymentsForm.value;
                        pdvID.value = Number(props.idPDV);

                    };

                    if(type === 'nfce')
                    {
                        typeOperation.value = type;
                        showPaymentsForm.value = !showPaymentsForm.value;
                        pdvID.value = Number(props.idPDV);
                    };
                
                } else {
                    let importedPDV = LocalStorage.getItem("pdvID");

                    if(!importedPDV)
                    {
                        console.log('Nova venda!');
                        console.log('Total da venda R$', totalOperation.value);
                        if(type === 'nm')   
                        { 
                            const response = await api.post('/ecommerce/pdv/save-sale', { // Salva apenas a venda
                                issuer_id: issuer_id.value,
                                products: productsSeletion.value, // Produtos da 
                                user_id: sellerData.value.id,
                                customer_id: customerData.value.id >= 1 ? customerData.value.id : 1,
                                total: calculateTotal.value.subtotal - calculateTotal.value.discount + calculateTotal.value.addition,
                                sub_total: calculateTotal.value.subtotal,
                                addition: calculateTotal.value.addition,
                                discount: calculateTotal.value.discount,
                                description: 'Venda Nota Manual N°',
                                is_nfce_nm: type,
                                status: 'Finalizada'
                                
                            });

                            const data = response.data;
                            console.log(data);

                            if(data.success)
                            {
                                LocalStorage.setItem("pdvID", response.data.pdvID);
                                typeOperation.value = type;
                                showPaymentsForm.value = true;
                                pdvID = LocalStorage.getItem("pdvID");
                                console.log('typeOperation linha 682: ', typeOperation.value);
                                console.log('showPaymentsForm linha 683: ', showPaymentsForm.value);
                                console.log('pdvID linha 684: ', pdvID);

                            };
                        
                            if(!data.success)
                            {
                                console.log(response.data); 
                            };
                        };
                    
                        if(type === 'nfce')
                        {  
                            const response = await api.post('/ecommerce/pdv/save-sale', {
                                issuer_id: issuer_id,
                                products: productsSeletion.value, // Produtos da 
                                user_id: sellerData.value.id,
                                customer_id: customerData.value.id >= 1 ? customerData.value.id : 1,
                                total: calculateTotal.value.subtotal - calculateTotal.value.discount + calculateTotal.value.addition,
                                sub_total: calculateTotal.value.subtotal,
                                addition: calculateTotal.value.addition,
                                discount: calculateTotal.value.discount,
                                description: 'Venda NFC-e N°',
                                is_nfce_nm: type,
                                status: 'Finalizada'
                                
                            });

                            console.log('response.dat PDVView, line 718: ', response);
                            const data = response.data;

                            if(data.success)
                            {
                                LocalStorage.setItem("pdvID", response.data.pdvID);
                                typeOperation.value = type;
                                showPaymentsForm.value = true;
                                pdvID = LocalStorage.getItem("pdvID");

                            } else {
                                errorsOfSale.value.erros = data.errors;
                                errorsOfSale.value.showErrosModal = true;

                            };
                        };
                            
                    } else {
                        console.log('Não é uma nova venda!');
                        console.log('Essa venda não foi finalizada, ID: ', LocalStorage.getItem("pdvID"));
                        LocalStorage.getItem("pdvID");
                        showPaymentsForm.value = true;
                    };
                };
                
            } else {
                console.log('Não deu, customerData.id: ', customerData.value.id, ' sellerData.id:', sellerData.value.id);

            };           
        } catch (error) {
            console.error('Erro finalizeSale', error);
            
        } finally {
            hideLoanding();

        };
    };

    const getCRT = async() => 
    {
        try {
            const response = await api.get(`/issuer/companie/${LocalStorage.getItem("issuer_id")}`);

            if(response.data.success === true)
            {
                crt.value += response.data.issuer.cod_crt;
                if(crt.value === 1 || crt.value >= 4)
                {
                    csosncst.value = 'CSOSN';
                } else {
                    csosncst.value = 'CST';
                };
            };

            if(response.data.success === false){
                console.log(response.data)

            }
        } catch (error) {
            if(error.response.data.message === 'Hotel não encontrado')
            {
                router.push('/hotel/create');
                
            };
        };
    };

    const chooseErrors = (choose: string) => 
    {
        console.log('chooseErrors: ', choose);
        if(choose === 'after')
        {
            productsSeletion.value = []
            errorsOfSale.value.showErrosModal = false
        } 

        if(choose === 'now')
        {
            productsSeletion.value = []
            router.push({ path: `${LocalStorage.getItem("issuer_name")}/sale/list-pdv` })
        }

    };

    const importSale = async () =>
    {
        try {
            const response = await api.get(`/ecommerce/pdv/get-saved-sale/${props.idPDV}`)
            console.log('importSale', response.data)
            updateProductsSeletion(response.data.pdvs.get_itens)

        } catch (error) {
            console.error('Erro importSale', error)
            
        }
    };

    const showOptions = () => 
    {
        showOptionsPDV.value = true
        showPaymentsForm.value = false
        showGrid.value = false
        show.value = false
        
    };

    const showProductsSelection = () => 
    {
        showPaymentsForm.value = false
        showGrid.value = !showGrid.value
        show.value = !show.value
        
    };
    
    const showGridEmit = () => 
    {
        showGrid.value = !showGrid.value
        show.value = !show.value
        
    };  

    const closeConfig = (event: boolean) =>
    {
        showOptionsPDV.value = event
        showGrid.value = !event

    };

    const changeAmount = (id: number, newAmount: number) =>
    {
        // const rawProducts = productsSeletion.value
        
        // let productFound = null;
        
        // for (let i = 0; i < rawProducts.length; i++) {
        //const productArray = rawProducts[i];
        //     productFound = productArray.find((p: IProducts) => p.id === id)
            

        //     if(productFound) break

        // }

        // if(productFound)
        // {
        //     productFound.amount = newAmount

        // }
        
    };

    const changeCFOP = (id: number, newCFOP: number) => 
    {
        console.log('Chamou o changeCFOP');
    
        for(let i = 0; i < productsSeletion.value.length; i++)
        {
            for(let k = 0; k < productsSeletion.value[i].length; k++)
            {
                if(productsSeletion[i][k].id === id)
                {
                    productsSeletion[i][k].cfop = newCFOP;
                    return;
                    
                };
            };  
        };

        console.warn('Produto com id', id, 'não encontrado');
    };

    const changeCSOSN = (id: number, newCSOSN: number) =>
    {
        // const rawProducts = productsSeletion.value

        // let productFound = null;
        
        // for (let i = 0; i < rawProducts.length; i++) {
        //     const productArray = rawProducts[i];
        //     productFound = productArray.find(p => p.id === id)
        //     if(productFound) break

        // }

        // if(productFound)
        // {
        //     productFound.csosn = newCSOSN

        // }
    };

    const updateProductsSeletion = (selectedProducts) =>
    {
        console.log('Chamou esse daqui: updateProductsSeletion: ', selectedProducts);
        productsSeletion.value = [...productsSeletion.value, selectedProducts];
        console.log('productsSeletion.value: ', productsSeletion.value);
        
    };

    const updateCustomerSelection = (client: Icustomer) => 
    {  
        customerData.value = {
            id: client.id,
            name: client.name
        };
    };

    const cancelOperation = () => 
    {
        showPaymentsForm.value = false;

    };

    const productOptions = (product_id: number, i: number, action: string) => 
    {
        switch (action) {
            case 'delete':
                console.log('product_id', product_id, ' i: ', i);
                console.log('p: ', productsSeletion.value.map(p => { return p }));

                break;
                
            case 'view':
                
                
                break;

            case 'options':
                
                break;
        
            default:
                break;
        }
    };

    const closeCashClosing = (event: boolean) =>
    {
        showCashClosing.value = event;
    };

    const resetSale = (confirmed: boolean) =>
    {
        if(confirmed)
        {
            emitProducts.value = {
                addition: 0,
                discount: 0,
                freight: 0,
                userID: 0
            };

            productsSeletion.value = [];
            emitProducts.value.addition = 0;
            emitProducts.value.discount = 0;
            emitProducts.value.freight = 0;
            customerData.value.id = null;
            customerData.value.name = null;
            
        };
    };

    const maxlength = (csosncst: string) =>
    {
        if(csosncst == 'csosn')
        {
            return 3;
        } else if (csosncst == 'cst'){
            return 2;
        };
    };

    const cancelSale = () =>
    {
        const option = confirm('Deseja realmente cancelar a venda? ')
        if (option === true) {
            emitProducts.value = {
                addition: 0,
                discount: 0,
                freight: 0,
                userID: 0
            };
            
            productsSeletion.value = [];
            emitProducts.value.addition = 0;
            emitProducts.value.discount = 0;
            emitProducts.value.freight = 0;

            if(props.idPDV)
            {
                router.push({ name: 'PDV' });
            };
        }
    }

    const getUser = async () => 
    { 
        const res = await api.get('/auth/me', {
            headers: {
                'Authorization': `Bearer ${LocalStorage.getItem("auth_token")}`
            }
        });

        sellerData.value ={ 
            id: res.data.user.id,
            name: res.data.user.name
        };
    };

    const getConfig = async () => 
    {
        const res = await api.get(`/config/all-configs/${LocalStorage.getItem("issuer_id")}`);
        configs.value.nmFinaly = res.data.data.pdv[0].nm_finaly;
            
    };

    onMounted(() => {
        getCRT();
        getUser()
        getConfig();
        witdhScreen.value = screen.width;
        isOpenedPDV.value = history.state?.isOpenedPDV ?? false;

        if(props.idPDV)
        {
            importSale();
                
        };

        document.addEventListener('keydown', (event: TEvent) => {
            const keyName = event.key
                
            if(keyName === 'F2')
            {
                showOptions()

            } else if (keyName === 'F8')
            {
                finalizeSale('nm')

            } else if (keyName === 'F9')
            {
                finalizeSale('nfce')
            
            } 
        });

    });
      
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