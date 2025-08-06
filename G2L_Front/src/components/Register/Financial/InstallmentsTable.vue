<template>
    <div class="lg:col-span-2 flex justify-end gap-4" v-if="!readonly">
        <q-btn
        label="Gerar Parcelas"
        color="primary"
        class="mb-2"
        @click="generateInstallments"
        :disable="originalValue <= 0"
        />

        <q-btn
        label="Excluir Parcelas"
        color="negative"
        class="mb-2"
        @click="deleteInstallments"
        />
    </div>

    <div class="lg:col-span-2 overflow-y-auto border border-gray-400 rounded-md shadow-sm" :style="{ width: '1000px', height: readonly ? '400px' : '250px' }">
        <table class="min-w-full border-collapse bg-white text-sm">
            <thead class="sticky top-0 z-10 bg-blue-600 text-white">
                <tr>
                    <th class="px-2 py-1" v-if="action === 'view'">
                        <q-checkbox
                            v-model="selectAll"
                            @update:model-value="toggleSelectAll"/>
                    </th>
                    <th class="px-2 py-1">Nº Parcela</th>
                    <th class="px-2 py-1">Qtde. Parcelas</th>
                    <th class="px-2 py-1">Data Vencimento</th>
                    <th class="px-2 py-1">Valor Original</th>
                    <th class="px-2 py-1">Valor à pagar</th>
                    <th class="px-2 py-1" v-if="action === 'view'">Data Pagamento</th>
                    <th class="px-2 py-1" v-if="action === 'view'">Status</th>
                    <th class="px-2 py-1" v-if="!readonly">Ações</th>
                </tr>
            </thead>

            <tbody>
                <tr v-for="(installment, i) in installmentsData" :key="i" class="text-center border-t border-gray-300" :class="{ 'bg-green-100': installment.paid }">
                    <td v-if="action === 'view'">
                        <q-checkbox v-model="installment.selected"/>
                    </td>
                    <td>{{ installment.installmentNumber }}</td>
                    <td>{{ installment.installmentAmount }}</td>
                    <td class="w-[150px]">
                        <q-input
                        type="date"
                        v-model="installment.dueDate"
                        dense
                        outlined
                        color="primary"
                        :readonly="action === 'view'"
                        v-if="action === 'view'"
                        />
                    </td>
                    <td>
                        {{ formatCurrency(installment.valueOriginal) }}
                    </td>
                    <td>
                        <q-input
                        type="number"
                        v-model.number="installment.paidAmountEditable"
                        :max="installment.valueOriginal - installment.valuePaid"
                        :min="0.01"
                        prefix="R$"
                        dense
                        outlined
                        />
                    </td>
                    <td v-if="action === 'view'">{{ installment.paymentDate }}</td>
                    <td>
                        <span
                        :class="{
                            'text-green-600': installment.paid,
                            'text-yellow-600': !installment.paid && installment.valuePaid > 0,
                            'text-red-600': installment.valuePaid === 0,
                        }"
                        >
                        {{
                            installment.paid
                            ? 'Quitada'
                            : installment.valuePaid > 0
                            ? 'Parcial'
                            : 'Em aberto'
                        }}
                        </span>
                    </td>
                    <td v-if="!readonly">
                        <q-btn
                        size="sm"
                        icon="check"
                        color="green"
                        @click="openPaymentDialog(installment)"
                        v-if="!installment.paid"
                        >
                        <q-tooltip>Quitar Parcela</q-tooltip>
                        </q-btn>
                        <q-btn
                        size="sm"
                        icon="undo"
                        color="warning"
                        @click="undoPayOff(installment)"
                        v-if="installment.paid"
                        >
                        <q-tooltip>Desfazer Quitação</q-tooltip>
                        </q-btn>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>

    <!-- Diálogo de Pagamento -->
    <q-dialog v-model="paymentDialog">
        <q-card>
        <q-card-section>
            <div class="text-h6">
            Quitar Parcela Nº {{ selectedInstallment?.installmentNumber }}
            </div>
            <div class="q-mt-sm">
            <q-input
                v-model.number="paymentAmount"
                type="number"
                label="Valor a Pagar"
                :rules="[val => val > 0 || 'Informe um valor válido']"
                prefix="R$"
                outlined
                dense
            />
            </div>
        </q-card-section>

        <q-card-actions align="right">
            <q-btn flat label="Cancelar" v-close-popup />
            <q-btn color="primary" label="Confirmar" @click="confirmInstallmentPayment" />
        </q-card-actions>
        </q-card>
    </q-dialog>
</template>

<script setup lang="ts">
    import { ref, computed , onMounted, watch} from 'vue';
    import dayjs from 'dayjs';
    import { useQuasar, LocalStorage } from 'quasar';
    import { api } from 'src/boot/axios';

// ------------------ Props & Emits ------------------
    const props = defineProps<{
        receiveDocument?: string;
        selectedRegister?: IReceiveBody | null;
        pdv?: boolean;
        amount: number;
        originalValue: number;
        dueDate: string;
        readonly: boolean;
        action: string;
    }>();

    const emits = defineEmits<{
        (e: 'installmentsGenerated', value: TinstallmentsData[]);
        (e: 'existsInstallments', value: boolean);
    }>();

// ------------------ Types ------------------
    type TinstallmentsData = {
        installmentCode: string;
        installmentNumber: number;
        installmentAmount: number;
        dueDate: string;
        valuePaid: number;
        valueOriginal: number;
        paid: boolean;
        paymentDate?: string;
        paidAmountEditable?: number;
        selected?: boolean;
        status?: 'quitada' | 'parcial' | 'em aberto';
    };

// ------------------ Variáveis ------------------
    const $q = useQuasar();
    const paymentAmount = ref(0);
    const paymentDialog = ref(false);
    const selectAll = ref<boolean>(false);
    const installmentsData = ref<TinstallmentsData[]>([]);
    const selectedInstallment = ref<TinstallmentsData | null>(null);

// ------------------ Computed ------------------
    const remaining = computed(() =>
        selectedInstallment.value ? selectedInstallment.value.valueOriginal - selectedInstallment.value.valuePaid : 0
    );

    const selectedInstallments = computed(() =>
        installmentsData.value.filter(i => i.selected)
    );

// ------------------ Mounted ------------------
    onMounted(() => {
        if (props.action === 'view'){
            getRegister();
        }
        console.log('Documento: ', props.receiveDocument);
        console.log('Data: ', installmentsData.value);
    });

// ------------------ Methods ------------------
    const getRegister = async () => {
        try {
            const res = await api.get(`/ecommerce/receive/one/${props.receiveDocument}`);
            installmentsData.value = res.data.data || [];

            console.log('Dados get: ', res.data);
            
        } catch (error) {
            $q.notify({
                color: 'negative',
                message: 'Erro ao buscar parcelas.',
                position: 'top',
            });

            console.error(error);
        }
    };

    const generateInstallments = () => {
        if (installmentsData.value.length > 1) {
            emits('existsInstallments', true);
            return;
        }

        if (props.amount <= 0 || props.originalValue <= 0) {
            $q.notify({ color: 'negative', message: 'Valores inválidos!', position: 'top' });
            return;
        }

        installmentsData.value = [];

        for (let i = 1; i <= props.amount; i++) {
            installmentsData.value.push({
            installmentCode: props.receiveDocument || '0',
            installmentNumber: i,
            installmentAmount: props.amount,
            valueOriginal: props.originalValue / props.amount,
            valuePaid: 0,
            dueDate: dayjs(props.dueDate).add(i - 1, 'month').format('YYYY-MM-DD'),
            paid: false,
            paidAmountEditable: 0,
            selected: false,
            status: 'em aberto',
            });
        }

        emits('installmentsGenerated', installmentsData.value);
    };

    const deleteInstallments = () => {
        installmentsData.value = [];
    };

    const openPaymentDialog = (installment: TinstallmentsData) => {
        selectedInstallment.value = installment;
        paymentAmount.value = installment.valueOriginal - installment.valuePaid;
        paymentDialog.value = true;
    };

    const confirmInstallmentPayment = async () => {
        if (!selectedInstallment.value || paymentAmount.value <= 0) return;

        if (paymentAmount.value > remaining.value) {
            $q.notify({
            color: 'negative',
            message: `O valor excede o saldo da parcela (R$ ${remaining.value.toFixed(2)}).`,
            position: 'top',
            });
            return;
        }

        try {
            const payload = {
                issuerId: LocalStorage.getItem('issuer_id'),
                paymentDate: dayjs().format('YYYY-MM-DD'),
                installmentPaid: paymentAmount.value,
            };

            await api.put(`/ecommerce/receive/payInstallment/${selectedInstallment.value.installmentCode}`, payload);

                selectedInstallment.value.valuePaid
                selectedInstallment.value.valuePaid += paymentAmount.value;

            if (selectedInstallment.value.valuePaid >= selectedInstallment.value.valueOriginal) {
                selectedInstallment.value.paid = true;
                selectedInstallment.value.status = 'quitada';
                selectedInstallment.value.paymentDate = dayjs().format('YYYY-MM-DD');
            } else {
                selectedInstallment.value.status = 'parcial';
            }

                selectedInstallment.value.paidAmountEditable = 0;
                paymentDialog.value = false;

            $q.notify({
                color: 'positive',
                message: 'Parcela quitada com sucesso!',
                position: 'top',
            });

        } catch (error) {
            $q.notify({
                color: 'negative',
                message: 'Erro ao quitar a parcela.',
                position: 'top',
            });

            console.error(error);
        }
    };

    const undoPayOff = async (installment: TinstallmentsData) => {
        try {
            await api.put(`/ecommerce/receive/undoPayInstallment/${installment.installmentCode}`, {
                issuerId: LocalStorage.getItem('issuer_id'),
            });

                installment.valuePaid = 0;
                installment.paid = false;
                installment.paymentDate = '';
                installment.status = 'em aberto';
                installment.paidAmountEditable = 0;

            $q.notify({
                color: 'warning',
                message: 'Quitação desfeita com sucesso.',
                position: 'top',
            });

        } catch (error) {
            $q.notify({
                color: 'negative',
                message: 'Erro ao desfazer quitação.',
                position: 'top',
            });

            console.error(error);
        }
    };

    const toggleSelectAll = (val: boolean) => {
        installmentsData.value.forEach(i => {
            i.selected = val;
        });
    };

    const formatCurrency = (value?: number) => {
        const parsed = typeof value === 'number' ? value : 0;

        return parsed.toLocaleString('pt-BR', {
            style: 'currency',
            currency: 'BRL',
            minimumFractionDigits: 2,
        });
    };

    watch(
    () => installmentsData.value.map(i => i.selected),
        (newValues) => {
            const allSelected = newValues.every(Boolean);
            selectAll.value = allSelected;
        },{ deep: true }
    );

</script>
