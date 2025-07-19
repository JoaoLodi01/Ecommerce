<template>
    <div v-if="!showPage">
        <LoandingPage
            @show-page="showPage = $event"
            :text="'Carregando PDV ...'"
                        
        />

    </div>

    <div>
        <ConfirmPage
            v-if="showConfirm"
            :operation="operation"
            @confirm="handleOperation($event)"
        />  

        <PaymentsForm
            v-if="showPaymentsForm && typeOperation && pdvID"
            :witdhScreen="witdhScreen"
            :typeOperation=typeOperation
            :totalOperation=totalOperation
            :pdvID=pdvID 
            :room-i-d="0"
            @resetTotal="totalOperation = $event"
            @resetPDVID="pdvID = $event"
            @close="cancelOperation"
            @update:selectProducts="resetSale()"

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
    
    <div 
        v-if="showPage"

    > <!-- SHOW PAGE -->
        <div
            class="mx-auto rounded-lg mt-3 bg-white max-w-[200vh] border border-black" 
            v-if="showGrid"
            :class="{
                'flex ml-16': witdhScreen > 1080 && witdhScreen >= 1472,
                'relative left-10': witdhScreen <= 1080,
                
                'text-xl': textSize === 4,
                'text-2xl': textSize === 8,
                'text-3xl': textSize === 16,
                
            }"   
        >   
            <div class="max-h-auto">
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
                            <button 
                                @click="showOptions" 
                                class="p-1 mr-5 rounded-lg"
                                :style="`background-color: ${buttonColor}; color: ${textColor === '#ffffff' ? '#000' : '#ffffff'}`"
                            >
                                Configurações
                            </button>
                            <button 
                                class="p-1 mr-5 rounded-lg"
                                :style="`background-color: ${buttonColor}; color: ${textColor === '#ffffff' ? '#000' : '#ffffff'}`"
                            >
                                <router-link to="/sale/list-pdv">Voltar para a listagem</router-link>
                            </button>

                            <button 
                                @click="closeCashClosing(true)" 
                                class="p-1 mr-5 rounded-lg"
                                :style="`background-color: ${buttonColor}; color: ${textColor === '#ffffff' ? '#000' : '#ffffff'}`"
                            >
                                Fechamento
                            </button>

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
                    
                    <div>
                        <ProductsSearchBar
                            v-if="showProductsSearch"
                            :witdhScreen="witdhScreen"
                            :locale="'pdv'"
                            @update:selectProducts="updateProductsSeletion($event as IProducts)"

                        />

                    </div>
                </div>
    
                <div 
                    class="m-5 shadow-lg overflow-y-auto border border-black h-[48rem]" 
                >
                     <table>
                        <thead 
                            class="uppercase shadow-lg sticky top-0 z-10 bg-white"
                        >
                            <tr class="">
                                <th scope="col" class="px-6 py-3">Cód.</th>
                                <th scope="col" class="px-6 py-3 text-left">Produto</th>
                                <th v-if="witdhScreen > 1080" scope="col" class="px-6 py-3 text-center">CFOP</th>
                                <th v-if="witdhScreen > 1080" scope="col" class="px-6 py-3 text-center">CSOSN</th>
                                <th v-if="witdhScreen > 1080" scope="col" class="px-6 py-3 text-center">Qtde</th>
                                <th v-if="witdhScreen > 1080" scope="col" class="px-6 py-3 text-center">Valor unitário</th>
                                <th v-if="witdhScreen > 1080" scope="col" class="px-6 py-3">Valor líquido</th>
                                <th scope="col" class="px-6 py-3">Ações</th>
                                
                            </tr>
                        </thead>

                        <tbody>
                            <tr 
                                v-for="(product, i) in productsSeletion" 
                                :key="product.id" 
                                class="border border-black"
                            >   
                                <td class="px-6" scope="row">{{ product.product_code }}</td>
                                <td class="px-6 py-3">{{ product.product}}</td>

                                <td v-if="witdhScreen > 1080"  class="px-6 py-3 text-center">
                                    <q-input 
                                        v-model="product.cfop"
                                        :placeholder=String(product.cfop)
                                        type="text"
                                        inputClass="text-center"
                                        class="w-12 border-b-4 border-b-gray-500"
                                        maxlength="4"
                                        minlength="4"
                                        borderless
                                        dense
                                    />
                                </td>

                                <td v-if="witdhScreen > 1080" class="px-6 py-3 text-center">
                                    <q-input 
                                        v-model="product.csosncst"
                                        :placeholder=String(product.csosncst)
                                        inputClass="text-center"
                                        type="text"
                                        borderless
                                        dense
                                        class="w-10 border-b-4 border-b-gray-500"

                                    />
                                </td>

                                <td v-if="witdhScreen > 1080" class="px-6 py-3 text-center">
                                    <q-input 
                                        v-model="product.amount"
                                        :placeholder="String(product.amount).replace('.', ',')"
                                        inputClass="text-center"
                                        type="text"
                                        borderless
                                        dense
                                        class="w-10 border-b-4 border-b-gray-500"
                                        @update:modelValue="changeAmount(product.product_code, product.amount)"
                                    />
                                </td>

                                <td v-if="witdhScreen > 1080" class="px-6 py-3 text-center">R$ {{ String(product.sale_price.toFixed(2)).replace('.', ',') }}</td>
                                <!--td v-if="witdhScreen > 1080" class="text-center">R$ {{ String(Math.round(product.sale_price * Number(product.amount))).replace('.', ',') }}</td-->
                                
                                <td v-if="witdhScreen > 1080" class="text-center">R$ {{ String(Number(product.sale_price * product.amount).toFixed(2)).replace('.', ',') }}</td>
                                <td class="text-center">
                                    <div class="m-auto">
                                        <button @click="productOptions(product.product, product.product_code, i, 'delete')">
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

                                        <button 
                                            @click="productOptions(product.product, product.product_code, i, 'options')"
                                            
                                        >
                                            <svg
                                                xmlns="http://www.w3.org/2000/svg"
                                                viewBox="0 0 16 16" fill="currentColor"
                                                class="size-4 text-blue-600 mr-4">
                                                <path fill-rule="evenodd" d="M15 8A7 7 0 1 1 1 8a7 7 0 0 1 14 0ZM8 9a1 1 0 1 0 0-2 1 1 0 0 0 0 2ZM5.5 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0Zm6 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2Z" clip-rule="evenodd"
                                            />
                                                options
                                            </svg>
                                        </button>

                                        <button @click="productOptions(product.product, product.product_code, i, 'view')">
                                            <svg 
                                                v-if="witdhScreen < 1080"
                                                xmlns="http://www.w3.org/2000/svg"
                                                fill="none"
                                                viewBox="0 0 24 24" 
                                                stroke-width="1.5" 
                                                stroke="currentColor" 
                                                class="size-4">
                                                <path stroke-linecap="round" stroke-linejoin="round" d="m21 21-5.197-5.197m0 0A7.5 7.5 0 1 0 5.196 5.196a7.5 7.5 0 0 0 10.607 10.607Z" 
                                            />
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
                            @input="changeAmount(viewProduct.id, 2)"
                            
                        />
                    
                    </p>
                </div>
            </div>
        <div>
            </div> <!--Deixa isso daqui como está.-->
                <!-- Barra lateral direita -->
                <div 
                    class="flex max-w-max text-3xl rounded-t-lg rounded-b-lg max-h-[100vh] border"

                    :class="{
                        'text-xl': textSize === 4,
                        'text-2xl': textSize === 8,
                        'text-3xl': textSize === 16,
                        'm-auto': witdhScreen <= 1080
                    }"   
                >
                    <div>
                        <div >
                            <div 
                                class="m-2 p-2 rounded-lg border border-gray-700"
                            >
                                <label class="text-black">Vendedor</label>
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
                            class="m-2 p-1 rounded-lg border border-gray-700" 
                            
                        >
                            <p 
                                class="flex justify-between border mt-2 mb-2 p-2 rounded-lg"
                            >
                                <span class="mt-auto mb-auto text-lg">Acréscimo R$</span>
                                <q-input
                                    v-model="emitProducts.addition"
                                    inputClass="text-right"
                                    type="text"
                                    borderless
                                    dense
                                    maxlength="12"
                                    :disable="productsSeletion.length <= 0"
                                />
                            </p>
                            
                            <p 
                                class="flex justify-between border mt-2 mb-2 p-2 rounded-lg"
                            >
                                <span class="mt-auto mb-auto text-lg">Desconto R$</span>

                                <q-input
                                    v-model="emitProducts.discount"
                                    inputClass="text-right"
                                    type="text"
                                    borderless
                                    dense
                                    maxlength="12"
                                    :disable="productsSeletion.length <= 0"
                                />
                            </p>
                                                    
                            <p 
                                class="flex justify-between border p-2 rounded-lg"
                            >
                                <span class="mt-auto mb-auto text-lg">Frete R$</span>
                                
                                <q-input
                                    v-model="emitProducts.freight"
                                    inputClass="text-right"
                                    type="text"
                                    borderless
                                    dense
                                    maxlength="12"
                                    :disable="productsSeletion.length <= 0"
                                />                            
                            </p>
                        </div>
                    <div
                        class="m-2 p-2 rounded-lg border border-gray-700"
                        id="total"

                    >
                        <p class="flex justify-between">Subtotal <span>R$  {{ String(calculateTotal.subtotal.toFixed(2)).replace('.', ',') }}</span></p>
                        <p class="flex justify-between">Desconto <span>R$ {{ String(calculateTotal.discount.toFixed(2)).replace('.', ',') }}</span></p>
                        <p class="flex justify-between">Acréscimo <span>R$ {{ String(calculateTotal.addition.toFixed(2)).replace('.', ',') }}</span></p>
                        <p class="flex justify-between">Frete <span>R$ {{ String(calculateTotal.freight.toFixed(2)).replace('.', ',') }}</span></p>
                    
                    </div>
                    
                    <div 
                        class="flex border justify-center h-[250px]"
                    >
                        <img 
                            width="250px"                          
                            class="cursor-pointer"
                            :src="`http://192.168.1.106:8000${configs.img}`"
                            alt="Logo não encontrada"
                            @click="alterLogo"
                            title="Altere sua logo aqui!"
                            
                        />
                        
                    </div>
                    <!-- A imagem vai ter que ficar por aqui -->
                        <div class="m-2">
                            <div class="flex m-2 p-2 rounded-lg border border-gray-700">
                                <button
                                    v-if="productsSeletion.length <= 0"
                                    disabled
                                    title="Sem vendas no momento"
                                    class="mr-1 ml-2 rounded-md"
                                    :style="`background-color: ${buttonColor}; color: ${textColor === '#ffffff' ? '#000' : '#ffffff'}`"
                                    
                                >
                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                                        <path stroke-linecap="round" stroke-linejoin="round" d="m14.74 9-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 0 1-2.244 2.077H8.084a2.25 2.25 0 0 1-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 0 0-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 0 1 3.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 0 0-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 0 0-7.5 0" />
                                    </svg>
                                </button>

                                <button
                                    v-else @click="confirmOperation('cancelSale')"
                                    class="mr-1 ml-2 rounded-md"
                                    :style="`background-color: ${buttonColor}; color: ${textColor === '#ffffff' ? '#000' : '#ffffff'}`"
                                >
                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                                        <path stroke-linecap="round" stroke-linejoin="round" d="m14.74 9-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 0 1-2.244 2.077H8.084a2.25 2.25 0 0 1-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 0 0-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 0 1 3.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 0 0-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 0 0-7.5 0" />
                                    </svg>
                                </button>

                                <button
                                    v-if="productsSeletion.length <= 0"
                                    disabled
                                    title="Sem vendas no momento"
                                    class="mr-1 ml-2 rounded-md"
                                    :style="`background-color: ${buttonColor}; color: ${textColor === '#ffffff' ? '#000' : '#ffffff'}`"
                                >
                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                                        <path stroke-linecap="round" stroke-linejoin="round" d="M17.593 3.322c1.1.128 1.907 1.077 1.907 2.185V21L12 17.25 4.5 21V5.507c0-1.108.806-2.057 1.907-2.185a48.507 48.507 0 0 1 11.186 0Z" />
                                    </svg>
                                </button>
                                <button 
                                    class="mr-1 ml-2 rounded-md"
                                    :style="`background-color: ${buttonColor}; color: ${textColor === '#ffffff' ? '#000' : '#ffffff'}`"
                                    title="Salvar venda"
                                    @click="confirmOperation('saveSale')"
                                    v-else
                                >
                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                                        <path stroke-linecap="round" stroke-linejoin="round" d="M17.593 3.322c1.1.128 1.907 1.077 1.907 2.185V21L12 17.25 4.5 21V5.507c0-1.108.806-2.057 1.907-2.185a48.507 48.507 0 0 1 11.186 0Z" />
                                    </svg>
                                </button>

                                <div class="mb-auto ml-auto text-xl w-auto">
                                    <span class="mr-1 text-black p-1 rounded-md">Total: R$ {{ String(Math.max((calculateTotal.total), 0).toFixed(2)).replace('.', ',') }}</span>
                                
                                </div>
                            </div>

                            <div 
                                class="flex justify-between text-white rounded-lg border border-gray-700 w-[26.2rem] p-1"
                            
                            >
                                <q-btn 
                                    class="rounded-md border-none"                                
                                    :style="`background-color: ${buttonColor}; color: ${textColor === '#ffffff' ? '#000' : '#ffffff'}`"
                                    :class="{
                                        'ml-4': witdhScreen > 1080 && witdhScreen <= 1920 && configs.nmFinaly
                                    }" 

                                    @click="finalizeSale('nm')"
                                    v-if="configs.nmFinaly"
                                    label="Finalizar veda"

                                />
                                    
                                <q-btn  
                                    class="rounded-md border-none"                                
                                    :style="`background-color: ${buttonColor}; color: ${textColor === '#ffffff' ? '#000' : '#ffffff'}`"
                                    :class="{
                                        'ml-8': witdhScreen > 1080 && witdhScreen <= 1920 && configs.nmFinaly
                                    }" 
                                    label="Finalizar e emitir NFC-e"
                                    @click="finalizeSale('nfce')" 
                                    
                                />
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

            <SupervisorPasswordDeleteItem
                v-if="showSupervisorPassword"
                
            />

            <OptionsProduct
                v-if="isOption"
                :productName="selectedProductName"
                @apply="handleProductOptions($event)"
                @close="isOption = !$event"

            />

            <ImportFiles 
                v-if="importLogo"
                :operation="'alterLogo'"
                @close="importLogo = !$event"

            />

            <!--<ProductsSelectionView
                v-if="show"
                :witdhScreen="witdhScreen"
                :hotelCodCRT="crt"
                @close="showGridEmit()"
                @update:selectProducts="updateProductsSeletion($event)"
            />-->
        </div>
    </div> <!-- SHOW PAGE -->
</template>

<script setup lang="ts">
    //import ProductsSelectionView from 'src/components/Products/ProductsSelectionView.vue';
    import PaymentsForm from 'src/components/PaymentsForm.vue';
    import ImportFiles from 'src/components/Files/ImportFiles.vue';
    import CashClosing from 'src/components/PDV/CashClosing/CashClosing.vue'
    import ConfigPDV from 'src/components/Config/ConfigPDV.vue';
    import ProductsSearchBar from 'src/components/Products/ProductsSearchBar.vue';
    import CustomerSearchBar from 'src/components/Search/CustomerSearchBar.vue';
    import ErrorsModal from 'src/components/PDV/Errors/ErrorsModal.vue';
    import LoandingPage from 'src/components/Loanding/LoandingPage.vue';
    import SupervisorPasswordDeleteItem from 'src/components/SupervisorPassword/SupervisorPasswordDeleteItem.vue';
    import OptionsProduct from 'src/components/Products/OptionsInSale/OptionsProduct.vue';
    import ConfirmPage from 'src/components/Confirm/ConfirmPage.vue';
    import { api } from "src/boot/axios"
    import { ref, watch, computed, onMounted, onUnmounted } from 'vue'   
    import { useRoute, useRouter } from 'vue-router';
    import { useQuasar, LocalStorage } from 'quasar';
    import camelcaseKeys from 'camelcase-keys';

    const props = defineProps<{
        idPDV?: number;
    }>();

    const $q = useQuasar();
    const route = useRoute();
    const router = useRouter();
    const issuer_id = ref<number>(LocalStorage.getItem("issuer_id"));
    const buttonColor = LocalStorage.getItem("buttonColor");
    const textColor = LocalStorage.getItem("textColor");

    const sellerData = ref<Iseller>({
        id: 0,
        name: ''
    });

    const customerData = ref<Icustomer>({
        id: 1,
        name: 'Consumidor Padrão'
    });

    const configs = ref<Tconfig>({
        nmFinaly: false,
        saleNegativeorReset: false,
        supervisorPasswordCancelSale: false,
        supervisorPasswordDeleteItem: false,
        img: '/public/image/defaultLogo.png'

    });

    let isOption = ref<boolean>(false); // mudar para false
    let showPage = ref<boolean>(false);
    
    let productsSeletion = ref<IProducts[]>([]);

    let errorsOfSale = ref<TErrorsOfSale>({
        showErrosModal: false,
        erros: []

    });
            
    let emitProducts = ref<IEmitProducts>({
        subtotal: 0,
        addition: 0,
        discount: 0,
        freight: 0
        
    });

    let crt = ref<number>(0);
    let totalOperation = ref<number>(0);
    let witdhScreen = ref<number>(0);
    let textSize = ref<number>(4);
    let pdvID = ref<number>(0);
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
            
    let selectedProductName = ref<string>('');
    let selectedProductCode = ref<number>(0);

    let showSupervisorPassword = ref<boolean>(false);
    let importLogo = ref<boolean>(false);
    let subTotal = ref<number>(0);

    let operation = ref<string>('');
    let showConfirm = ref<boolean>(false);

    watch(
        () => route.fullPath,
        (to, from) => {
            if(to === '/sale/pdv') productsSeletion.value = [];
            return;
        }
    );    

    const calculateTotal = computed(() => {
        subTotal.value = 0;

        productsSeletion.value.map((p: IProducts) => {
            subTotal.value += p.sale_price * p.amount;
        });

        /*
            const addition: number = typeof emitProducts.value.addition === 'number' ? emitProducts.value.addition : 0;
            const discount: number = typeof emitProducts.value.discount === 'number' ? emitProducts.value.discount : 0;
            const freight: number = typeof emitProducts.value.freight === 'number' ? emitProducts.value.freight : 0;
        */

        const addition = Number(String(emitProducts.value.addition).replace(/\D/g, '.'));
        const discount = Number(String(emitProducts.value.discount).replace(/\D/g, '.'));
        const freight = Number(String(emitProducts.value.freight).replace(/\D/g, '.'));

        return {
            total: subTotal.value + (addition + freight) - discount,
            subtotal: subTotal.value,
            addition: addition,
            discount: discount,
            freight: freight
        };
    });
    
    const finalizeSale = async (type: string) => 
    {
        console.log('total: ', totalOperation.value)
        try {
            if(sellerData.value.id)
            {
                totalOperation.value += calculateTotal.value.subtotal + calculateTotal.value.freight + calculateTotal.value.addition - calculateTotal.value.discount
                if(props.idPDV)
                {
                    console.log('Venda importada');
                    console.log('type: ', type);
                    typeOperation.value = type;
                    showPaymentsForm.value = !showPaymentsForm.value;
                    pdvID.value = Number(props.idPDV);
                
                } else {
                    let importedPDV = LocalStorage.getItem("pdvID");

                    if(!importedPDV)
                    {
                        console.log('Nova venda!');
                        console.log('Total da venda R$', totalOperation.value);
                        console.log(sellerData.value);
                        if(type)   
                        { 
                            const res = await api.post('/ecommerce/pdv/save-sale', { // Salva apenas a venda
                                issuer_id: issuer_id.value,
                                products: productsSeletion.value, // Produtos da 
                                user_id: sellerData.value.id,
                                customer_id: customerData.value.id != 1 ? customerData.value.id : 1,
                                sub_total: calculateTotal.value.subtotal,
                                total: calculateTotal.value.total,
                                addition: calculateTotal.value.addition,
                                discount: calculateTotal.value.discount,
                                description: '',
                                is_nfce_nm: type,
                                status: 'Finalizada'
                                
                            });

                            const data = res.data.data;
                            console.log(res.data.data);

                            if(data.success)
                            {
                                LocalStorage.setItem("pdvID", data.pdvID);
                                typeOperation.value = type;
                                showPaymentsForm.value = true;
                                pdvID.value = LocalStorage.getItem("pdvID");
                                console.log('typeOperation linha 638: ', typeOperation.value);
                                console.log('showPaymentsForm linha 639: ', showPaymentsForm.value);
                                console.log('pdvID linha 640: ', LocalStorage.getItem("pdvID"));

                            };
                        };
                        
                    } else {
                        console.log('Não é uma nova venda!');
                        console.log('Essa venda não foi finalizada, ID: ', LocalStorage.getItem("pdvID"));
                        showPaymentsForm.value = true;
                        pdvID.value = LocalStorage.getItem("pdvID");

                    };
                };
                
            } else {
                console.log('Não deu, customerData.id: ', customerData.value.id, ' sellerData.id:', sellerData.value.id);

            };           
        } catch (error) {
            console.error('Erro finalizeSale', error);
            
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
    
    const closeConfig = (event: boolean) =>
    {
        showOptionsPDV.value = event
        showGrid.value = !event

    };

    const changeAmount = (productCode: number, amount: number) =>
    {   
        const newAmount = String(amount).replace(',', '.');
        const product = productsSeletion.value.find(p => p.product_code === productCode);
        product.amount = Number(newAmount);

    };

    const updateProductsSeletion = (selectedProducts: IProducts) =>
    {
        const existingProduct = productsSeletion.value.find(
            (p) => 
                p.product_code === selectedProducts.product_code || 
                p.id === selectedProducts.id
        );

        if(existingProduct)
        {
            existingProduct.amount += selectedProducts.amount;

        } else {
            productsSeletion.value = [...productsSeletion.value, {...selectedProducts}];

        };
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

    const handleProductOptions = (data: TReturnValues) =>
    {
        if(selectedProductCode.value !== 0)
        {
            console.log('ID do produto: ', selectedProductCode.value);
            if(data.typeAddition === 'R$')
            {   
                let product = productsSeletion.value.find(p => p.product_code === selectedProductCode.value);
                console.log(product);

                product.sale_price = Number(
                    (Number(product.sale_price) + data.addition - data.discount).toFixed(2)
                );

                isOption.value = false;

            };
        } else {
            $q.notify({
                color: 'red',
                message: 'Código do produto incorreto',
                position: 'top',
                timeout: 1000

            });
        };
    };

    const productOptions = (productName: string, productID: number, i: number, action: string) => 
    {
        switch (action) {
            case 'delete':
                console.log('product_id', productID, ' i: ', i);
                productsSeletion.value = [...productsSeletion.value.filter(p => p.product_code !== productID)]; 
                
                break;
                
            case 'view':
                
                break;

            case 'options':
                isOption.value = true;
                selectedProductName.value = productName;
                selectedProductCode.value = productID;

                break;
        
            default:
                break;
        }
    };

    const closeCashClosing = (event: boolean) =>
    {
        showCashClosing.value = event;
    };

    const resetSale = () =>
    {
        emitProducts.value = {
            subtotal: 0,
            addition: 0,
            discount: 0,
            freight: 0,
            
        };

        typeOperation.value = '';
        totalOperation.value = 0;
        productsSeletion.value = [];
        emitProducts.value.addition = 0;
        emitProducts.value.discount = 0;
        emitProducts.value.freight = 0;
        customerData.value.id = 1;
        customerData.value.name = 'Consumidor Padrão';
        LocalStorage.remove("pdvID");

        console.log('productsSeletion: ', productsSeletion.value);

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

    const handleOperation = async (event: TEmit[]|boolean): Promise<void> =>
    {
        if(operation.value === 'cancelSale')
        {
            emitProducts.value = {
                subtotal: 0,
                addition: 0,
                discount: 0,
                freight: 0
            };
            
            productsSeletion.value = [];
            emitProducts.value.addition = 0;
            emitProducts.value.discount = 0;
            emitProducts.value.freight = 0;

            if(props.idPDV)
            {
                router.push({ name: 'PDV' });
            };
        } else {
            console.log('isOpenedPDV.value ', isOpenedPDV.value);
            if(!isOpenedPDV.value)
            {
                const res = await api.post('/ecommerce/pdv/save-sale', { 
                    issuer_id:  issuer_id.value,
                    products: productsSeletion.value, 
                    user_id: sellerData.value.id,
                    customer_id: customerData.value.id >= 1 ? customerData.value.id : 1,
                    sub_total: calculateTotal.value.subtotal,
                    total: calculateTotal.value.total,
                    addition: calculateTotal.value.addition,
                    discount: calculateTotal.value.discount,
                    description: 'Venda guardada',
                    is_nfce_nm: '',
                    status: 'Em Aberto'
                    
                }, { headers : { 
                    Accept: 'application/json'
                }});
                console.log(res.data);
                if(res.data.success === true)
                {
                    $q.notify({
                        color: 'green',
                        message: 'Sua venda foi guardada para enviar posteriormente!',
                        position: 'top'
                    });
                    productsSeletion.value = [];// Salva apenas a venda = [];

                } else {
                    console.log(res.data);
                };

            };
        };

        showConfirm.value = false;
    };

    const confirmOperation = (option: string) =>
    {
        operation.value = option;
        showConfirm.value = true;
    };

    const getUser = async () => 
    { 
        sellerData.value ={ 
            id: LocalStorage.getItem("user_id"),
            name: LocalStorage.getItem("user_name")
        };
    };

    const getConfig = async () => 
    {
        const res = await api.get(`/configs/all-configs/${LocalStorage.getItem("issuer_id")}`);
        const configsRes: Tconfig = camelcaseKeys(res.data.data.pdv, { deep: true });
        
        console.log(configsRes)

        configs.value.nmFinaly = configsRes.nmFinaly;
        configs.value.supervisorPasswordCancelSale = configsRes.supervisorPasswordCancelSale;
        configs.value.supervisorPasswordDeleteItem = configsRes.supervisorPasswordDeleteItem;
        configs.value.img = configsRes.img

    };

    const alterLogo = async () =>
    {
        importLogo.value = true;

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

        document.addEventListener('keydown', (event: KeyboardEvent) => {
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
    onUnmounted(() => {
        console.log('PDV foi desmontado corretamente')
    })
      
</script>

<style>
    *{
        outline: none;
    }

    #csosnInput::-webkit-outer-spin-button,
    #csosnInput::-webkit-inner-spin-button,
    #addition
    {
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
        max-height: 100vh;
        height: 100vh;
        
    }

</style>