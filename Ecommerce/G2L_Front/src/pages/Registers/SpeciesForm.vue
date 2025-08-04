<template>
    <div class="container mx-auto mt-10 p-6 ml-16 bg-white rounded-lg shadow-lg">
        <div class="flex justify-between items-center mb-6">
            <h2 class="text-2xl font-semibold">Espécies</h2>
            
            <div class="flex space-x-4">
                <q-btn
                    v-if="!showSpeciesManagement"
                    class="p-2 rounded-lg"
                    :style="`background-color: ${buttonColor}; color: ${textColor}`"
                    @click="speciesManagement('create', 0)"
                    label="Cadastrar"

                />

                <q-btn 
                    v-if="showSpeciesManagement"
                    label="Voltar"
                    @click="showSpeciesManagement = false" 
                    :style="`background-color: ${buttonColor}; color: ${textColor}`"

                />
            </div>
        </div>

        <div v-if="!showSpeciesManagement">
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
                                    :style="`background-color: ${buttonColor}; color: ${textColor}`"
                                    icon="edit"
                                    @click="speciesManagement('update', props.row.payment_code)"
                                />
                            </template>

                            <template v-else>
                                {{ col.value }}
                            </template>

                        </q-td>
                    </q-tr>
                </template>
            </q-table>
        </div>

        <div v-if="showSpeciesManagement">
            <SpeciesManagement
                :operation="operation"
                :species-code="speciesCodeSelected"
                @close="resetManagement($event)"

            />

        </div>
    </div>
</template>

<script setup lang="ts">
    import { LocalStorage, QTableColumn } from 'quasar';
    import { api } from 'src/boot/axios';
    import { ref, onMounted } from 'vue';
    import SpeciesManagement from 'src/components/Register/Others/SpeciesManagement.vue';

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
    const buttonColor = ref<string>(LocalStorage.getItem("buttonColor"));
    const textColor = ref<string>(LocalStorage.getItem("textColor"));

    let species = ref<ISpecies[]>([]);
    let showSpeciesManagement = ref<boolean>(false);
    let operation = ref<string>('');
    let speciesCodeSelected = ref<number>(0);
    
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

    const speciesManagement = (typeOperation: string, specieCode: number) =>
    {
        operation.value = typeOperation;
        speciesCodeSelected.value = specieCode;
        showSpeciesManagement.value = true;

    };

    const resetManagement = (event: boolean) =>
    {
        speciesCodeSelected.value = 0;
        showSpeciesManagement.value = !event

    };

    onMounted(() => {
        getSpecies();
    });
</script>