<template>
    <h1>Clientes</h1>
</template>

<script setup lang="ts">
    import { api } from 'src/boot/axios';
    import { onMounted, ref } from 'vue';
    
    const customers = ref<ICustomers[]>([]);

    const getDatas = async () =>
    {
        const res = await api.get('/access/customers/all');
        const data = res.data;
        customers.value = data.data;

    };

    onMounted(() => {
        getDatas();

    });
</script>