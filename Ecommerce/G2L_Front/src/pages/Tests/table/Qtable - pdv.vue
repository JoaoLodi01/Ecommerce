<template>
    <div>
        <ProductsSearchBar
            :witdhScreen="1920"
            :locale="'pdv'"
            @update:selectProducts="updateProductsSeletion($event as IProducts)"

        />

    </div>

    <q-table
        class="mb-4 mt-4"
        :rows="productsSeletion"
        :columns="columns"
        hideBottom

    >
        <template v-slot:body="props">
            <q-tr
                :props="props"
            >
                <q-td
                    v-for="col in props.cols"
                    class="text-center"
                >
                    <template v-if="col.name === 'cfop'">
                        <q-input 
                            v-model="props.row.cfop"
                            type="text"
                            inputClass="text-center"
                            maxlength="4"
                            minlength="4"
                            borderless
                            dense
                        />
                    </template>

                    <template v-else-if="col.name === 'csosncst'">
                        <q-input 
                            v-model="props.row.csosncst"
                            type="text"
                            inputClass="text-center"
                            maxlength="4"
                            minlength="4"
                            borderless
                            dense
                        />
                    </template>

                    <template v-else-if="col.name === 'amount'">
                        <q-input 
                            v-model="props.row.amount"
                            inputClass="text-center"
                            type="number"
                            borderless
                            dense
                            @update:modelValue="changeAmount(props.row.product_code, props.row.amount)"
                            class="amountInput"
                        />
                    </template>
                    
                    <template v-else-if="col.name === 'actions'">
                        <div class="m-auto">
                            <button>
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

                            <button>
                                <svg
                                    xmlns="http://www.w3.org/2000/svg"
                                    viewBox="0 0 16 16" fill="currentColor"
                                    class="size-4 text-blue-600 mr-4">
                                    <path fill-rule="evenodd" d="M15 8A7 7 0 1 1 1 8a7 7 0 0 1 14 0ZM8 9a1 1 0 1 0 0-2 1 1 0 0 0 0 2ZM5.5 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0Zm6 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2Z" clip-rule="evenodd"
                                />
                                    options
                                </svg>
                            </button>

                            <button>
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
                    </template>

                    <template v-else>  
                        {{ col.value }}
                    </template>
                </q-td>
            </q-tr>
        </template>
    </q-table>    
</template>

<script setup lang="ts">
    import ProductsSearchBar from 'src/components/Products/ProductsSearchBar.vue';
    import { QTableColumn } from 'quasar';
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

    const columns: QTableColumn[] = [
        {
            name: 'product_code',
            label: 'Cód',
            field: 'product_code',
            align: 'center'
        },
        {
            name: 'product',
            label: 'Produto',
            field: 'product',
            align: 'center'
        }, 
        {
            name: 'cfop',
            label: 'CFOP',
            field: 'cfop',
            align: 'center'
        },
        {
            name: 'sale_price',
            label: 'Preço',
            field: 'sale_price',
            align: 'center',
            format: (val: string) => `R$ ${String(Number(val).toFixed(2)).replace('.', ',')}`
        },
        {
            name: 'csosncst',
            label: 'CSOSN',
            field: 'csosncst',
            align: 'center'
        }, 
        {
            name: 'amount',
            label: 'Qtde',
            field: 'amount',
            align: 'center',
        },
        {
            name: 'total',
            label: 'Total',
            field: (row: ITesteProducts) => row.sale_price * row.amount,
            align: 'center',
            format: (val: string) => `R$ ${String(Number(val).toFixed(2)).replace('.', ',')}`
        },
        {
            name: 'actions',
            label: 'Ações',
            field: 'actions',
            align: 'center'
            
        }
    ];

    const changeAmount = (productCode: number, amount: number) =>
    {   
        console.log('amount: ', amount);
        const newAmount = String(amount).replace(',', '.');

        console.log('Produto alterado: ', productCode, ' nova qtde: ', newAmount);

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
<style lang="scss">
    .q-input input[type=number]::-webkit-inner-spin-button, 
    .q-input input[type=number]::-webkit-outer-spin-button {
        -webkit-appearance: none;
        margin: 0;
    }
</style>