<template>
    <div class="lg:col-span-2 flex justify-end gap-4">
        <q-btn
            label="Gerar Parcelas"
            color="primary"
            class="mb-2"
            @click="generateInstallments()"
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
                    <td>{{ installment.numberInstallment }}</td>
                    <td>{{ installment.qtdeInstallment }}</td>
                    <td>{{ installment.dueDate }}</td>
                    <td>{{ installment.valuePaid }}</td>
                    <td>{{ installment.valueOriginal }}</td>
                </tr>
            </tbody>
        </table>
    </div>

</template>

<script setup lang="ts">
    import { ref, defineProps, defineEmits } from 'vue';

    type TinstallmentsData = {
        id: number;
        numberInstallment: number;
        qtdeInstallment: number;
        dueDate: string;
        valuePaid: number;
        valueOriginal: number;
    };

    const emits = defineEmits<{
        (e: 'update:inspecInstallment', value: TinstallmentsData)
    }>();

    const props = defineProps<{
        pdv: boolean

    }>();

    let installmentsData = ref<TinstallmentsData[]>([]);

    const generateInstallments = async () =>
    {
        
    };

    const deleteInstallments = async () => 
    {

    };

</script>