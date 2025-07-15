<template>
    <q-select
        v-model="pis"
        :options="codsPIS" 
        label="Cód" 
        color="grey-7"
        class="m-2"
        @update:model-value="selected"
    />
</template>
 
<script setup lang="ts">
    import { ref } from 'vue'

    const pis = ref(null)
    const codsPIS = ref([
        { label: "01 - OPERAÇÃO TRIBUTÁVEL COM ALÍQUOTA BÁSICA", cod: "01" },
        { label: "02 - OPERAÇÃO TRIBUTÁVEL COM ALÍQUOTA DIFERENCIADA", cod: "02" },
        { label: "03 - OPERAÇÃO TRIBUTÁVEL COM ALÍQUOTA POR UNIDADE DE MEDIDA DE PRODUTO", cod: "03" },
        { label: "04 - OPERAÇÃO TRIBUTÁVEL MONOFÁSICA - REVENDA A ALÍQUOTA ZERO", cod: "04" },
        { label: "05 - OPERAÇÃO TRIBUTÁVEL POR SUBSTITUIÇÃO TRIBUTÁRIA", cod: "05" },
        { label: "06 - OPERAÇÃO TRIBUTÁVEL A ALÍQUOTA ZERO", cod: "06" },
        { label: "07 - OPERAÇÃO ISENTA DA CONTRIBUIÇÃO", cod: "07" },
        { label: "08 - OPERAÇÃO SEM INCIDÊNCIA DA CONTRIBUIÇÃO", cod: "08" },
        { label: "09 - OPERAÇÃO COM SUSPENSÃO DA CONTRIBUIÇÃO", cod: "09" },
        { label: "49 - OUTRAS OPERAÇÕES DE SAÍDA", cod: "49" },
        { label: "50 - OPERAÇÃO COM DIREITO A CRÉDITO - VINCULADA EXCLUSIVAMENTE A RECEITA TRIBUTADA NO MERCADO INTERNO", cod: "50" },
        { label: "51 - OPERAÇÃO COM DIREITO A CRÉDITO - VINCULADA EXCLUSIVAMENTE A RECEITA NÃO TRIBUTADA NO MERCADO INTERNO", cod: "51" },
        { label: "52 - OPERAÇÃO COM DIREITO A CRÉDITO - VINCULADA EXCLUSIVAMENTE A RECEITA DE EXPORTAÇÃO", cod: "52" },
        { label: "53 - OPERAÇÃO COM DIREITO A CRÉDITO - VINCULADA A RECEITAS TRIBUTADAS E NÃO-TRIBUTADAS NO MERCADO INTERNO", cod: "53" },
        { label: "54 - OPERAÇÃO COM DIREITO A CRÉDITO - VINCULADA A RECEITAS TRIBUTADAS NO MERCADO INTERNO E DE EXPORTAÇÃO", cod: "54" },
        { label: "55 - OPERAÇÃO COM DIREITO A CRÉDITO - VINCULADA A RECEITAS NÃO-TRIBUTADAS NO MERCADO INTERNO E DE EXPORTAÇÃO", cod: "55" },
        { label: "56 - OPERAÇÃO COM DIREITO A CRÉDITO - VINCULADA A RECEITAS TRIBUTADAS E NÃO-TRIBUTADAS NO MERCADO INTERNO, E DE EXPORTAÇÃO", cod: "56" }

    ])

    const selected = () => {
        emits('selected', pis.value)
    }

    const emits = defineEmits([
        'selected'
    ])

</script>