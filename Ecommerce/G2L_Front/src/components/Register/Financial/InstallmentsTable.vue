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
        :style="{ width: readonly ? '1000px' : '1000px', height: readonly ? '400px' : '250px'}"
        >
        <table class="min-w-full border-collapse bg-white text-sm">
            <thead class="sticky top-0 z-10 bg-blue-600 text-white">
                <tr>
                    <th class="px-2 py-1">Nº Parcela</th>
                    <th class="px-2 py-1">Qtde. Parcelas</th>
                    <th class="px-2 py-1">Data Vencimento</th>
                    <th class="px-2 py-1">Valor à pagar</th>
                    <th class="px-2 py-1">Valor Original</th>
                    <th class="px-2 py-1" v-if="action === 'view'">Data Pagamento</th>
                    <th class="px-2 py-1" v-if="action === 'view'">Status</th>
                    <th class="px-2 py-1" v-if="readonly">Ações</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="(installment, id) in installmentsData" :key="id" class="text-center border-t border-gray-300" :class="{ 'bg-green-100': installment.paid, 'bg-white': !installment.paid}">
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
                        />
                    </td>
                    <td>{{ formatCurrency(installment.valuePaid) }}</td>
                    <td>{{ formatCurrency(installment.valueOriginal) }}</td>
                    <td v-if="action === 'view'">{{ installment.paymentDate }}</td>
                    <td v-if="action === 'view'">
                        <span :class="installment.paid ? 'text-green-600' : 'text-red-600'">
                            {{ installment.paid ? 'Quitada' : 'Em aberto' }}
                        </span>
                    </td>
                    <td v-if="action === 'view'">
                        <q-btn
                            size="sm"
                            icon="check"
                            color="green"
                            @click="payOffIstallment(installment)"
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
</template>

<script setup lang="ts">
    import { api } from "src/boot/axios";
    import { ref, defineProps, defineEmits, computed, onMounted, watch } from 'vue';
    import dayjs from 'dayjs';


    type TinstallmentsData = {
        installmentNumber: number;
        installmentAmount: number;
        dueDate: string;
        valuePaid: number;
        valueOriginal: number;
        paid: boolean;
        paymentDate?: string;
    };


    const emits = defineEmits<{
        (e: 'installmentsGenerated', value: TinstallmentsData[]),
        (e: 'existsInstallments', value: boolean)

    }>();

    const props = defineProps<{
        installments: TinstallmentsData[];
        pdv?: boolean,
        amount: number,
        originalValue: number,
        dueDate: string,
        readonly: boolean,
        action: string,
    }>();

    let installmentsData = ref<TinstallmentsData[]>(props.installments || []);

    const generateInstallments = async () =>
    {
        let receiveAmount = props.amount;
        let originalValue = props.originalValue;
        let dueDate = props.dueDate;

        if (installmentsData.value.length > 1) {
            emits('existsInstallments', true);
            return;
        }

        for(let i = 1; i < receiveAmount + 1; i++)
        {
            installmentsData.value.push({
                installmentNumber: i,
                installmentAmount: receiveAmount,
                valueOriginal: props.originalValue,
                valuePaid: Number(String(originalValue).replace(',','.')) / receiveAmount,
                dueDate: dayjs(dueDate).add(i - 1, 'month').format('YYYY-MM-DD'),
                paid: false,
            }); 
        };

        if (installmentsData.value.length === receiveAmount) {
            emits('installmentsGenerated', installmentsData.value);
        }

        console.log(installmentsData);
    };

    const payOffIstallment = (installment) => {
        installment.paid = true;
        installment.paymentDate = dayjs().format('YYYY-MM-DD');
    };

    const undoPayOff = (installment) => {
        installment.paid = false;
        installment.paymentDate = undefined;
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

    watch(
        () => props.installments,
        (newVal) => {
            installmentsData.value = [...newVal];
        }
    );

</script>