<template>
    <span v-if="typeError === 'cnpj'">{{ $t(`message.errorCNPJ`) }}</span>
    <span v-if="typeError === 'cep'">{{ props.message }}</span>

</template>
<script setup lang="ts">
    import { defineProps } from 'vue';
    
    const props = defineProps<{
        message: string,
        typeError: string

    }>();

</script>