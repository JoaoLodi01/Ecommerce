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

    <div class="flex justify items-center">
        <q-table
            :rows="installmentsData"
            :columns="columns"
            row-key="installmentNumber"
            selection="multiple"
            v-model:selected="selectedRows"
            :pagination="{ rowsPerPage: 10}"
            flat
            bordered
            :loading="loading"
            class="shadow-sm rounded bg-white"
        >

            <template #body-cell-status="props">
                <q-td :props="props">
                    <q-badge :color="getStatusColor(props.row.status)">
                        {{ props.row.status }}
                    </q-badge>
                </q-td>
            </template>

            <template #body-cell-dueDate="props">
                <q-td :props="props" class="w-[150px]">
                    <template v-if="action !== 'view'">
                        <q-input
                            type="date"
                            v-model="props.row.dueDate"
                            dense
                            outlined
                            color="primary"
                        />
                    </template>
                    <template v-else>
                        {{ dayjs(props.row.dueDate).format('DD/MM/YYYY') }}
                    </template>
                </q-td>
            </template>

            <template #body-cell-actions="props">
                <q-td :props="props">
                    <q-btn
                        size="sm"
                        icon="check"
                        color="green"
                        class="bg-gray-300"
                        flat
                        round
                        @click="openPaymentDialog(props.row)"
                        v-if="!props.row.paid"
                    >
                        <q-tooltip>Quitar Parcela</q-tooltip>
                    </q-btn>

                    <q-btn
                        size="sm"
                        icon="undo"
                        color="warning"
                        flat
                        round
                        @click="undoPayOff(props.row)"
                        v-if="props.row.paid"
                    >
                        <q-tooltip>Estornar valor</q-tooltip>
                    </q-btn>
                </q-td>
            </template>
        </q-table>
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
    import { useQuasar, LocalStorage, QTableColumn } from 'quasar';
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
        status?: 'quitada' | 'parcial' | 'em aberto';
    };

// ------------------ Variáveis ------------------
    const $q = useQuasar();
    const filter = ref(null);
    const loading = ref(false);
    const selectedRows = ref([]);
    const paymentAmount = ref(0);
    const paymentDialog = ref(false);
    const selectAll = ref<boolean>(false);
    const installmentsData = ref<TinstallmentsData[]>([]);
    const selectedInstallment = ref<TinstallmentsData | null>(null);

// ------------------ Computed ------------------
    const remaining = computed(() =>
        selectedInstallment.value ? selectedInstallment.value.valueOriginal - selectedInstallment.value.valuePaid : 0
    );

// ------------------ Mounted ------------------
    onMounted(() => {
        if (props.action === 'view'){
            getRegister();
        }
        console.log('Documento: ', props.receiveDocument);
        console.log('Data: ', installmentsData.value);
    });

// ------------------ Q-Table ------------------
    const columns: QTableColumn[] = [
        { name: 'installmentNumber', label: 'Nº Parcela', field: 'installmentNumber', align: 'center' },
        { name: 'dueDate', label: 'Data Vencimento', field: 'dueDate', align: 'center' },
        { name: 'valueOriginal', label: 'Valor Original', field: 'valueOriginal', align: 'center', format: val => formatCurrency(val) },
        { name: 'valuePay', label: 'Valor à pagar', field: row => row.valueOriginal - row.valuePaid, align: 'center', format: val => formatCurrency(val) },
        { name: 'paymentDate', label: 'Data Pagamento', field: 'paymentDate', align: 'center' },
        { name: 'status', label: 'Status', field: 'status', align: 'center' },
        { name: 'actions', label: 'Ações', field: 'actions', align: 'center', sortable: false },
    ];


// ------------------ Methods ------------------
    const getRegister = async () => {
        try {
            const res = await api.get(`/ecommerce/receive/one/${props.receiveDocument}`);
            const rawData = res.data.data || [];

            installmentsData.value = rawData.map(item => ({
                installmentCode: item.installment_cod || item.document || String(item.id), // fallback caso null
                installmentNumber: item.installment_number,
                installmentAmount: item.installment_amount,
                valueOriginal: Number(item.installment_value),
                valuePaid: Number(item.installment_paid),
                dueDate: item.due_date,
                paid: Number(item.installment_paid) >= Number(item.installment_value),
                paymentDate: item.date_paid,
                status: item.status.toLowerCase() === 'em aberto' ? 'em aberto' : item.status.toLowerCase(), // normaliza
            }));

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

    const formatCurrency = (value: number) =>
        new Intl.NumberFormat("pt-BR", {
            style: "currency",
            currency: "BRL"
    }).format(value || 0);

    function getStatusColor(status: string) {
        switch (status.toLowerCase()) {
            case 'quitada':
                return 'green';
            case 'parcial':
                return 'blue';
            case 'cancelada':
                return 'orange';
            case 'atrasada':
                return 'red';
            default:
                return 'grey';
        }
    }

</script>
