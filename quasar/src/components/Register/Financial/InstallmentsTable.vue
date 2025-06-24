<template>
    <div class="lg:col-span-2 flex justify-end gap-4">
        <q-btn
            label="Gerar Parcelas"
            color="primary"
            class="mb-2"
            @click="generateInstallments()"
            :disable="originalValue <= 0 || amount <= 0"
        />

        <q-btn
            label="Excluir Parcelas"
            color="negative"
            class="mb-2"
            @click="deleteInstallments()"
        />
    </div>

    <div class="lg:col-span-2 overflow-y-auto border border-gray-400 rounded-md shadow-sm" style="height: 230px;">
        <table class="min-w-full border-collapse bg-white text-sm">
            <thead class="sticky top-0 z-10 bg-blue-600 text-white">
                <tr>
                    <th class="px-2 py-1">Nº Parcela</th>
                    <th class="px-2 py-1">Qtde. Parcelas</th>
                    <th class="px-2 py-1">Data Vencimento</th>
                    <th class="px-2 py-1">Valor à pagar</th>
                    <th class="px-2 py-1">Valor Original</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="(installment, id) in installmentsData" :key="id" class="text-center border-t border-gray-300">
                    <td>{{ installment.number_installment }}</td>
                    <td>{{ installment.installment_amount }}</td>
                    <td>
                        <q-input
                            type="date"
                            v-model="installment.due_date"
                            dense
                            outlined
                            color="primary"
                            class="w-[150px] flex justify-center"
                        />
                    </td>
                    <td>R$ {{ installment.value_paid }}</td>
                    <td>R$ {{ installment.value_original }}</td>
                </tr>
            </tbody>
        </table>
    </div>

</template>

<script setup lang="ts">
    import { ref, defineProps, defineEmits } from 'vue';
    import dayjs from 'dayjs';

    type TinstallmentsData = {
        id: number;
        number_installment: number;
        installment_amount: number;
        due_date: string;
        value_paid: number;
        value_original: number;

    };

    const emits = defineEmits<{
        (e: 'updated:inspecInstallment', value: TinstallmentsData),
        (e: 'existsInstallments', value: boolean)

    }>();

    const props = defineProps<{
        pdv?: boolean,
        amount: number,
        originalValue: number,
        dueDate: string
    }>();

    let installmentsData = ref<TinstallmentsData[]>([]);

    const generateInstallments = async () =>
    {
        let receiveAmount = props.amount;
        let originalValue = props.originalValue;
        let dueDate = props.dueDate
        console.log('generateInstallments, amount: ', props.amount);
        console.log(originalValue)

        if (installmentsData.value.length > 1) {
            emits('existsInstallments', true);
            return;
        }

        for(let i = 1; i < receiveAmount + 1; i++)
        {
            installmentsData.value.push({
                id: i,
                number_installment: i,
                installment_amount: receiveAmount,
                value_original: props.originalValue,
                value_paid: Number(String(originalValue).replace(',','.')) / receiveAmount,
                due_date: dayjs(dueDate).add(i - 1, 'month').format('YYYY-MM-DD')

            }); 
        };

    };

    const deleteInstallments = () => 
    {
        installmentsData.value = [];
    };

    defineExpose({
        generateInstallments,
        deleteInstallments,
    });

</script>