<template>
    <div
        class="mr-14 mt-5 mb-5 p-6 bg-white"
        :class="{
            'relative top-12 left-12': widthScreen <= 1080,
            'ml-14': widthScreen > 1080
        }"
    >
    <h2 class="border-b border-black text-xl font-semibold mb-4 w-max">
        {{ title }} pagamentos
    </h2>
        <q-form
            class="grid gap-4 mx-auto"
            style="max-width: 1000px;"
            :class="{
                'grid-cols-1 lg:grid-cols-2': widthScreen > 1080,
                'grid-cols-1': widthScreen <= 1080
            }"
        >
            <div
                class="border border-gray-200 rounded-md p-3 max-h-[230px] w-auto overflow-auto"
            >
                <div class="flex flex-wrap gap-4">
                    <SpeciesSearchBar
                        @selectSpecie="getSpecie"
                        :module_="'installment'"
                        :disable="false"
                    />

                    <CustomerSearchBar
                        @updated:selectCustomer="getCustomer"
                        :pdv="false"
                        :disable="false"
                    />

                    <q-input
                        class="w-[100px]"
                        type="number"
                        label="Nº Doc"
                        color="grey-7"
                        v-model="toPay.document" 
                    />
                
                    <q-input
                        class="w-[200px]"
                        type="text"
                        label="Descrição"
                        color="grey-7"
                        v-model="toPay.description"
                    />
                </div>
            </div>

            <div
                class="border border-gray-200 rounded-md p-3 max-h-[230px] w-auto overflow-auto"
            >
                <div class="flex flex-wrap gap-4">
                    <q-input
                        type="text"
                        v-model="toPay.user"
                        label="Usuário"
                        color="grey-7"
                        class="w-[100px]"
                        readonly
                        disable
                    />

                    <q-input
                        v-model="toPay.dueDate"
                        label="Data de Vencimento"
                        mask="##/##/####">

                        <template v-slot:append>
                            <q-icon name="event" class="cursor-pointer">
                                <q-popup-proxy>
                                    <q-date v-model="toPay.dueDate" mask="DD/MM/YYYY" />
                                </q-popup-proxy>
                            </q-icon>
                        </template>
                    </q-input>

                    <q-input
                        type="number"
                        v-model="toPay.installmentNumber"
                        label="Nº Parcelas"
                        color="grey-7"
                        class="w-[100px]"
                        :disable="!toPay.especieID"
                    />

                    <q-input
                        type="number"
                        v-model="toPay.installmentValue"
                        label="Valor Parcelas"
                        color="grey-7"
                        class="w-[100px]"
                        :disable="!toPay.especieID"
                    />

                    <q-select
                        v-model="toPay.typeInterest"
                        label="Tipo de Juros"
                        class="w-[120px]"
                        :options="[
                            { label: '%', value: 'Porcentagem' },
                            { label: 'R$', value: 'Valor'}
                        ]"
                        emit-value
                        map-options
                    />

                    <q-input
                        type="number"
                        class="w-[100px]"
                        v-model="toPay.interestValue"
                        label="Valor juros"
                        color="grey-7"
                    />

                    <q-input
                        type="number"
                        class="w-[100px]"
                        v-model="toPay.totalAmount"
                        label="Valor total"
                        color="grey=7"
                    />
                </div>
            </div>
             <div class="flex items-center">
                <q-btn
                    type="submit"
                    label="Registrar"
                    class="bg-blue-600 text-white"
                    @click="submitForm"

                </q-btn>

                <q-btn
                    @click="emits('close', false)"
                    label="Voltar"
                    class="ml-5 bg-red-700 text-white"
                />
            </div>
            <InstallmentsTable
                :pdv="false"
                :receiveDocument="1"
                :number="toPay.installmentNumber"
                :amount="toPay.installmentAmount"
                :original-value="toPay.installmentValue"
                :due-date="toPay.dueDate"
                :readonly="true"
                :action="action"
                @exists-installments=""
                @installments-generated=""
            />
        </q-form>
    </div>
</template>

<script setup lang="ts">
    import { api } from "src/boot/axios"
    import { useQuasar, LocalStorage } from "quasar";
    import { ref, reactive, onMounted } from 'vue';
    import CustomerSearchBar from "src/components/Search/CustomerSearchBar.vue";
    import SpeciesSearchBar from "src/components/Search/SpeciesSearchBar.vue";
    import InstallmentsTable from "../Financial/InstallmentsTable.vue";

    const props = defineProps<{
        widthScreen: number;
        pdv?: boolean;
        toPayDocument?: number;
        action: string;
        readonly: boolean;
        
    }>();

    const emits = defineEmits<{
        (e: 'close', value: boolean)

    }>();

    const $q = useQuasar();
    const titles = reactive({
        view: "Visualizando ",
        register: "Cadastrando ",
        update: "Editando ",

    });

    const title = ref<string>("");
    
    const toPay = ref<IPayBody>({
        issuerID: LocalStorage.getItem("issuer_id"),
        document: 1,
        description: 'Registro Manual Pagar',
        chartOfAccountCode: 1,
        costCenterCode: 1,
        customerID: 0,
        name: '',
        especieID: 0,
        especie: '',
        userID: LocalStorage.getItem("user_id"),
        user: LocalStorage.getItem("user_name"),
        dueDate: '',
        installmentAmount: 1,
        installmentNumber: 1,
        installmentValue: 0,
        typeInterest: 'R$',
        interestValue: 1,
        totalAmount: 0,
        origem: "Pagar (Manual)",
        addition: 0,
        discount: 0,
        valueEntry: 0,
        valueToPay: 0,
        valueOriginal: 0,
    });

    const getSpecie = (event: any) => {
        toPay.value.especieID = event.payment_code;
        toPay.value.especie = event.name;
    };    

    const getCustomer = (event: any) => {
        toPay.value.customerID = event.id;

    };

    const submitForm = async () => 
    {

    };

    onMounted(() => {
        title.value = titles[props.action];
    });
    
</script>
