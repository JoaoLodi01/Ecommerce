<template>
    <div class="lg:col-span-2 flex justify-end gap-4" v-if="!readonly">
        <q-btn
            label="Gerar Parcelas"
            color="primary"
            class="mb-2"
            @click="generateInstallments()"
            :disable="originalValue <= 0"
        />

        <q-btn
            label="Excluir Parcelas"
            color="negative"
            class="mb-2"
            @click="deleteInstallments()"
        />
    </div>

    <div
        class="lg:col-span-2 overflow-y-auto border border-gray-400 rounded-md shadow-sm"
        :style="{ width: '1000px', height: readonly ? '400px' : '250px' }"
        >
        <table class="min-w-full border-collapse bg-white text-sm">
            <thead class="sticky top-0 z-10 bg-blue-600 text-white">
                <tr>
                    <th class="px-2 py-1">Check</th>
                    <th class="px-2 py-1">Nº Parcela</th>
                    <th class="px-2 py-1">Qtde. Parcelas</th>
                    <th class="px-2 py-1">Data Vencimento</th>
                    <th class="px-2 py-1">Valor Original</th>
                    <th class="px-2 py-1">Valor à pagar</th>
                    <th class="px-2 py-1" v-if="action === 'view'">Data Pagamento</th>
                    <th class="px-2 py-1" v-if="action === 'view'">Status</th>
                    <th class="px-2 py-1" v-if="readonly">Ações</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="(installment, i) in installmentsData" :key="i" class="text-center border-t border-gray-300" :class="{ 'bg-green-100': installment.paid, 'bg-white': !installment.paid}">
                    <td><q-checkbox v-model="installment.selectedForAdvance" /></td>
                    <td>{{ installment.installmentNumber }}</td>
                    <td>{{ installment.installmentAmount }}</td>
                    <td class="w-[150px]">
                        <q-input
                            type="date"
                            v-model="installment.dueDate"
                            dense
                            outlined
                            color="primary"
                            v-if="action === 'view'"
                            :readonly="action === 'view'"
                        />
                    </td>
                    <td>{{ formatCurrency(installment.valueOriginal) }}</td>
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
                            'text-red-600': installment.valuePaid === 0
                            }"
                        >
                            {{
                            installment.paid
                                ? 'Quitada': installment.valuePaid > 0
                                ? 'Parcial': 'Em aberto'
                            }}
                        </span>
                    </td>
                    <td v-if="action === 'view'">
                        <q-btn
                            size="sm"
                            icon="check"
                            color="green"
                            @click="openPaymentDialog(installment)"
                            v-if="!installment.paid">
                            <q-tooltip>Quitar Parcela</q-tooltip>
                        </q-btn>
                        <q-btn
                            size="sm"
                            icon="undo"
                            color="warning"
                            @click="undoPayOff(installment)"
                            v-if="installment.paid">
                            <q-tooltip>Desfazer Quitação</q-tooltip>
                        </q-btn>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>

    <q-dialog v-model="paymentDialog">
        <q-card>
            <q-card-section>
            <div class="text-h6">Quitar Parcela Nº {{ selectedInstallment?.installmentNumber }}</div>
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
    import { api } from "src/boot/axios";
    import { ref, defineProps, defineEmits, computed, onMounted, watch } from 'vue';
    import dayjs from 'dayjs';
    import { LocalStorage, useQuasar } from "quasar";

    const $q = useQuasar();
    const paymentDialog = ref(false);
    const paymentAmount = ref<number>(0);
    const advanceAmount = ref<number>(0);
    const selectedInstallment = ref<any>([]);
    const selectedForAdvance = ref<boolean>(false);
    const installmentsData = ref<TinstallmentsData[]>([]);

    type TinstallmentsData = {
        installmentCode: number;
        installmentNumber: number;
        installmentAmount: number;
        dueDate: string;
        valuePaid: number;
        valueOriginal: number;
        paid: boolean;
        paymentDate?: string;
        selectedForAdvance?: boolean;
        paidAmountEditable?: number;
        status?: 'quitada' | 'parcial' | 'em aberto';
    };

    const props = defineProps<{
        receiveDocument?: number;
        selectedRegister?: IReceiveBody | null;
        pdv?: boolean,
        amount: number,
        originalValue: number,
        dueDate: string,
        readonly: boolean,
        action: string,
    }>();

    
    const emits = defineEmits<{
        (e: 'installmentsGenerated', value: TinstallmentsData[]),
        (e: 'existsInstallments', value: boolean)
        
    }>();

    const openPaymentDialog = (installment) => {
        selectedInstallment.value = installment;
        paymentAmount.value = installment.valueOriginal - installment.valuePaid;
        paymentDialog.value = true;
    };

    const getReceives = async (receiveDocument: number) => {
        try {
            const res = await api.get(`/ecommerce/receive/one/${receiveDocument}`);
                installmentsData.value = res.data.data || [];
                console.log(res.data);
        } catch (error) {
            $q.notify({
                color: "negative",
                position: "top",
                message: "Erro ao buscar parcelas!",
            });
            console.error('Erro ao buscar parcelas: ', error);
            installmentsData.value = [];
        }
    }

    const generateInstallments = async () =>
    {
        let receiveAmount = props.amount;
        let originalValue = props.originalValue;
        let dueDate = props.dueDate;

        if (installmentsData.value.length > 1) {
            emits('existsInstallments', true);
            return;
        }

        installmentsData.value = [];
        for(let i = 1; i < receiveAmount + 1; i++)
        {
            installmentsData.value.push({
                installmentCode: props.receiveDocument,
                installmentNumber: i,
                installmentAmount: receiveAmount,
                valueOriginal: props.originalValue / receiveAmount,
                valuePaid: 0,
                dueDate: dayjs(dueDate).add(i - 1, 'month').format('YYYY-MM-DD'),
                paid: false,
                selectedForAdvance: false,
                paidAmountEditable: 0,
                status: 'em aberto',
            }); 
        };

        if (installmentsData.value.length === receiveAmount) {
            emits('installmentsGenerated', installmentsData.value);
        }

        console.log(installmentsData);
    };

    const confirmInstallmentPayment = async () => {
        if (!selectedInstallment.value || paymentAmount.value <= 0) return;

        if (paymentAmount.value > remaining.value) {
            $q.notify({
                color: 'negative',
                message: `O valor excede o saldo da parcela (R$ ${remaining.value.toFixed(2)}).`,
                position: 'top'
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

            selectedInstallment.value.paid = (selectedInstallment.value.valuePaid + paymentAmount.value) >= selectedInstallment.value.valueOriginal;
            selectedInstallment.value.valuePaid += paymentAmount.value;
            selectedInstallment.value.paymentDate = payload.paymentDate;

            $q.notify({
                color: 'positive',
                message: 'Parcela paga com sucesso!',
                position: 'top',
            });

            paymentDialog.value = false;
        } catch (error) {
            console.error(error);
            $q.notify({
                color: 'negative',
                message: 'Erro ao registrar pagamento!',
                position: 'top',
            });
        }
    };

    const confirmAdvance = async () => {
        let totalToAdvance = advanceAmount.value;
        const selectedInstallments = installmentsData.value.filter(i => i.selectedForAdvance);

        for (const i of selectedInstallments) {
            const remaining = i.valueOriginal - i.valuePaid;
            const toPay = Math.min(remaining, totalToAdvance);
            
            if (toPay > 0) {
            await api.put(`/ecommerce/receive/payInstallment/${selectedInstallment.value.installmentCode}`, {
                issuerID: LocalStorage.getItem('issuer_id'), 
                paymentDate: dayjs().format('YYYY-MM-DD'),
                installmentPaid: toPay,
            });

            i.valuePaid += toPay;
            i.paid = i.valuePaid >= i.valueOriginal;
            i.status = i.paid ? 'quitada' : 'parcial';
            i.paymentDate = dayjs().format('YYYY-MM-DD');
            totalToAdvance -= toPay;
            }

            if (totalToAdvance <= 0) break;
        }

        $q.notify({ color: 'positive', message: 'Adiantamento concluído!' });
    };

    const undoPayOff =  async (installment) => {
        try {
            const payload = {
                paid: false,
                paymentDate: null,
            };

            await api.put(`/ecommerce/receive/undoInstallment/${installment.id}`, payload);

            installment.paid = false;
            installment.paymentDate = undefined;

            $q.notify({
                color: "warning",
                position: "top",
                message: "Quitação desfeita!",
            });

        } catch (error) {
            $q.notify({
                color: "negative",
                position: "top",
                message: "Erro ao desfazer quitação!",
            });
            console.error('Erro ao desfazer quitação: ', error);
        }
    };

    const formatCurrency = (value: number) => {
        return new Intl.NumberFormat('pt-BR', {
            style: 'currency',
            currency: 'BRL',
        }).format(value);
    };

    const deleteInstallments = () => 
    {
        installmentsData.value = [];
        console.log(installmentsData)
    };

    defineExpose({
        generateInstallments,
        deleteInstallments,
    });

    onMounted(() => {
        if ((props.action === 'view' || props.action === 'update') && props.selectedRegister) {
            installmentsData.value = [...props.selectedRegister.installments];
        }

        if (props.receiveDocument) {
            getReceives(props.receiveDocument);
        }

        console.log(props.receiveDocument);
    });

    watch(() => props.receiveDocument, (newVal) => {
        if (newVal) {
            getReceives(newVal);
        } else {
            installmentsData.value = [];
        }
    }, { immediate: true });

    const remaining = computed(() => {
        if (!selectedInstallment.value) return 0;
        return selectedInstallment.value.valueOriginal - selectedInstallment.value.valuePaid;
    });
</script>