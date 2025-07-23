<template>
    <div>
        <ProductsSearchBar
            :witdhScreen="1920"
            :locale="'pdv'"
            @update:selectProducts="updateProductsSeletion($event as IProducts)"

        />

    </div>

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
                
            </tr>
        </tbody>
    </table>  
    
    
</template>

<script setup lang="ts">
    import ProductsSearchBar from 'src/components/Products/ProductsSearchBar.vue';
    import { ref } from 'vue';

    const witdhScreen = 1920;

    interface ITesteProducts 
    {
        id: number,
        product_code: number,
        product: string,
        cfop: number,
        csosncst: number,
        amount: number,
        sale_price: number

    };

    let productsSeletion = ref<ITesteProducts[]>([
        {
            id: 1,
            product_code: 1,
            product: 'aa',
            cfop: 5102,
            csosncst: 102,
            sale_price: 20.00,
            amount: 1
            
        },
        {
            id: 2,
            product_code: 2,
            product: 'bb',
            cfop: 5102,
            csosncst: 102,
            sale_price: 20.00,
            amount: 1
            
        },
    ]);

    const changeAmount = (productCode: number, amount: number) =>
    {   
        const newAmount = String(amount).replace(',', '.');

        console.log('Produto alterado: ', productCode, ' nova qtde: ', );

        const product = productsSeletion.value.find(p => p.product_code === productCode);
        product.amount = Number(newAmount);

        console.table(product);
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
            //console.log('Vai chamar o changeAmount pelo updateProductsSeletion');
            //changeAmount(selectedProducts.product_code, selectedProducts.amount);
            existingProduct.amount += selectedProducts.amount;

        } else {
            productsSeletion.value = [...productsSeletion.value, {...selectedProducts}];

        };

        console.log(productsSeletion.value);
    };

</script>