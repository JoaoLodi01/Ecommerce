<template>
    <div 
        class="ml-14 mr-14 border border-black mt-5 p-6 bg-white shadow-md rounded"
        :class="{
            'relative top-12 left-12': widthScreen <= 1080,
            'ml-72': widthScreen > 1080
        }"
    >
        <h2 class="border-b border-black text-xl font-semibold mb-4 w-max">Cadastro de produtos</h2>
        <q-form
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
                v-model="productDetails.unit" 
                type="text" 
                label="Produto"
                color="grey-7"
                maxlength="4"
            />

            <div>
                <q-btn
                    type="submit" 
                    class="mr-5"
                > 
                    <button>Criar</button> 
                </q-btn>
                    
                <q-btn 
                    @click="onReset()"
                >   
                    <button>Limpar</button>
                </q-btn>
            </div>
        </q-form>
    </div>
</template>

<script>
  export default {
      computed: {
          calculateSalePrice()
          {
            return this.productDetails.salePrice = this.productDetails.costPrice * (1 + this.productDetails.profitPercentage / 
            100).toFixed(2)

          }            
      },  

      props: {
        widthScreen: {
            type: Number,
            required: true
        }
      },

      data()
      {
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
                  
              }
          }
      }
  }

</script>