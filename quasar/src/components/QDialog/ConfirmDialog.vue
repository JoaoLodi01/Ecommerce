<template>
    <q-dialog v-model="show">
    <q-card>
        <q-card-section class="text-h6">
            Deseja mesmo deletar o cliente ?
        </q-card-section>

        <q-card-actions align="right">
        <q-btn flat label="Cancelar" color="primary" @click="resolve(false)" />
        <q-btn flat label="Deletar" color="negative" @click="resolve(true)"/>
        </q-card-actions>
    </q-card>
    </q-dialog>

</template>

<script setup lang="ts">
    import { ref, defineExpose } from 'vue';

    const show = ref<boolean>(false);
    let resolveReturn: (value: boolean) => void;

    const open = (): Promise<boolean> =>
    {
        show.value = true;
        return new Promise<boolean>((resolve) => {
            resolveReturn = resolve;

        });
    };

    const resolve = async (value: boolean) =>
    {
        show.value = false;
        resolveReturn(value);

    };
</script>