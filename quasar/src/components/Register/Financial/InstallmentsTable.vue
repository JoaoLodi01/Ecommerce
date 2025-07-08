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
                    <!--th class="px-2 py-1">Ações</th!-->
                </tr>
            </thead>
            <tbody>
                <tr v-for="(installment, id) in installmentsData" :key="id" class="text-center border-t border-gray-300">
                    <td>{{ installment.numberInstallment }}</td>
                    <td>{{ installment.installmentAmount }}</td>
                    <td class="w-[150px]">
                        <q-input
                            type="date"
                            v-model="installment.dueDate"
                            dense
                            outlined
                            color="primary"
                            
                        />
                    </td>
                    <td>R$ {{ installment.valuePaid }}</td>
                    <td>R$ {{ installment.valueOriginal }}</td>
                    <!--td>
                        <q-btn
                            size="sm"
                            icon="check"
                            color="green"
                            @click="payOffIstallment(installment)"
                        />
                    </td!-->
                </tr>
            </tbody>
        </table>
    </div>

</template>

<script setup lang="ts">
    import { ref, defineProps, defineEmits, reactive } from 'vue';
    import dayjs from 'dayjs';

    type TinstallmentsData = {
        numberInstallment: number;
        installmentAmount: number;
        dueDate: string;
        valuePaid: number;
        valueOriginal: number;

    };

    const emits = defineEmits<{
        (e: 'installmentsGenerated', value: TinstallmentsData[]),
        (e: 'existsInstallments', value: boolean)

    }>();

    const props = defineProps<{
        pdv?: boolean,
        amount: number,
        originalValue: number,
        dueDate: string,
    }>();

    let installmentsData = ref<TinstallmentsData[]>([]);

    const generateInstallments = async () =>
    {
        let receiveAmount = props.amount;
        let originalValue = props.originalValue;
        let dueDate = props.dueDate

        if (installmentsData.value.length > 1) {
            emits('existsInstallments', true);
            return;
        }

        for(let i = 1; i < receiveAmount + 1; i++)
        {
            installmentsData.value.push({
                numberInstallment: i,
                installmentAmount: receiveAmount,
                valueOriginal: props.originalValue,
                valuePaid: Number(String(originalValue).replace(',','.')) / receiveAmount,
                dueDate: dayjs(dueDate).add(i - 1, 'month').format('YYYY-MM-DD')

            }); 
        };

       if (installmentsData.value.length === receiveAmount) emits('installmentsGenerated', installmentsData.value);

    console.log(installmentsData);

    };

    const payOffIstallment = (installment) => {

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

</script>