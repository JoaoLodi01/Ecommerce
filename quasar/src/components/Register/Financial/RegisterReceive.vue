<template>
  <div
    class="mr-14 mt-5 mb-5 p-6 bg-white"
        :class="{
            'relative top-12 left-12': props.widthScreen <=1080,
            'ml-14': props.widthScreen > 1080
        }"
    >

    <h2 class="border-b border-black text-xl font-semibold mb-4 w-max">Cadastrar recebimentos</h2>

        <form
            @submit.prevent="submitForm"
            class="grid gap-4 mx-auto"
            style="max-width: 1000px;"
            :class="{
                'grid-cols-1 lg:grid-cols-2': widthScreen > 1080,
                'grid-cols-1': widthScreen <= 1080
            }"
        >

            <div class="border border-gray-300 rounded-md p-3 h-auto max-h-[230px] w-auto overflow-auto">
                <div class="flex flex-wrap gap-4">
                    <q-input
                        class="w-[100px]"
                        type="number"
                        v-model="form.document"
                        label="Nº Doc"
                        color="grey-7"
                    />

                    <q-input
                        class="w-[200px]"
                        type="text"
                        v-model="form.description"
                        label="Descrição"
                        color="grey-7"
                    />

                    <q-input
                        class="w-[150px]"
                        type="date"
                        v-model="form.dueDate"
                        label="1º Vencimento"
                        color="grey-7"
                    />

                    <q-input
                        class="w-[100px]"
                        type="number"
                        v-model="form.installmentNumber"
                        label="Nº Parcelas"
                        color="grey-7"
                        :disable="!form.especieID"
                    />

                    <q-input
                        class="w-[150px]"
                        type="text"
                        v-model="form.installmentValue"
                        label="Valor Parcela"
                        v-bind:mask="'##,##'"
                        color="grey-7"
                        :disable="!form.especieID"
                        
                    />

                    <CustomerSearchBar 
                        @updated:selectCustomer="getCustumer($event)" 
                        :pdv="false"
                    />
                </div>
            </div>

            <div class="border border-gray-300 rounded-md p-3 h-auto max-h-[230px] w-auto overflow-auto">
                <div class="flex flex-wrap gap-4">
                    <q-select
                        class="w-[80px]"
                        v-model="form.typeInterest"
                        label="Tipo"
                        emit-value
                        map-options
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
                    />

                    <q-input
                        class="w-[100px]"
                        type="number"
                        v-model="form.addition"
                        label="Acréscimo"
                        color="grey-7"
                    />

                    <q-input
                        class="w-[100px]"
                        type="number"
                        v-model="form.discount"
                        label="Desconto"
                        color="grey-7"
                    />

                    <q-input
                        class="w-[130px]"
                        type="number"
                        v-model="form.valueEntry"
                        label="Juros a pagar"
                        color="grey-7"
                        v-bind:mask="'##,##'"
                        readonly
                    />

                    <SpeciesSearchBar
                        @selectSpecie="getSpecie($event)"
                        :module_="'receive'"
                    />

                </div>
            </div>

            <InstallmentsTable 
                :pdv="false" 
                :amount="Number(form.installmentNumber)"
                :original-value="form.installmentValue"
                :due-date="form.dueDate"
                @exists-installments="exists($event)"
                @updated:inspecInstallment="createInstallments($event)"
                @request:generateInstallmentes=""
            />

            <div>
                <q-btn
                    type="submit"
                    label="Registrar"
                    class="bg-blue-600 text-white">
                </q-btn>

                <q-btn
                    @click="close()"
                    label="Voltar"
                    class="ml-5 bg-slate-600 text-white">
                </q-btn>
            </div>
        </form>
    </div>
</template>
<script setup lang="ts">
    import { api } from "src/boot/axios"
    import {LocalStorage, useQuasar} from "quasar";
    import { ref, computed, watch, defineProps, defineEmits } from 'vue';
    import dayjs from "dayjs";
    import 'dayjs/locale/pt-br';
    import CustomerSearchBar from "src/components/Search/CustomerSearchBar.vue";
    import SpeciesSearchBar from "src/components/Search/SpeciesSearchBar.vue";
    import InstallmentsTable from "./InstallmentsTable.vue";

    const props = defineProps<{
        widthScreen: number,
        pdv?: boolean

    }>();

    const emits = defineEmits<{
        (e: 'close', value: boolean)
    }>();

    const today = dayjs();
    const $q = useQuasar();
    
    //const user = ref<number>(LocalStorage.getItem("user_name"));

    const form = ref<IReceiveBody>({
        issuerID: LocalStorage.getItem("issuer_id"),
        description: 'Registro Manual Receber',
        document: 1,
        customerID: 1,
        userID: LocalStorage.getItem("user_id"),
        especieID: 0,
        especie: '',
        dueDate: today.add(30, 'days').format("YYYY-MM-DD"),
        installmentNumber: 1,
        installmentValue: 0,
        typeInterest: '%',
        interestValue: 0,
        addition: 0,
        discount: 0,
        valueEntry: 0,
        valuePaid: 0,
        valueOriginal: 0,
        origem: 'Receber (Manual)',

    });
    
    const totalAmoutCalc = computed(() => 
    {
        const number = parseCurrency(form.value.installmentNumber);
        const value = parseCurrency(form.value.installmentValue);
        const total = number * value;

        return total.toFixed(2);

    });

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
      

    const close = () =>
    {
        emits('close', false);
    };

    const getCustumer = (event) =>
    {
        console.log(event);
        form.value.customerID = event.id;
    };

    const createInstallments = (event) => 
    {
      
    };

    const getSpecie = (event) => 
    {
        console.log("Chamou o getSpecie");
        console.log(event);

        form.value.especieID = event.payment_cod;
        form.value.especie = event.name;
    };

    const submitForm = async () =>
    {
        try {
            const response = await api.post(`/ecommerce/receive/create`, form.value);

            if(response.data.success){
                close();
            }

            console.log('Dados enviados!', response.data)
        } catch (error) {
            alert("Ocorreu um erro ao cadastrar o registro")
        }
    };
  
</script>
