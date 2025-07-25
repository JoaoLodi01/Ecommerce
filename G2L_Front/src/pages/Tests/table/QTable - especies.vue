<template>
    <q-table
        :rows="species"
        :columns="columns"
        row-key="name"
        hide-bottom
    >
        <template v-slot:header="props">
            <q-tr 
                :props="props"
                :style="`background-color: ${painelColor}; color: ${textColor}`"
            >
                <q-th
                    v-for="col in props.cols"
                    :key="col.name"
                    :props="props"
                    :style="`color: ${textColor}`"
                >
                    {{ col.label }}
                </q-th>
            </q-tr>                    
        </template>
        <template v-slot:body="props">
            <q-tr
                :props="props"
                
            >
                <q-td
                    v-for="(col, i) in props.cols"
                    :key="col.name"
                    :props="props"
                >
                    <template v-if="col.name === 'actions'">
                        <q-btn 
                            color="primary" 
                        />
                    </template>

                    <template v-else>
                        {{ col.value }}
                    </template>

                </q-td>
            </q-tr>
        </template>
    </q-table>
</template>

<script setup lang="ts">
    import { LocalStorage, QTableColumn } from 'quasar';
    import { api } from 'src/boot/axios';
    import { ref, onMounted } from 'vue';

    interface ISpecies {
        paymentCode: number,
        issuerID: number,
        especie: string,
        tipoLancamento: string,
        paymentsFormType: string,
        pixKey: string|unknown,
        bankKey: string|unknown,
        otherKey: string|unknown
    };

    const issuerID = LocalStorage.getItem("issuer_id");
    const painelColor = LocalStorage.getItem("painelColor");
    const textColor = LocalStorage.getItem("textColor");

    let species = ref<ISpecies[]>([]);
    
    const columns: QTableColumn[] = [
        {
            name: 'payment_code',
            label: 'Cód',
            field: 'payment_code',
            align: 'center'
        },
        {
            name: 'especie',
            label: 'Espécie',
            field: 'especie',
            align: 'center'
        },
        {
            name: 'tipo_lancamento',
            label: 'Tipo do lançamento',
            field: 'tipo_lancamento',
            align: 'center'
        },
        {
            name: 'actions',
            label: 'Ações',
            field: 'actions',
            align: 'center'
        },
    ];

    const getSpecies = async () =>
    {
        const res = await api.get(`/species/all/${issuerID}`);
        const data = res.data.data;
        species.value = data;
    };

    onMounted(() => {
        getSpecies();
    });
</script>