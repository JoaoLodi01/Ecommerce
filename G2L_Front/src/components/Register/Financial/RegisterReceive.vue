<template>
  <div
    class="mr-14 mt-5 mb-5 p-6 bg-white"
        :class="{
            'relative top-12 left-12': props.widthScreen <=1080,
            'ml-14': props.widthScreen > 1080
        }"
    >
    <h2 class="border-b border-black text-xl font-semibold mb-4 w-max">{{ title }} recebimentos</h2>

        <form
            @submit.prevent="submitForm"
            class="grid gap-4 mx-auto"
            style="max-width: 1000px;"
            :class="{
                'grid-cols-1 lg:grid-cols-2': widthScreen > 1080,
                'grid-cols-1': widthScreen <= 1080
            }"
        >

            <div class="border border-gray-200 rounded-md p-3 h-auto max-h-[230px] w-auto overflow-auto" v-if="!readonly">
                <div class="flex flex-wrap gap-4">

                    <SpeciesSearchBar
                        @selectSpecie="getSpecie($event)"
                        :module_="'receive'"
                        :disable="props.readonly"
                    />

                    <CustomerSearchBar 
                        @updated:selectCustomer="getCustumer($event)" 
                        :pdv="false"
                        :disable="props.readonly"
                    />

                    <q-input
                        class="w-[100px]"
                        type="number"
                        v-model="form.document"
                        label="Nº Doc"
                        color="grey-7"
                        :readonly="props.readonly"
                    />

                    <q-input
                        class="w-[200px]"
                        type="text"
                        v-model="form.description"
                        label="Descrição"
                        color="grey-7"
                        :readonly="props.readonly"
                    />
                    
                </div>
            </div>

            <div class="border border-gray-200 rounded-md p-3 h-auto max-h-[230px] w-auto overflow-auto" v-if="!readonly">
                <div class="flex flex-wrap gap-4">
                    <q-input
                        class="w-[100px]"
                        type="number"
                        v-model="form.installmentAmount"
                        label="Nº Parcelas"
                        color="grey-7"
                        :disable="!form.especieID"
                        :readonly="props.readonly"
                    />

                    <q-input
                        class="w-[150px]"
                        type="text"
                        v-model="form.installmentValue"
                        label="Valor Parcela"
                        color="grey-7"
                        :disable="!form.especieID"
                        :readonly="props.readonly"
                    />

                    <q-input
                        class="w-[150px]"
                        type="date"
                        v-model="form.dueDate"
                        label="1º Vencimento"
                        color="grey-7"
                        :readonly="props.readonly"
                    />

                    <q-select
                        class="w-[80px]"
                        v-model="form.typeInterest"
                        label="Tipo"
                        emit-value
                        map-options
                        :disable="props.readonly"
                        :options="[
                            { label: '%', value: '%' },
                            { label: 'R$', value: 'R$' }
                        ]"
                        
                    />

                    <q-input
                        class="w-[100px]"
                        type="number"
                        v-model="form.interestValue"
                        label="Juros"
                        color="grey-7"
                        :readonly="props.readonly"
                    />

                    <q-input
                        class="w-[100px]"
                        type="number"
                        v-model="form.addition"
                        label="Acréscimo"
                        color="grey-7"
                        :readonly="props.readonly"
                    />

                    <q-input
                        class="w-[100px]"
                        type="number"
                        v-model="form.discount"
                        label="Desconto"
                        color="grey-7"
                        :readonly="props.readonly"
                    />

                    <q-input
                        class="w-[130px]"
                        type="number"
                        v-model="form.valueEntry"
                        label="Juros a pagar"
                        color="grey-7"
                        readonly
                    />

                </div>
            </div>

            <InstallmentsTable 
                :pdv="false"
                :installments="installments"
                :number="form.installmentNumber"
                :amount="Number(form.installmentAmount)"
                :original-value="form.installmentValue"
                :due-date="form.dueDate"
                :readonly="readonly"
                :action="action"
                @exists-installments="exists($event)"
                @installments-generated="createInstallments($event)"
            />
        </form>

        <div v-if="readonly" class=" text-base font-medium flex justify-between items-center gap-4 p-3 rounded mt-2">
            <span class="border rounded px-3 py-1 bg-green-200 text-green-900">
                <q-icon name="check_circle" color="green-700" class="mr-2" />
                Recebidas: R$ {{ totalRecebidas }}
            </span>

            <span class="border rounded px-3 py-1 bg-yellow-200 text-yellow-900">
                <q-icon name="hourglass_empty" color="orange" />
                Pendentes: R$ {{ totalPendentes }}
            </span>

            <span class="border rounded px-3 py-1 bg-red-300 text-red-900">
                <q-icon name="warning" color="red" />
                Atrasadas ( + juros ): R$ {{ totalAtrasadas }}
            </span>
        </div>

        <div class="mt-4">
            <q-btn
                v-if="!readonly"
                @click="submitForm"
                type="submit"
                label="Registrar"
                class="bg-blue-600 text-white">
            </q-btn>

            <q-btn
                @click="print()"
                label="Imprimir"
                class="bg-blue-600 text-white"
                v-if="action === 'view'">
            </q-btn>

            <q-btn
                @click="close(false)"
                label="Voltar"
                class="ml-5 bg-slate-600 text-white">
            </q-btn>
        </div>
    </div>
</template>
<script setup lang="ts">
    import dayjs from "dayjs";
    import 'dayjs/locale/pt-br';
    import { api } from "src/boot/axios"
    import {LocalStorage, useQuasar} from "quasar";
    import { ref, computed, watch, reactive, onMounted } from 'vue';
    import InstallmentsTable from "../Financial/InstallmentsTable.vue";
    import SpeciesSearchBar from "src/components/Search/SpeciesSearchBar.vue";
    import CustomerSearchBar from "src/components/Search/CustomerSearchBar.vue";

    //#region PRINCIPAIS
    let title = ref<string>('');

    const today = dayjs();
    const $q = useQuasar();
    const installments = ref<any[]>([]);

    const props = defineProps<{
        widthScreen: number,
        pdv?: boolean,
        receiveCod?: number,
        readonly: boolean,
        action: string,
        receives: Array<IReceiveBody>,
        selectedRegister: IReceiveBody | null,
    }>();

    const emits = defineEmits<{
        (e: 'close', value: boolean)
    }>();

    const close = (readonly: boolean) =>
    {
        emits('close', false);
    };

    const titles = reactive({
        'view': 'Visualizando ',
        'register': 'Cadastrando ',
        'update': 'Editando '
    });
    //#endregion
    //#region DADOS
    const form = ref<IReceiveBody>({
        issuerID: LocalStorage.getItem("issuer_id"),
        userID: LocalStorage.getItem("user_id"),
        description: 'Registro Manual Receber',
        document: 1,
        customerID: 1,
        especieID: 0,
        especie: '',
        dueDate: today.add(30, 'days').format("YYYY-MM-DD"),
        installmentAmount: 1,
        installmentNumber: 1,
        installmentValue: 0,
        typeInterest: '%',
        interestValue: 0,
        addition: 0,
        discount: 0,
        valueEntry: 0,
        valuePaid: 0,
        origem: 'Receber (Manual)',
        paid: false,

    });
    
    const submitForm = async () => {
        try {
            const payload = {
                issuerId: form.value.issuerID,
                userId: form.value.userID,
                customerId: form.value.customerID,
                especieId: form.value.especieID,
                description: form.value.description,
                document: form.value.document,
                dueDate: form.value.dueDate,
                installmentAmount: form.value.installmentAmount,
                installmentNumber: form.value.installmentNumber,
                installmentValue: form.value.installmentValue,
                typeInterest: form.value.typeInterest,
                interestValue: form.value.interestValue,
                addition: form.value.addition,
                discount: form.value.discount,
                valueEntry: form.value.valueEntry,
                valuePaid: form.value.valuePaid,
                origem: form.value.origem,
                installments: installments.value,
            };

            const response = await api.post('ecommerce/receive/create', payload);

            $q.notify({
                color: 'green',position: 'top',
                message: 'Recebimento registrado com sucesso!',
            });

            emits('close', true);

        } catch (error) {
            $q.notify({
                position: 'top',
                color: 'negative',
                message: 'Erro ao registrar recebimento!',
                
            });
            
            console.error("Erros da API:", error.response?.data?.errors);
        }
    };
    //#endregion
    //#region EVENTOS
    const exists = (event: boolean) =>
    {
        if(event)
        {
            $q.notify({
                color: 'red',
                message: 'Parcelas já existentes',
                position: 'top',
                timeout: 2000
            });
        };

    };

    const print = () => {};

    const getCustumer = (event) =>
    {
        form.value.customerID = event.id;
    };

    const createInstallments = (event) => 
    {
      installments.value = event;
    };

    const getSpecie = (event) => 
    {
        form.value.especieID = event.payment_code;
        form.value.especie = event.name;
    };
    //#endregion
    //#region CALCULOS
    const totalAmoutCalc = computed(() => 
    {
        const number = parseCurrency(form.value.installmentNumber);
        const value = parseCurrency(form.value.installmentValue);
        const total = number * value;

        return total.toFixed(2);

    });

    const totalRecebidas = computed(() => {
        return installments.value
            .filter(inst => inst.paid)
            .reduce((sum, inst) => sum + parseCurrency(inst.valuePaid || 0), 0)
            .toFixed(2);
    });

    const totalPendentes = computed(() => {
        return installments.value
            .filter(inst => !inst.paid && !isLate(inst.dueDate))
            .reduce((sum, inst) => sum + parseCurrency(inst.valuePaid || 0), 0)
            .toFixed(2);
    });

    const totalAtrasadas = computed(() => {
        return installments.value
            .filter(inst => !inst.paid && isLate(inst.dueDate))
            .reduce((sum, inst) => sum + parseCurrency(inst.valuePaid || 0), 0)
            .toFixed(2);
    });

    const isLate = (dueDate: string): boolean => {
        return dayjs(dueDate).isBefore(dayjs(), 'day');
    };
    
    const parseCurrency = (value: number): number =>
    {
        if (!value) return 0;

        return parseFloat(
            value
            .toString()
            .replace(/\s/g, '')
            .replace('R$', '')
            .replace(/\./g, '')
            .replace(',', '.')
        ) || 0;
    };
    //#endregion
    //#region Mounted
    onMounted(() => {
        title.value = titles[props.action];
        console.log('issuer_id:', LocalStorage.getItem("issuer_id"));
        console.log('user_id:', LocalStorage.getItem("user_id"));

        if (props.action === 'view' || props.action === 'update') {
            if (props.selectedRegister) {
                //form.value = { ...props.selectedRegister };
                //installments.value = props.selectedRegister;
            }
        }
    });
    //#endregion
</script>