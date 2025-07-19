<template>
    <q-table
        title="Table Title"
        :data="data"
        :columns="columns"
        row-key="name"
        hide-bottom

    />
</template>

<script setup lang="ts">
    import { ref } from 'vue';

    const columns = [
        { name: 'cod'} 
    ];
</script>