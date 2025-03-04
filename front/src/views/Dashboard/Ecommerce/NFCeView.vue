<template>
  <button @click="showProdutcts">Todos os produtos</button>

  <div v-if="productsSeletion.length > 0">
    <div v-for="(products, id) in productsSeletion">
      <div v-for="product in products" :key="id">
        {{ product.produto }}

        <input 
            v-model="product.quantidade"
            :placeholder=product.quantidade
            type="number"
            class="w-7"
            @input="changeAmount(product.id, product.quantidade)"
          
        />
        Valor de venda R$ {{ product.preco_venda }}
        Total líquid do item: R$ {{ product.preco_venda * product.quantidade }}
      </div>
    </div>
  </div>

  <br>
  <button @click="saleNM()" class="m-2 p-2">Finalizar</button>
  <button @click="saleNFCe()" class="m-2 p-2">Finalizar e emitir NFC-e</button>


  <div>
    <ProductsSelectionView
      v-if="show"
      :show="this.show"
      @close="show = false"
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
  
    import { toRaw } from 'vue'

    export default{
        data(){
        return {
            show: false,
            showPaymentsForm: false,
            productsSeletion: [],
            emitProducts: [],
            typeOperation: '',
            totalOperation: 0
        }
        },

        methods: {
            showProdutcts(){
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
                
                const productsSeletionRaw = toRaw(this.productsSeletion)
                for (let i = 0; i < productsSeletionRaw.length; i++) {
                    const productsSeletionArray = productsSeletionRaw[i];
                    productsSeletionArray.forEach(p => {
                        this.totalOperation += toRaw(p.preco_venda) * toRaw(p.quantidade)

                    });
                }
                this.emitProducts = this.productsSeletion
            },

            updateProductsSeletion(selectedProducts)
            {
                this.productsSeletion = [...this.productsSeletion, selectedProducts]
                
            },

            saleNFCe()
            {
                this.typeOperation = 'saleNFCe'
                this.showPaymentsForm = !this.showPaymentsForm
                console.log('emitProducts', this.emitProducts)
                
            },

            saleNM()
            {
                this.typeOperation = 'saleNM'
                this.showPaymentsForm = !this.showPaymentsForm
                console.log('emitProducts', this.emitProducts)
                
            },
            cancelOperation()
            {
                this.showPaymentsForm = false
            },        
        },

        components: {
            ProductsSelectionView,
            PaymentsForm
        }
      }
</script>