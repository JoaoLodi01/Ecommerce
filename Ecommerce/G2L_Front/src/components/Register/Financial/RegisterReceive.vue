<template>
    <div
        class="mr-14 mt-5 mb-5 p-6 bg-white"
        :class="{
            'relative top-12 left-12': widthScreen <= 1080,
            'ml-14': widthScreen > 1080
        }"
    >

    <h2 class="border-b border-black text-xl font-semibold mb-4 w-max">
        {{ title }} recebimentos
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
                v-if="!readonly"
                class="border border-gray-200 rounded-md p-3 max-h-[230px] w-auto overflow-auto"
                >
                <div class="flex flex-wrap gap-4">
                    <SpeciesSearchBar
                    @selectSpecie="getSpecie"
                    :module_="'installment'"
                    :disable="readonly"
                    />

                    <CustomerSearchBar
                    @updated:selectCustomer="getCustomer"
                    :pdv="false"
                    :disable="readonly"
                    />

                    <q-input
                    class="w-[100px]"
                    type="number"
                    v-model="form.document"
                    label="Nº Doc"
                    color="grey-7"
                    :readonly="readonly"
                    />

                    <q-input
                    class="w-[200px]"
                    type="text"
                    v-model="form.description"
                    label="Descrição"
                    color="grey-7"
                    :readonly="readonly"
                    />
                </div>
            </div>

            <div
                v-if="!readonly"
                class="border border-gray-200 rounded-md p-3 max-h-[230px] w-auto overflow-auto"
                >
                <div class="flex flex-wrap gap-4">
                    <q-input
                    class="w-[100px]"
                    type="number"
                    v-model.number="form.installmentAmount"
                    label="Nº Parcelas"
                    color="grey-7"
                    :disable="!form.especieID"
                    :readonly="readonly"
                    />

                    <q-input
                    class="w-[150px]"
                    type="number"
                    v-model.number="form.installmentValue"
                    label="Valor Parcela"
                    color="grey-7"
                    :disable="!form.especieID"
                    :readonly="readonly"
                    />

                    <q-input
                    class="w-[150px]"
                    type="date"
                    v-model="form.dueDate"
                    label="1º Vencimento"
                    color="grey-7"
                    :readonly="readonly"
                    />

                    <q-select
                    class="w-[80px]"
                    v-model="form.typeInterest"
                    label="Tipo"
                    emit-value
                    map-options
                    :disable="readonly"
                    :options="[
                        { label: '%', value: '%' },
                        { label: 'R$', value: 'R$' }
                    ]"
                    />

                    <q-input
                    class="w-[100px]"
                    type="number"
                    v-model.number="form.interestValue"
                    label="Juros"
                    color="grey-7"
                    :readonly="readonly"
                    />

                    <q-input
                    class="w-[100px]"
                    type="number"
                    v-model.number="form.addition"
                    label="Acréscimo"
                    color="grey-7"
                    :readonly="readonly"
                    />

                    <q-input
                    class="w-[100px]"
                    type="number"
                    v-model.number="form.discount"
                    label="Desconto"
                    color="grey-7"
                    :readonly="readonly"
                    />

                    <q-input
                    class="w-[130px]"
                    type="number"
                    v-model.number="form.valueEntry"
                    label="Juros a pagar"
                    color="grey-7"
                    readonly
                    />
                </div>
            </div>

            <InstallmentsTable
                :pdv="false"
                :receiveDocument="props.receiveDocument"
                :number="form.installmentNumber"
                :amount="form.installmentAmount"
                :original-value="form.installmentValue"
                :due-date="form.dueDate"
                :readonly="readonly"
                :action="action"
                @exists-installments="exists"
                @installments-generated="createInstallments"
            />
        </q-form>

    <div
      v-if="readonly"
      class="text-base font-medium flex justify-between items-center gap-4 p-3 rounded mt-2"
    >
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

    <!-- Buttons -->
    <div class="mt-4">
      <q-btn
        v-if="!readonly"
        @click="submitForm"
        type="submit"
        label="Registrar"
        class="bg-blue-600 text-white"
      />
      <q-btn
        v-if="action === 'view'"
        @click="print"
        label="Imprimir"
        class="bg-blue-600 text-white"
      />
      <q-btn
        @click="close(false)"
        label="Voltar"
        class="ml-5 bg-slate-600 text-white"
      />
    </div>
  </div>
</template>

<script setup lang="ts">
import dayjs from "dayjs";
import "dayjs/locale/pt-br";
import { api } from "src/boot/axios";
import { LocalStorage, useQuasar } from "quasar";
import { ref, computed, reactive, onMounted, toRaw } from "vue";

import InstallmentsTable from "../Financial/InstallmentsTable.vue";
import SpeciesSearchBar from "src/components/Search/SpeciesSearchBar.vue";
import CustomerSearchBar from "src/components/Search/CustomerSearchBar.vue";

const props = defineProps<{
  widthScreen: number;
  pdv?: boolean;
  receiveDocument?: number;
  readonly: boolean;
  action: string;
}>();

const emits = defineEmits<{
  (e: "close", value: boolean): void;
}>();

const $q = useQuasar();

const title = ref("");
const form = reactive<IReceiveBody>({
  issuerID: LocalStorage.getItem("issuer_id"),
  userID: LocalStorage.getItem("user_id"),
  description: "Registro Manual Receber",
  document: 1,
  customerID: 1,
  especieID: 0,
  especie: "",
  dueDate: dayjs().add(30, "days").format("YYYY-MM-DD"),
  paidDate: "",
  installmentAmount: 1,
  installmentNumber: 1,
  installmentValue: 0,
  typeInterest: "%",
  interestValue: 0,
  addition: 0,
  discount: 0,
  valueEntry: 0,
  valuePaid: 0,
  origem: "Receber (Manual)",
  status: "Em aberto",
  paid: false,
  installments: [],
});

const installments = ref<any[]>([]);

const submitForm = async () => {
  try {
    const payload = {
      issuerId: form.issuerID,
      userId: form.userID,
      customerId: form.customerID,
      especieId: form.especieID,
      description: form.description,
      document: form.document,
      dueDate: form.dueDate,
      installmentAmount: form.installmentAmount,
      installmentNumber: form.installmentNumber,
      installmentValue: form.installmentValue,
      typeInterest: form.typeInterest,
      interestValue: form.interestValue,
      addition: form.addition,
      discount: form.discount,
      valueEntry: form.valueEntry,
      valuePaid: form.valuePaid,
      origem: form.origem,
      status: form.status,
      installments: toRaw(installments.value),
    };

    const response = await api.post("ecommerce/receive/create", payload, {
      headers: {
        "Content-Type": "application/json",
      },
    });

    if (response.data.success) {
      $q.notify({
        color: "green",
        position: "top",
        message: "Recebimento registrado com sucesso!",
      });
      emits("close", true);
    } else {
      $q.notify({
        color: "negative",
        position: "top",
        message: "Erro ao registrar recebimento!",
      });
    }
  } catch (error) {
    console.error("Erros da API:", error.response?.data?.errors);
  }
};

// Eventos e métodos auxiliares
const exists = (event: boolean) => {
  if (event) {
    $q.notify({
      color: "red",
      message: "Parcelas já existentes",
      position: "top",
      timeout: 2000,
    });
  }
};

const print = () => {
  // lógica de impressão
};

const getCustomer = (event: any) => {
  form.customerID = event.id;
};

const createInstallments = (event: any) => {
  installments.value = event;
  console.log("Installments atualizados:", installments.value);
};

const getSpecie = (event: any) => {
  form.especieID = event.payment_code;
  form.especie = event.name;
};

// Cálculos
const parseCurrency = (value: number): number => {
  if (!value) return 0;
  return (
    parseFloat(
      value
        .toString()
        .replace(/\s/g, "")
        .replace("R$", "")
        .replace(/\./g, "")
        .replace(",", ".")
    ) || 0
  );
};

const isLate = (dueDate: string): boolean => {
  return dayjs(dueDate).isBefore(dayjs(), "day");
};

const totalRecebidas = computed(() =>
  installments.value
    .filter((inst) => inst.paid)
    .reduce((sum, inst) => sum + parseCurrency(inst.valuePaid || 0), 0)
    .toFixed(2)
);

const totalPendentes = computed(() =>
  installments.value
    .filter((inst) => !inst.paid && !isLate(inst.dueDate))
    .reduce((sum, inst) => sum + parseCurrency(inst.valuePaid || 0), 0)
    .toFixed(2)
);

const totalAtrasadas = computed(() =>
  installments.value
    .filter((inst) => !inst.paid && isLate(inst.dueDate))
    .reduce((sum, inst) => sum + parseCurrency(inst.valuePaid || 0), 0)
    .toFixed(2)
);

const titles = {
  view: "Visualizando ",
  register: "Cadastrando ",
  update: "Editando ",
};

const close = (value: boolean) => {
  emits("close", value);
};

onMounted(() => {
    title.value = titles[props.action];
});
</script>