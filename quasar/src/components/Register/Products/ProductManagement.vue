<template>
    <div
        class="border border-black bg-white p-6 shadow-md rounded"
        :class="{
            'w-screen': props.widthScreen < 1366,
            'ml-36 form-customer': props.widthScreen > 1366
        }"

    >
        <q-form
            @submit="onSubmit()"

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
                            :rules="[
                                val => !isNaN(Number(val)) || 'Esse campo precisa ser um número'

                            ]"
                        />
                    </div>

                    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-2">
                        <q-input
                            v-model="productDetails.barcodeInternal"
                            type="text"
                            label="Cód. Barras Interno"
                            color="grey-7"
                            maxlength="16"
                            minlength="16"
                            class="m-2"

                        />

                        <q-btn 
                            label="Gerar Cód."
                            class="h-4 w-28 mt-6 mb-auto"
                            :style="`background-color: ${buttonColor}; color: ${textColor ?? '#fff'}`"
                            @click="generateCode()"
                        />
                        
                    </div>
                </div>
            </div>            

            <div class="border border-black p-5 bg-white rounded-md mb-5">
                <h4 class="ml-1.5 border-b w-max">Quantias e valores de vendas</h4>
                <q-input
                    v-model="productDetails.amount"
                    type="text"
                    label="Quantidade"
                    color="grey-7"
                    class="m-2"
                    :rules="[
                        val => !isNaN(Number(val)) || 'Esse campo precisa ser um número'
                    ]"

                />

                <q-input
                    v-model="productDetails.costPrice"
                    type="text"
                    label="Preço de custo"
                    color="grey-7"
                    class="m-2"
                    :rules="[
                        val => !isNaN(Number(val)) || 'Esse campo precisa ser um número'

                    ]"

                />

                <q-input
                    v-model="productDetails.profitPercentage"
                    type="text"
                    label="Percentual de lucro"
                    color="grey-7"
                    class="m-2"
                    :rules="[
                        val => !isNaN(Number(val)) || 'Esse campo precisa ser um número'

                    ]"

                />

                <q-input
                    v-model="calculateSalePrice"
                    type="text"
                    label="Preço de venda R$"
                    color="grey-7"
                    readonly
                    class="m-2"
                    :rules="[
                        val => !isNaN(Number(val)) || 'Esse campo precisa ser um número'

                    ]"

                />

            </div>

            <div class="border border-black p-5 bg-white rounded-md mb-5">
                <h4 class="ml-1.5 border-b w-max">Dados de referência</h4>
                <q-select
                    v-model="productDetails.groupId"
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
                    :rules="[
                        val => !isNaN(Number(val)) || 'Esse campo precisa ser um número'

                    ]"

                />
                
                <q-input
                    v-model="productDetails.taxableUnit"
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
                    :rules="[
                        val => !isNaN(Number(val)) || 'Esse campo precisa ser um número'

                    ]"

                />

                <q-input
                    v-model="productDetails.csosncst"
                    type="text"
                    label="CSOSN/CST"
                    maxlength="3"
                    minlength="3"
                    color="grey-7"
                    class="m-2"
                    :rules="[
                        val => !isNaN(Number(val)) || 'Esse campo precisa ser um número'

                    ]"

                />

                <NCMSearch
                    @selected="getNCM"

                />

                <div class="border mb-2 rounded-md">
                    <h4 class="ml-2 border-b w-max">ICMS</h4>
                    <q-input 
                        v-model="productDetails.icmsEcf" 
                        type="text" 
                        label="ICMS %" 
                        color="grey-7"
                        class="m-2"
                        v-bind:mask="'##,##'"
                        :rules="[
                            val => !isNaN(Number(String(val).replace(',', '.'))) || 'Esse campo precisa ser um número'

                        ]"
                        
                    />

                    <q-select 
                        v-model="textField" 
                        :options="origensICMS" 
                        @update:model-value="replaceICMS"
                        label="Origem ICMS" 
                        color="grey-7"
                        class="m-2"
                        
                    />

                </div>

                <div class="border mb-2 rounded-md">
                    <h4 class="ml-2 border-b w-max">IPI</h4>
                    <q-input 
                        v-model="productDetails.aliquotIpi" 
                        type="text" 
                        label="Aliq. IPI" 
                        color="grey-7"
                        class="m-2"
                        v-bind:mask="'##,##'"
                        @update:model-value="replaceIPI"
                        :rules="[
                            val => !isNaN(Number(String(val).replace(',', '.'))) || 'Esse campo precisa ser um número'

                        ]"
                    />

                    <IPISearch
                        @selected="onSelectedIPI($event)"

                    />
                </div>

                <div class="border mb-2 rounded-md">
                    <h4 class="ml-2 border-b w-max">PIS</h4>
                    <q-input 
                        v-model="productDetails.aliquotPis" 
                        type="text" 
                        label="Aliq. PIS" 
                        color="grey-7"
                        class="m-2"
                        v-bind:mask="'##,##'"
                        @update:model-value="replacePIS"
                        :rules="[
                            val => !isNaN(Number(String(val).replace(',', '.'))) || 'Esse campo precisa ser um número'

                        ]"

                    />

                    <PISSearch
                        @selected="onSelectedPIS($event)"

                    />
                </div>

                <div class="border mb-2 rounded-md">
                    <h4 class="ml-2 border-b w-max">COFINS</h4>
                    <q-input 
                        v-model="productDetails.aliquotCofins" 
                        type="text" 
                        label="Aliq. COFINS" 
                        color="grey-7"
                        class="m-2"
                        v-bind:mask="'##,##'"
                        @update:model-value="replaceCOFINS"
                        :rules="[
                            val => !isNaN(Number(String(val).replace(',', '.'))) || 'Esse campo precisa ser um número'

                        ]"

                    />

                    <COFINSSearch
                        @selected="onSelectedCOFINS($event)"
                    />
                </div>

                <div class="">
                    <q-btn
                        type="submit"
                        class="mr-5"
                        :style="`background-color: ${buttonColor}; color: ${textColor ?? '#fff'}`"
                        :label="props.operation === 'update' ? 'Alterar dados' : 'Criar produto'"
                        :disable="loanding"
                    />

                </div>
            </div>            
        </q-form>
    </div>
</template>

<script setup lang="ts">
    import { LocalStorage, useQuasar } from 'quasar'
    import { ref, onMounted, computed, defineProps } from 'vue'
    import { api } from 'src/boot/axios';
    import NCMSearch from 'src/components/Search/Tributs/NCMSearch.vue'
    import PISSearch from 'src/components/Search/Tributs/PISSearch.vue'
    import IPISearch from 'src/components/Search/Tributs/IPISearch.vue'
    import COFINSSearch from 'src/components/Search/Tributs/COFINSSearch.vue'
    import camelcaseKeys from 'camelcase-keys';

    type TOrigensICMS = {
        label: string,
        cod: number
    };

    interface IProducts
    {
        issuerId: number,
        product: string,
        image: unknown | File,
        barcode: string,
        barcodeInternal: string,
        groupId: string,
        amount: string,
        costPrice: number,
        profitPercentage: number,
        salePrice: number,
        cfop: string,
        csosncst: string,
        ncm: string,
        cest: string,
        unit: string,
        codOrigemIcms: unknown,
        origemIcms: string,
        icmsEcf: number,
        taxableAmount: number,
        taxableUnit: string,
        taxBenefit: string,
        codIpi: string,
        aliquotIpi: number,
        codPis: string,
        aliquotPis: number,
        codCofins: string,
        aliquotCofins: number,

    };

    const emits = defineEmits<{
        (e: 'close', value: boolean)
    }>();
    
    const props = defineProps<{
        widthScreen: number,
        operation: string,
        productCod?: number

    }>();

    const $q = useQuasar();
    const buttonColor = ref<string>(LocalStorage.getItem("buttonColor"));
    const textColor = ref<string>(LocalStorage.getItem("textColor"));

    const origensICMS = ref<TOrigensICMS[]>([
        { label: '0 - NACIONAL', cod: 0 },
        { label: '1 - ESTRANGEIRA - IMPORTAÇÃO DIRETA', cod: 1 },
        { label: '2 - ESTRANGEIRA - ADQUIRIDA NO MERCADO INTERNO', cod: 2 },
        { label: '3 - NACIONAL - CONTEÚDO DE IMPORTAÇÃO > 40%', cod: 3 },
        { label: '4 - NACIONAL - PROCESSO PRODUTIVO BÁSICO', cod: 4 },
        { label: '5 - NACIONAL - CONTEÚDO DE IMPORTAÇÃO <= 40%', cod: 5 },
        { label: '6 - ESTRANGEIRA - IMPORTAÇÃO DIRETA SEM SIMILAR NACIONAL', cod: 6 },
        { label: '7 - ESTRANGEIRA - INTERNA SEM SIMILAR NACIONAL', cod: 7 },
        { label: '8 - NACIONAL - CONTEÚDO DE IMPORTAÇÃO > 70%', cod: 8 }
    ]);
    const allGroup = ref<string[]>([]);

    const productDetails = ref<IProducts>({
        issuerId: LocalStorage.getItem("issuer_id"),
        product: '',
        image: null,
        barcode: '',
        barcodeInternal: '',
        groupId: '',
        amount: '',
        costPrice: 0,
        profitPercentage: 0,
        salePrice: 0,
        cfop: '',
        csosncst: '',
        ncm: '',
        cest: '',
        unit: 'UN',
        
        codOrigemIcms: 0,
        origemIcms: '',
        icmsEcf: 0,
        taxableAmount: 0,
        taxableUnit: '',
        taxBenefit: '',
        codIpi: '',
        aliquotIpi: 0,
        codPis: '',
        aliquotPis: 0,
        codCofins: '',
        aliquotCofins: 0,

    });

    let loanding = ref<boolean>(false);
    let textField = ref<unknown>(null);
                
    const calculateSalePrice = computed(() => 
    {
        return productDetails.value.salePrice = productDetails.value.costPrice * Number((1 + productDetails.value.profitPercentage /
        100).toFixed(2));

    });

    const getNCM = (ncm_event) =>
    {
        productDetails.value.ncm = ncm_event.ncm;
    };

    const onSubmit = async () =>
    {
        loanding.value = true;
        console.log('Dados de envio: ', productDetails.value);
        
        const isUpdate = props.operation === 'update' ? true : false;

        $q.notify({
            color: 'green',
            message: isUpdate ? 'Alterando dados do produto!' : 'Cadastrando um novo produto!',
            position: 'top',
            timeout: 2000

        });

        console.log(props.operation);
        const apiURL = `/ecommerce/products/${isUpdate ? `update/${props.productCod}` : 'create'}`;
        
        const res = isUpdate ? await api.put(apiURL, productDetails.value) : await api.post(apiURL, productDetails.value);
        const data = res.data;
        
        console.log('API_URL: ', apiURL);
        console.log('Data: ', data);

        /*const response = await api.(, productDetails.value);*/
        
        if(data.success)
        {
            $q.notify({
                color: 'green',
                message: isUpdate ? 'Produto alterando com sucesso!' : 'Produto cadastrado com sucesso!',
                position: 'top',
                timeout: 2000

            });

            emits('close', true);

        } else { };

        loanding.value = false;
    };       
    
    const onSelectedCOFINS = (cod_cofins) =>
    {
        productDetails.value.codCofins = cod_cofins.cod;
    };

    const onSelectedPIS = (cod_pis) =>
    {
        productDetails.value.codPis = cod_pis.cod;
    };
    
    const onSelectedIPI = (cod_ipi) =>
    {
        productDetails.value.codIpi = cod_ipi.cod;
    };

    const replaceICMS = () =>
    {
        console.log('Vai organizaro ICMS');
        const data = textField.value as TOrigensICMS;

        productDetails.value.codOrigemIcms = data.cod;
        productDetails.value.origemIcms = data.label;
        console.log(productDetails.value);

    };

    const replaceCOFINS = () =>
    {
        productDetails.value.aliquotCofins = productDetails.value.aliquotCofins;
    };

    const replacePIS = () =>
    {
        productDetails.value.aliquotPis = productDetails.value.aliquotPis;
    };

    const replaceIPI = () =>
    {
        productDetails.value.aliquotIpi = productDetails.value.aliquotIpi;
    };

    const generateCode = async () =>
    {  
        let randomCode: string = '';
        let exists: boolean = true;
        
        do {
            randomCode = '';
            for (let i = 0; i < 16; i++) {            
                const digit = Math.floor(Math.random() * 10);
                randomCode += digit.toString();

            };

            try {
                const res = await api.get(`/ecommerce/products/last-bar_cod/${productDetails.value.issuerId}/${randomCode}`);

                const data = camelcaseKeys(res.data.data, { deep: true });

                exists = !!data;
                console.log(`Código ${randomCode} ${exists ? 'Já existe' : 'é úncio'}`);

            } catch (error) {
                alert('fodeu kj');
                exists = true;
            }

        } while (exists);
        
        productDetails.value.barcodeInternal = randomCode;

    };

    const getProductData = async () =>
    {
        loanding.value = true;
        $q.notify({
            color: 'green',
            message: 'Carregando dados ...',
            position: 'top',
            timeout: 2000
        });
        console.log('getProductData');
        const res = await api.get(`/ecommerce/products/${productDetails.value.issuerId}/${props.productCod}`);
        const data: IProducts = camelcaseKeys(res.data.data, { deep: true });

        console.log(data);

        if(res.data.success)
        {
            productDetails.value = {
                issuerId: data.issuerId,
                product: data.product,
                image: null,
                barcode: data.barcode,
                barcodeInternal: data.barcodeInternal,
                groupId: data.groupId,
                amount: data.amount,
                costPrice: data.costPrice,
                profitPercentage: data.profitPercentage,
                salePrice: data.salePrice,
                cfop: data.cfop,
                csosncst: data.csosncst,
                ncm: data.ncm,
                cest: data.cest,
                unit: data.unit,
                
                codOrigemIcms: data.codOrigemIcms,
                origemIcms: data.origemIcms,
                icmsEcf: data.icmsEcf,
                taxableAmount: data.taxableAmount,
                taxableUnit: data.taxableUnit,
                taxBenefit: data.taxBenefit,
                codIpi: data.codIpi,
                aliquotIpi: data.aliquotIpi,
                codPis: data.codPis,
                aliquotPis: data.aliquotPis,
                codCofins: data.codCofins,
                aliquotCofins: data.aliquotCofins,
            };

            textField.value = `${data.codOrigemIcms} - ${data.origemIcms}`;
        };
    };

    onMounted(async () => {
        props.operation === 'update' ? await getProductData() : null;

    })
</script>

<style lang="scss">
    .form-customer {
        width: 150vh;
    }
    
    .slide-up-enter-from {
        opacity: 0;
        transform: translateY(-50px);

    }

    .slide-up-enter-to {
        opacity: 1;
        transform: translateY(0);
        
    }

    .slide-up-enter-active {
        transition: all 0.5s ease-out;
    }
</style>