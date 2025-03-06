<template>
  <button @click="showProdutcts">Todos os produtos</button>
  <button ><a href="/">Voltar</a></button>

  <div class="relative overflow-x-autoauto">
    <table class="text-left rtl:text-right">
            <thead class="uppercase">
                <tr>
                    <th scope="col" class="px-6 py-3">Cód.</th>
                    <th scope="col" class="px-6 py-3">Produto</th>
                    <th scope="col" class="px-6 py-3">CFOP</th>
                    <th scope="col" class="px-6 py-3">Qtde</th>
                    <th scope="col" class="px-6 py-3">Preço venda</th>
                    <th scope="col" class="px-6 py-3">Total</th>
                </tr>
            </thead>
            <div v-for="products in productsSeletion">
                    <tbody>
                        <tr>
                            <div v-for="(product, id) in products" :key="id">
                            
                                <td scope="row" class="px-6 py-3">{{ product.id }}</td>
                                <td class="px-6 py-3">{{ product.produto }}</td>
                                <td class="px-6 py-3">{{ product.cfop }}</td>
                                <td class="px-6 py-3"><input 
                                    v-model="product.quantidade"
                                    :placeholder=product.quantidade
                                    type="number"
                                    class="w-7"
                                    @input="changeAmount(product.id, product.quantidade)"
                                
                                />
                                </td>
                                <td class="px-6 py-3">Valor de venda R$ {{ product.preco_venda }}</td>
                                <td class="px-6 py-3">Total líquid do item: R$ {{ product.preco_venda * product.quantidade }}</td>
                            </div>
                        </tr>
                    </tbody>
                </div>

        </table>
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
    import axios from 'axios';
    import { toRaw } from 'vue'   
    
    export default{
        data(){
            return {
                productsSeletion: [],
                emitProducts: [],
                userDetails: [],
                show: false,
                showPaymentsForm: false,
                typeOperation: '',
                totalOperation: 0,
                api: process.env.VUE_APP_API_URL
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
        },

        mounted(){
            
        }
      }
</script>