<template>
    <q-select
        v-model="ipi"
        :options="codsIPI" 
        label="Cód" 
        color="grey-7"
        class="m-2"
        @update:model-value="selected"
    />
</template>

<script setup lang="ts">
    import { ref } from 'vue'

    const ipi = ref(null);
    const codsIPI = ref([
        { label: "00 - ENTRADA COM RECUPERAÇÃO DE CRÉDITO", cod: "00" },
        { label: "01 - ENTRADA TRIBUTADA COM ALÍQUOTA ZERO", cod: "01" },
        { label: "02 - ENTRADA ISENTA", cod: "02" },
        { label: "03 - ENTRADA NÃO TRIBUTADA", cod: "03" },
        { label: "04 - ENTRADA IMUNE", cod: "04" },
        { label: "05 - ENTRADA COM SUSPENSÃO", cod: "05" },
        { label: "49 - OUTRAS ENTRADAS", cod: "49" },
        { label: "50 - SAÍDA TRIBUTADA", cod: "50" },
        { label: "51 - SAÍDA TRIBUTADA COM ALÍQUOTA ZERO", cod: "51" },
        { label: "52 - SAÍDA ISENTA", cod: "52" },
        { label: "53 - SAÍDA NÃO TRIBUTADA", cod: "53" },
        { label: "54 - SAÍDA IMUNE", cod: "54" },
        { label: "55 - SAÍDA COM SUSPENSÃO", cod: "55" }
    ]);

    const selected = () => {
        emits('selected', ipi.value);

    }

    const emits = defineEmits([
        'selected'
    ])

</script>