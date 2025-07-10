<template>
    <div 
        class="mr-14 border border-black mt-5 p-6 bg-white shadow-md rounded"
        :class="{
            'relative top-12 left-12': widthScreen <= 1080,
            'relative top-28 text-xl': widthScreen > 1080
        }"
    >
        <h2 class="border-b border-black text-xl font-semibold mb-4 w-max">Edição do produto: {{ productName }}</h2>
        <q-form
            @submit="submitForm()"
            @reset="onReset"
            class="p-1"
            :class="{ 
                'grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6': widthScreen > 1080
            }"
        >

        <q-input    
                v-model="productDetails.product" 
                type="text" 
                label="Produto"
                color="grey-7"
            />

            <q-select 
                v-model="productDetails.groupID" 
                :options="[1, 2, 3]"
                label="Grupo" 
                filled 
                color="grey-7"
            />

            <q-input    
                v-model="productDetails.amount" 
                type="text" 
                label="Quantidade"
                color="grey-7"
            />

            <q-input    
                v-model="productDetails.costPrice" 
                type="text" 
                label="Preço de custo"
                color="grey-7"
                
            />

            <q-input    
                v-model="productDetails.profitPercentage" 
                type="text" 
                label="Percentual de lucrp"
                color="grey-7"
            />
            
            <q-input    
                v-model="calculateSalePrice"
                type="text" 
                label="Preço de venda R$"
                color="grey-7"
                readonly 
            />

            <q-input    
                v-model="productDetails.cfop" 
                type="text" 
                label="CFOP"
                color="grey-7"
                maxlength="4"
            />
            
            <q-input    
                v-model="productDetails.csosncst" 
                type="text" 
                label="CSOSN/CST"
                color="grey-7"
                maxlength="4"
            />
            
            <q-input    
                v-model="productDetails.ncm" 
                type="text" 
                label="NCM"
                color="grey-7"
                maxlength="8"
            />
            
            <q-input    
                v-model="productDetails.cest" 
                type="text" 
                label="CEST"
                color="grey-7"
                maxlength="7"
            />
            
            <q-input    
                v-model="productDetails.barcode" 
                type="text" 
                label="Cód. Barras"
                color="grey-7"
                maxlength="14"
            />

            <q-input    
                v-model="productDetails.barcode_internal" 
                type="text" 
                label="Cód. Barras Interno"
                color="grey-7"
                maxlength="16"
                
            />
        
            <q-select 
                v-model="productDetails.unit" 
                :options="['UN', 'KG', 'MG', 'ML', 'L']"
                label="Unidade" 
                filled
            />

            <q-file     
                v-model="productDetails.image"   
                label="Imagem"
                color="grey-7"                
                @change="handleFileUpload($event)"
            />
            
            <div
                :class="{
                    'ml-7': widthScreen <= 1080
                }"
            >
                <q-btn type="submit" class="mr-5">
                    <button @click="showLoading('Alterando')">Alterar</button>
                </q-btn>
                
                <q-btn type="button" @click="showLoading('Recarregando')">   
                    <button @click="onReset()">Cancelar</button>
                </q-btn>
            </div>
        </q-form>
    </div>
</template>
  
<script>
    import { api } from 'src/boot/axios';
    import { useQuasar } from 'quasar';
    import { onBeforeUnmount } from 'vue';

export default {
    setup()
    {
        let $q = useQuasar();
        let timer

        onBeforeUnmount(() => { 
            if(timer !== void 0)
            {
                clearTimeout(timer)
                $q.loading.hide()
            }
        })

        return {
            showLoading(message)
            {
                $q.loading.show({
                    message: `${message} dados do produto ...`

                })

                timer = setTimeout(() => {
                    $q.loading.hide()
                    timer = void 0
                }, 4000)
            }
        }
    },

    computed: {
        calculateSalePrice()
        {
            return this.productDetails.salePrice = this.productDetails.costPrice * (1 + this.productDetails.profitPercentage / 
            100).toFixed(2)

        }            
    },  
            
        data() {
            return {
                productDetails: {
                    product: '',
                    image: null,
                    barcode: '',
                    barcode_internal: '',
                    groupID: '',
                    amount: '',
                    costPrice: 0,
                    profitPercentage: 0,
                    salePrice: 0,
                    cfop: '',
                    csosncst: '',
                    ncm: '',
                    cest: '',
                    unit: 'UN',
                    
            },
            showPassword: false,
            
        };
    },
    
    methods: {
        async submitForm() {
            const response = await api.put(`/ecommerce/products/${this.productID}`, this.productDetails);

            console.log(response)
            if(response.data.success)
            {
                alert(`Produto: ${this.productDetails.product}, alterado com sucesso!`)
                this.$emit("close", false)
            } else {
                console.log(this.productDetails.groupID)
                console.error(response.data)
            }
        },

        async getProduct() {
            const product = await api.get(`/ecommerce/products/${this.productID}`)
            const data = product.data.product
            
            this.productDetails = {
                product: data.product,
                barcode: data.barcode,
                barcode_internal: data.barcode_internal,
                groupID: data.group_id,
                amount: data.amount,
                costPrice: data.cost_price,
                profitPercentage: data.profit_percentage,
                salePrice: data.sale_price,
                cfop: data.cfop,
                csosncst: data.csosncst,
                ncm: data.ncm,
                cest: data.cest,
                unit: data.unit,
            }                
        },      

        onReset()
        {
            this.getProduct()
        },

        closeUpdate()
        {
            this.$emit("close", false)
        }
    },

    props: {
        productID: {
            type: Number,
            required: true
            
        },
            
        productName: {
            type: String,
            required: true
        },

        widthScreen: {
            type: Number,
            required: true
            
        },
    },

    emits: [
        'close'
    ],

    mounted()
    {
        this.getProduct()
    }
};
</script>

<style>
    .low {
        right: 7.5rem;
    }
</style>