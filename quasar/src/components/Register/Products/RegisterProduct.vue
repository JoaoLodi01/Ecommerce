<template>
    <div
        class="mr-14 border border-black mt-5 p-6 bg-white shadow-md rounded"
        :class="{
            'relative top-12 left-12': widthScreen <= 1080,
            'relative top-28 text-xl': widthScreen > 1080
        }"
    >
        <h2 class="border-b border-black text-xl font-semibold mb-4 w-max">Cadastro de produtos</h2>
        <q-form
            @submit="onSubmit"
            class="p-1"
            :class="{
                'grid grid-cols-2 sm:grid-cols-2 lg:grid-cols-3 gap-10': widthScreen > 1080
            }"
        >
            <q-input
                v-model="productDetails.product"
                type="text"
                label="Produto"
                color="grey-7"
            />

            <q-input
                v-model="productDetails.amount"
                type="text"
                label="Quantidade"
                color="grey-7"
            />

            <q-input
                v-model="productDetails.cost_price"
                type="text"
                label="Preço de custo"
                color="grey-7"

            />

            <q-input
                v-model="productDetails.profit_percentage"
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
                minlength="4"

            />

            <q-input
                v-model="productDetails.csosncst"
                type="text"
                label="CSOSN/CST"
                color="grey-7"
                maxlength="3"
                minlength="3"
            />

            <q-input
                v-model="productDetails.ncm"
                type="text"
                label="NCM"
                color="grey-7"
                maxlength="8"
                minlength="8"
            />

            <q-input
                v-model="productDetails.cest"
                type="text"
                label="CEST"
                color="grey-7"
                maxlength="7"
                minlength="7"
            />

            <q-input
                v-model="productDetails.barcode"
                type="text"
                label="Cód. Barras"
                color="grey-7"
                maxlength="14"
                minlength="14"
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

            <q-select
                v-model="productDetails.group_id"
                :options="allGroup"
                label="Grupo"
                filled
                color="grey-7"
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
    import { api } from 'src/boot/axios'
    import { LocalStorage, useQuasar } from 'quasar'
    import { onBeforeUnmount, toRaw } from 'vue'

    export default {
        setup()
        {
            const $q = useQuasar()
            let timer

            onBeforeUnmount(() => {
                if(timer !== void 0)
                {
                    clearTimeout(timer)
                    $q.loading.hide()

                }
            })
            return {
                showLoading () {
                    $q.loading.show({
                        message: `Criando produto ...`
                    })

                    timer = setTimeout(() => {
                        $q.loading.hide()
                        timer = void 0

                    }, 2000)
                }
            }
        },

        computed: {
            calculateSalePrice()
            {
                return this.productDetails.sale_price = this.productDetails.cost_price * (1 + this.productDetails.profit_percentage /
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
                    image: null,
                    barcode: '',
                    barcode_internal: '',
                    group_id: '',
                    amount: '',
                    cost_price: 0,
                    profit_percentage: 0,
                    sale_price: 0,
                    cfop: '',
                    csosncst: '',
                    ncm: '',
                    cest: '',
                    unit: 'UN',
                    issuer_id: LocalStorage.getItem("issuer_id")

                },

                allGroup: [],

            }
        },

        methods: {
            handleFileUpload(event) {
                const file = event.target.files[0];
                this.productDetails.image = file;

            },
            async onSubmit()
            {
                this.showLoading()
                const form = new FormData;
                form.append("product", this.productDetails.product)
                form.append("image", this.productDetails.image)
                form.append("barcode", this.productDetails.barcode)
                form.append("barcode_internal", this.productDetails.barcode_internal)
                form.append("group_id", this.productDetails.group_id)
                form.append("amount", this.productDetails.amount)
                form.append("cost_price", this.productDetails.cost_price)
                form.append("profit_percentage", this.productDetails.profit_percentage)
                form.append("sale_price", this.productDetails.sale_price)
                form.append("cfop", this.productDetails.cfop)
                form.append("csosncst", this.productDetails.csosncst)
                form.append("ncm", this.productDetails.ncm)
                form.append("cest", this.productDetails.cest)
                form.append("unit", this.productDetails.unit)
                form.append("issuer_id", this.productDetails.issuer_id)

                const response = await api.post('/ecommerce/products/create', form)

                if(response.data.success)
                {
                    this.$emit("close", false)

                } else {
                    console.log(response.data)

                }
            },

            async getGroups()
            {
                const response = await api.get(`/ecommerce/products/all-groups/${this.productDetails.issuer_id}`)
                this.allGroup.push(response.data.data)
                let rawGroups = toRaw(this.allGroup)
                console.log(rawGroups)

            }
        },

        emits: [
            'close'
        ],

        mounted(){
            this.getGroups()

        }
    }
</script>
