<template>
    <div
        class="border border-black -mt-24 p-6 shadow-md rounded "
        :class="{
            'relative top-12 left-12': widthScreen <= 1080,
            'relative top-28 text-xl': widthScreen > 1080
        }"
    >
        <h2 class="border-b border-black text-xl font-semibold mb-4 w-max">Cadastro de produtos</h2>
        <q-form
            @submit="onSubmit"
            class="form-product p-1"
            
        >
            <div class="border border-black p-5 bg-white rounded-md mb-5">
                <h4 class="ml-1.5 border-b w-max">Dados cadastrais</h4>
                <q-input
                    v-model="productDetails.product"
                    type="text"
                    label="Produto"
                    color="grey-7"
                    class="m-2"
                />

                <q-input
                    v-model="productDetails.barcode"
                    type="text"
                    label="Cód. Barras"
                    color="grey-7"
                    maxlength="14"
                    minlength="14"
                    class="m-2"

                />

                <q-input
                    v-model="productDetails.barcode_internal"
                    type="text"
                    label="Cód. Barras Interno"
                    color="grey-7"
                    maxlength="16"
                    class="m-2"
                />

            </div>            

            <div class="border border-black p-5 bg-white rounded-md mb-5">
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

            <div class="border border-black p-5 bg-white rounded-md mb-5">
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
            
            <div class="border border-black p-5 bg-white rounded-md mb-5">
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

                <q-select 
                    v-model="productDetails.origem_icms" 
                    :options="origensICMS" 
                    label="Origem ICMS" 
                    color="grey-7"
                    class="m-2"
                    @update:model-value="checkOrigem()"
                />

                <div class="border mb-2">
                    <h4 class="ml-2 border-b w-max">IPI</h4>
                    <q-select 
                        v-model="productDetails.origem_icms" 
                        :options="codsIPI" 
                        label="Cód IPI" 
                        color="grey-7"
                        class="m-2"
                        @update:model-value="checkOrigem()"
                    />


                </div>

                <div class="border mb-2">
                    <h4 class="ml-2 border-b w-max">PIS</h4>
                    <q-select 
                        v-model="productDetails.origem_icms" 
                        :options="codsPIS" 
                        label="Origem PIS" 
                        color="grey-7"
                        class="m-2"
                        @update:model-value="checkOrigem()"
                    />
                </div>

                <div class="border mb-2">
                    <h4 class="ml-2 border-b w-max">COFINS</h4>
                    <q-select 
                        v-model="productDetails.origem_icms" 
                        :options="codsCOFINS" 
                        label="Cód" 
                        color="grey-7"
                        class="m-2"
                        @update:model-value="checkOrigem()"

                    />
                </div>

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
        </q-form>
    </div>
</template>

<script>
    import { LocalStorage, useQuasar } from 'quasar'
    import { onBeforeUnmount, toRaw } from 'vue'
    import { api } from 'src/boot/axios'
    import NCMSearch from 'src/components/Search/Tributs/NCMSearch.vue'
    
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

                codsIPI: [
                    { label: "00 - ENTRADA COM RECUPERAÇÃO DE CRÉDITO", cod: "00" },
                    { label: "01 - ENTRADA TRIBUTADA COM ALÍQUOTA ZERO", cod: "01" },
                    { label: "02 - ENTRADA ISENTA", cod: "02" },
                    { label: "03 - ENTRADA NÃO TRIBUTADA", cod: "03" },
                    { label: "04 - ENTRADA IMUNE", cod: "04" },
                    { label: "05 - ENTRADA COM SUSPENSÃO", cod: "05" },
                    { label: "49 - OUTRAS ENTRADAS", cod: "49" },
                    { label: "50 - SAÍDA TRIBUTADA", cod: "50" },
                    { label: "51 - SAÍDA TRIBUTADA COM ALÍQUOTA ZERO", cod: "51" },
                    { label: "52 - SAÍDA ISENTA", cod: "52" },
                    { label: "53 - SAÍDA NÃO TRIBUTADA", cod: "53" },
                    { label: "54 - SAÍDA IMUNE", cod: "54" },
                    { label: "55 - SAÍDA COM SUSPENSÃO", cod: "55" }

                ],

                codsPIS: [
                    { label: "01 - OPERAÇÃO TRIBUTÁVEL COM ALÍQUOTA BÁSICA", cod: "01" },
                    { label: "02 - OPERAÇÃO TRIBUTÁVEL COM ALÍQUOTA DIFERENCIADA", cod: "02" },
                    { label: "03 - OPERAÇÃO TRIBUTÁVEL COM ALÍQUOTA POR UNIDADE DE MEDIDA DE PRODUTO", cod: "03" },
                    { label: "04 - OPERAÇÃO TRIBUTÁVEL MONOFÁSICA - REVENDA A ALÍQUOTA ZERO", cod: "04" },
                    { label: "05 - OPERAÇÃO TRIBUTÁVEL POR SUBSTITUIÇÃO TRIBUTÁRIA", cod: "05" },
                    { label: "06 - OPERAÇÃO TRIBUTÁVEL A ALÍQUOTA ZERO", cod: "06" },
                    { label: "07 - OPERAÇÃO ISENTA DA CONTRIBUIÇÃO", cod: "07" },
                    { label: "08 - OPERAÇÃO SEM INCIDÊNCIA DA CONTRIBUIÇÃO", cod: "08" },
                    { label: "09 - OPERAÇÃO COM SUSPENSÃO DA CONTRIBUIÇÃO", cod: "09" },
                    { label: "49 - OUTRAS OPERAÇÕES DE SAÍDA", cod: "49" },
                    { label: "50 - OPERAÇÃO COM DIREITO A CRÉDITO - VINCULADA EXCLUSIVAMENTE A RECEITA TRIBUTADA NO MERCADO INTERNO", cod: "50" },
                    { label: "51 - OPERAÇÃO COM DIREITO A CRÉDITO - VINCULADA EXCLUSIVAMENTE A RECEITA NÃO TRIBUTADA NO MERCADO INTERNO", cod: "51" },
                    { label: "52 - OPERAÇÃO COM DIREITO A CRÉDITO - VINCULADA EXCLUSIVAMENTE A RECEITA DE EXPORTAÇÃO", cod: "52" },
                    { label: "53 - OPERAÇÃO COM DIREITO A CRÉDITO - VINCULADA A RECEITAS TRIBUTADAS E NÃO-TRIBUTADAS NO MERCADO INTERNO", cod: "53" },
                    { label: "54 - OPERAÇÃO COM DIREITO A CRÉDITO - VINCULADA A RECEITAS TRIBUTADAS NO MERCADO INTERNO E DE EXPORTAÇÃO", cod: "54" },
                    { label: "55 - OPERAÇÃO COM DIREITO A CRÉDITO - VINCULADA A RECEITAS NÃO-TRIBUTADAS NO MERCADO INTERNO E DE EXPORTAÇÃO", cod: "55" },
                    { label: "56 - OPERAÇÃO COM DIREITO A CRÉDITO - VINCULADA A RECEITAS TRIBUTADAS E NÃO-TRIBUTADAS NO MERCADO INTERNO, E DE EXPORTAÇÃO", cod: "56" }

                ],

                codsCOFINS: [
                    { label: "01 - OPERAÇÃO TRIBUTÁVEL COM ALÍQUOTA BÁSICA", cod: "01" },
                    { label: "02 - OPERAÇÃO TRIBUTÁVEL COM ALÍQUOTA DIFERENCIADA", cod: "02" },
                    { label: "03 - OPERAÇÃO TRIBUTÁVEL COM ALÍQUOTA POR UNIDADE DE MEDIDA DE PRODUTO", cod: "03" },
                    { label: "04 - OPERAÇÃO TRIBUTÁVEL MONOFÁSICA - REVENDA A ALÍQUOTA ZERO", cod: "04" },
                    { label: "05 - OPERAÇÃO TRIBUTÁVEL POR SUBSTITUIÇÃO TRIBUTÁRIA", cod: "05" },
                    { label: "06 - OPERAÇÃO TRIBUTÁVEL A ALÍQUOTA ZERO", cod: "06" },
                    { label: "07 - OPERAÇÃO ISENTA DA CONTRIBUIÇÃO", cod: "07" },
                    { label: "08 - OPERAÇÃO SEM INCIDÊNCIA DA CONTRIBUIÇÃO", cod: "08" },
                    { label: "09 - OPERAÇÃO COM SUSPENSÃO DA CONTRIBUIÇÃO", cod: "09" },
                    { label: "49 - OUTRAS OPERAÇÕES DE SAÍDA", cod: "49" },
                    { label: "50 - OPERAÇÃO COM DIREITO A CRÉDITO - VINCULADA EXCLUSIVAMENTE A RECEITA TRIBUTADA NO MERCADO INTERNO", cod: "50" },
                    { label: "51 - OPERAÇÃO COM DIREITO A CRÉDITO - VINCULADA EXCLUSIVAMENTE A RECEITA NÃO TRIBUTADA NO MERCADO INTERNO", cod: "51" },
                    { label: "52 - OPERAÇÃO COM DIREITO A CRÉDITO - VINCULADA EXCLUSIVAMENTE A RECEITA DE EXPORTAÇÃO", cod: "52" },
                    { label: "53 - OPERAÇÃO COM DIREITO A CRÉDITO - VINCULADA A RECEITAS TRIBUTADAS E NÃO-TRIBUTADAS NO MERCADO INTERNO", cod: "53" },
                    { label: "54 - OPERAÇÃO COM DIREITO A CRÉDITO - VINCULADA A RECEITAS TRIBUTADAS NO MERCADO INTERNO E DE EXPORTAÇÃO", cod: "54" },
                    { label: "55 - OPERAÇÃO COM DIREITO A CRÉDITO - VINCULADA A RECEITAS NÃO-TRIBUTADAS NO MERCADO INTERNO E DE EXPORTAÇÃO", cod: "55" }

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
                console.log("ncm_event", ncm_event)
                this.productDetails.ncm = ncm_event.ncm
            },

            getCSOSNCST(csosncst_event)
            {
                
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
                form.append("cod_origem_icms", this.productDetails.cod_origem_icms)
                form.append("origem_icms", this.productDetails.origem_icms)
                console.log(this.productDetails)

                /*const response = await api.post('/ecommerce/products/create', form)
                if(response.data.success)
                {
                    this.$emit("close", false)

                } else {
                    console.log(response.data)

                }*/
            },

            async getGroups()
            {
                const response = await api.get(`/ecommerce/products/all-groups/${this.productDetails.issuer_id}`)
                this.allGroup.push(response.data.data)
                let rawGroups = toRaw(this.allGroup)
                console.log(rawGroups)

            },

            checkOrigem()
            {
                this.productDetails.cod_origem_icms = parseInt(this.productDetails.origem_icms.cod)
                this.productDetails.origem_icms = this.productDetails.origem_icms.label
                
            }
        },

        emits: [
            'close'
        ],

        components: {
            NCMSearch
        },

        mounted(){
            this.getGroups()

        }
    }
</script>

<style lang="scss">
    .form-product {
        width: 60vh;
    }
    
</style>