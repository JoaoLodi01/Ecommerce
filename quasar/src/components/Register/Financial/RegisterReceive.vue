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
                        v-model="form.due_date"
                        label="1º Vencimento"
                        color="grey-7"
                    />

                    <q-input
                        class="w-[100px]"
                        type="number"
                        v-model="form.installment_number"
                        label="Nº Parcelas"
                        color="grey-7"
                    />

                    <q-input
                        class="w-[150px]"
                        type="number"
                        v-model="form.installment_value"
                        label="Valor Parcela"
                        color="grey-7"
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
                        v-model="form.type_interest"
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
                        v-model="form.interest_value"
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
                        v-model="form.value_entry"
                        label="Juros a pagar"
                        color="grey-7"
                        readonly
                    />

                    <SpeciesSearchBar @selectSpecie="getSpecie($event)" :module_="'receive'" />
                </div>
            </div>

            <InstallmentsTable 
                :pdv="false" 
                :amount="Number(form.installment_number)"
                @updated:inspecInstallment="createInstallments($event)"
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
    import {LocalStorage} from "quasar";
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
    
    const user = ref<number>(LocalStorage.getItem("user_name"));
    const form = ref<IReceiveBody>({
        issuer_id: LocalStorage.getItem("issuer_id"),
        description: 'Registro Manual Receber',
        document: 1,
        customer_id: 1,
        user_id: LocalStorage.getItem("user_id"),
        especie_id: 0,
        especie: '',
        due_date: today.add(30, 'days').format("DD-MM-YYYY"),
        installment_number: 1,
        installment_value: 0,
        type_interest: '',
        interest_value: 0,
        addition: 0,
        discount: 0,
        value_entry: 0,
        value_paid: 0,
        value_original: 0,
        origem: 'Receber (Manual)',

    });
    
    const totalAmoutCalc = computed(() => 
    {
        const number = parseCurrency(form.value.installment_number);
        const value = parseCurrency(form.value.installment_value);
        const total = number * value;

        return total.toFixed(2);

    });

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
        form.value.customer_id = event.id;
    };

    const createInstallments = (event) => 
    {
      
    };

    const getSpecie = (event) => 
    {
        console.log("Chamou o getSpecie");
        console.log(event);
        form.value.especie_id = event.payment_cod;
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
