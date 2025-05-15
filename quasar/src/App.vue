<template>
    <div class="">
        <router-view/>
        <ErrorDialog ref="errorDialog" />
    </div>
    
</template>

<script setup>
    import ErrorDialog from 'src/components/Error/ErrorDialog.vue';
    import { onMounted, ref, onBeforeUnmount } from 'vue';
    import emitter from 'src/utils/eventBus';

    const errorDialog = ref(null);

    const showGlobalError = (msg) => {
        errorDialog.value?.showError(msg);
    };

    onMounted(() => {
        emitter.on('global-error', showGlobalError);
    });

    onBeforeUnmount(() => {
        emitter.off('global-error', showGlobalError);
    });
</script>


<style lang="scss">
    @media (min-width: 1366px)
    {
        body{
            overflow-x: hidden;

        }
    }

</style>