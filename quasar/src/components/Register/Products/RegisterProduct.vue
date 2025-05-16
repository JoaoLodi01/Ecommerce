<template>
    <div
        class="-mt-24 p-6 rounded  "
        :class="{
            'w-screen': widthScreen < 1366,
            'relative top-28 text-xl': widthScreen > 1080
        }"
    >
        <q-form
            @submit="onSubmit"
            class="form-product p-1"
            
        >
            <div class="border p-5 bg-whiteP rounded-md mb-5 ">
                <h4 class="ml-1.5 border-b w-max">Dados cadastrais</h4>
                <q-input
                    v-model="productDetails.product"
                    type="text"
                    label="Produto"
                    color="grey-7"
                    class="m-2"

                />

                <div 
                    class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-2 gap-28"
                >
                    <div class="w-52">
                        <q-input
                            v-model="productDetails.barcode"
                            type="text"
                            label="Cód. Barras"
                            color="grey-7"
                            maxlength="14"
                            minlength="14"
                            class="m-2"
    
                        />

                    </div>

                    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-2">
                        <q-input
                            v-model="productDetails.barcode_internal"
                            type="text"
                            label="Cód. Barras Interno"
                            color="grey-7"
                            maxlength="16"
                            minlength="16"
                            class="m-2"

                        />
                        <q-btn 
                            color="primary" 
                            label="Gerar Cód."
                            class="h-4 w-28 mt-6 mb-auto"
                        />
                    </div>
                </div>
            </div>            

            <div class="border p-5 bg-white rounded-md mb-5 w-[150vh]">
                <h4 class="ml-1.5 border-b w-max">Quantias e valores de vendas</h4>
                <q-input
                    v-model="productDetails.amount"
                    type="text"
                    label="Quantidade"
                    color="grey-7"
                    class="m-2"

                />

                <q-input
                    v-model="productDetails.cost_price"
                    type="text"
                    label="Preço de custo"
                    color="grey-7"
                    class="m-2"

                />

                <q-input
                    v-model="productDetails.profit_percentage"
                    type="text"
                    label="Percentual de lucro"
                    color="grey-7"
                    class="m-2"

                />

                <q-input
                    v-model="calculateSalePrice"
                    type="text"
                    label="Preço de venda R$"
                    color="grey-7"
                    readonly
                    class="m-2"

                />

            </div>

            <div class="border p-5 bg-white rounded-md mb-5 w-[150vh]">
                <h4 class="ml-1.5 border-b w-max">Dados de referência</h4>
                <q-select
                    v-model="productDetails.group_id"
                    :options="allGroup"
                    label="Grupo"
                    filled
                    color="grey-7"
                    class="m-2"

                />

                <q-select
                    v-model="productDetails.unit"
                    :options="['UN', 'KG', 'MG', 'ML', 'L']"
                    label="Unidade"
                    filled
                    class="m-2"

                />
            </div>
            
            <div class="border p-5 bg-white rounded-md mb-5 w-[150vh]">
                <h4 class="ml-1.5 border-b w-max">Dados tributários</h4>

                <q-input
                    v-model="productDetails.cfop"
                    type="text"
                    label="CFOP"
                    color="grey-7"
                    maxlength="4"
                    minlength="4"
                    class="m-2"

                />
                
                <q-input
                    v-model="productDetails.taxable_unit"
                    type="text"
                    label="taxable_unit"
                    color="grey-7"
                    maxlength="4"
                    minlength="4"
                    class="m-2"

                />

                <q-input
                    v-model="productDetails.cest"
                    type="text"
                    label="CEST"
                    color="grey-7"
                    maxlength="7"
                    minlength="7"
                    class="m-2"

                />

                <q-input
                    v-model="productDetails.csosncst"
                    type="text"
                    label="CSOSN/CST"
                    maxlength="3"
                    minlength="3"
                    color="grey-7"
                    class="m-2"

                />

                <NCMSearch
                    @selected="getNCM"

                />

                <div class="border mb-2 rounded-md">
                    <h4 class="ml-2 border-b w-max">ICMS</h4>
                    <q-input 
                        v-model="productDetails.icms_ecf" 
                        type="text" 
                        label="ICMS %" 
                        color="grey-7"
                        class="m-2"
                        v-bind:mask="'##,##'"
                        @update:model-value="replaceICMS"
                    />

                    <q-select 
                        v-model="productDetails.cod_origem_icms" 
                        :options="origensICMS" 
                        label="Origem ICMS" 
                        color="grey-7"
                        class="m-2"
                        
                    />

                </div>

                <div class="border mb-2 rounded-md">
                    <h4 class="ml-2 border-b w-max">IPI</h4>
                    <q-input 
                        v-model="productDetails.aliquot_ipi" 
                        type="text" 
                        label="Aliq. IPI" 
                        color="grey-7"
                        class="m-2"
                        v-bind:mask="'##,##'"
                        @update:model-value="replaceIPI"
                    />

                    <IPISearch
                        @selected="onSelectedIPI($event)"

                    />
                </div>

                <div class="border mb-2 rounded-md">
                    <h4 class="ml-2 border-b w-max">PIS</h4>
                    <q-input 
                        v-model="productDetails.aliquot_pis" 
                        type="text" 
                        label="Aliq. PIS" 
                        color="grey-7"
                        class="m-2"
                        v-bind:mask="'##,##'"
                        @update:model-value="replacePIS"

                    />

                    <PISSearch
                        @selected="onSelectedPIS($event)"

                    />
                </div>

                <div class="border mb-2 rounded-md">
                    <h4 class="ml-2 border-b w-max">COFINS</h4>
                    <q-input 
                        v-model="productDetails.aliquot_cofins" 
                        type="text" 
                        label="Aliq. COFINS" 
                        color="grey-7"
                        class="m-2"
                        v-bind:mask="'##,##'"
                        @update:model-value="replaceCOFINS"

                    />

                    <COFINSSearch
                        @selected="onSelectedCOFINS($event)"
                    />
                </div>

                <div class="">
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
            </div>            
        </q-form>
    </div>
</template>

<script>
    import { LocalStorage, useQuasar } from 'quasar'
    import { onBeforeUnmount, toRaw } from 'vue'
    import { api } from 'src/boot/axios'
    import NCMSearch from 'src/components/Search/Tributs/NCMSearch.vue'
    import PISSearch from 'src/components/Search/Tributs/PISSearch.vue'
    import IPISearch from 'src/components/Search/Tributs/IPISearch.vue'
    import COFINSSearch from 'src/components/Search/Tributs/COFINSSearch.vue'
    
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
                origensICMS: [
                    { label: '0 - NACIONAL', cod: 0 },
                    { label: '1 - ESTRANGEIRA - IMPORTAÇÃO DIRETA', cod: 1 },
                    { label: '2 - ESTRANGEIRA - ADQUIRIDA NO MERCADO INTERNO', cod: 2 },
                    { label: '3 - NACIONAL - CONTEÚDO DE IMPORTAÇÃO > 40%', cod: 3 },
                    { label: '4 - NACIONAL - PROCESSO PRODUTIVO BÁSICO', cod: 4 },
                    { label: '5 - NACIONAL - CONTEÚDO DE IMPORTAÇÃO <= 40%', cod: 5 },
                    { label: '6 - ESTRANGEIRA - IMPORTAÇÃO DIRETA SEM SIMILAR NACIONAL', cod: 6 },
                    { label: '7 - ESTRANGEIRA - INTERNA SEM SIMILAR NACIONAL', cod: 7 },
                    { label: '8 - NACIONAL - CONTEÚDO DE IMPORTAÇÃO > 70%', cod: 8 }
                ],
    
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
                    issuer_id: LocalStorage.getItem("issuer_id"),
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
                    
                    cod_origem_icms: '',
                    origem_icms: '',
                    icms_ecf: '',
                    taxable_amount: '',
                    taxable_unit: '',
                    tax_benefit: '',
                    cod_ipi: '',
                    aliquot_ipi: 0,
                    cod_pis: '',
                    aliquot_pis: 0,
                    cod_cofins: '',
                    aliquot_cofins: 0,

                },

                allGroup: [],

            }
        },

        methods: {
            handleFileUpload(event) {
                const file = event.target.files[0];
                this.productDetails.image = file;

            },

            getNCM(ncm_event)
            {
                this.productDetails.ncm = ncm_event.ncm
            },
            
            async onSubmit()
            {
                this.showLoading()
                const form = new FormData;
                form.append("issuer_id", this.productDetails.issuer_id)
                form.append("product", this.productDetails.product)
                form.append("image", this.productDetails.image)
                form.append("barcode", this.productDetails.barcode)
                form.append("barcode_internal", this.productDetails.barcode_internal)
                form.append("group_id", this.productDetails.group_id)
                form.append("amount", this.productDetails.amount)
                form.append("cost_price", this.productDetails.cost_price)
                form.append("profit_percentage", this.productDetails.profit_percentage)
                form.append("sale_price", this.productDetails.sale_price)
                form.append("unit", this.productDetails.unit)
                form.append("cfop", this.productDetails.cfop)
                form.append("csosncst", this.productDetails.csosncst)
                form.append("ncm", this.productDetails.ncm)
                form.append("cest", this.productDetails.cest)
                form.append("cod_origem_icms", this.productDetails.cod_origem_icms.cod)
                form.append("origem_icms", this.productDetails.cod_origem_icms.label)
                form.append("icms_ecf", this.productDetails.icms_ecf)
                form.append("cod_pis", this.productDetails.cod_pis)
                form.append("aliquot_pis", this.productDetails.aliquot_pis)
                form.append("cod_cofins", this.productDetails.cod_cofins)
                form.append("aliquot_cofins", this.productDetails.aliquot_cofins)
                form.append("cod_ipi", this.productDetails.cod_ipi)
                form.append("aliquot_ipi", this.productDetails.aliquot_ipi)
                form.append("taxable_unit", this.productDetails.taxable_unit)

                console.log(this.productDetails)

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

            },

            onSelectedCOFINS(cod_cofins)
            {
                this.productDetails.cod_cofins = parseInt(cod_cofins.cod)
            },

            onSelectedPIS(cod_pis)
            {
                this.productDetails.cod_pis = parseInt(cod_pis.cod)
            },
            
            onSelectedIPI(cod_ipi)
            {
                this.productDetails.cod_ipi = parseInt(cod_ipi.cod)
            },

            replaceICMS()
            {
                this.productDetails.icms_ecf = parseFloat(this.productDetails.icms_ecf.replace(',', '.'))
            },

            replaceCOFINS()
            {
                this.productDetails.aliquot_cofins = parseFloat(this.productDetails.aliquot_cofins.replace(',', '.'))
            },

            replacePIS()
            {
                this.productDetails.aliquot_pis = parseFloat(this.productDetails.aliquot_pis.replace(',', '.'))
            },

            replaceIPI()
            {
                this.productDetails.aliquot_ipi = parseFloat(this.productDetails.aliquot_ipi.replace(',', '.'))
            },

        },

        emits: [
            'close'
        ],

        components: {
            NCMSearch,
            COFINSSearch,
            PISSearch,
            IPISearch
        },

        mounted(){
            this.getGroups()

        }
    }
</script>

<style lang="scss">
    
    
</style>