<template>
     <div 
        class="ml-14 mr-14 border border-black mt-5 p-6 bg-white shadow-md rounded"
        :class="{
            'relative top-12 left-12': widthScreen <= 1080,
            'ml-72': widthScreen > 1080
        }"
    >
        <div class="flex">
            <h2 class="text-xl font-semibold mb-4 w-max">Edição do produto: {{ productName }}</h2>
            <span @click="closeUpdate()" class="cursor-pointer text-xl ml-auto">X</span>
        </div>

        <q-form
            @submit="submitForm()"
            @reset="onReset"
            class="p-1 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6"
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
                v-model="productDetails.unit" 
                type="text" 
                label="Produto"
                color="grey-7"
                maxlength="4"
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
                try {
                    const response = await api.put(`/ecommerce/products/${this.productID}`, this.productDetails);

                    console.log(response)
                    if(response.data.success)
                    {
                        alert(`Produto: ${this.form.name}, alterado com sucesso!`)
                        this.$emit("close", false)
                    }
                        
                } catch (error) {
                    alert("Ocorreu um erro ao alterar o produto.");
                    console.error('Erro', error)
                }
            },

            async getProduct() {
                const product = await api.get(`/ecommerce/products/${this.productID}`)
                const data = product.data.product
                
                this.productDetails = {
                    product: data.product,
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
                this.getCustomer()
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