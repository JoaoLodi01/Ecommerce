<template>
    {{ props.message }}
    
</template>
<script setup lang="ts">
    import { defineProps } from 'vue';
    
    const props = defineProps<{
        message: string
    }>();

</script>