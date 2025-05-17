<template>
    <router-view/>
    <ErrorDialog ref="errorDialog" />
</template>

<script setup>
    import ErrorDialog from 'src/components/Error/ErrorDialog.vue';
    import { onMounted, ref, onBeforeUnmount } from 'vue';
    import emitter from 'src/utils/eventBus';
    import { LocalStorage } from 'quasar';

    const errorDialog = ref(null);

    const showGlobalError = (msg) => {
        errorDialog.value?.showError(msg);
        
    };

    onMounted(() => {
        LocalStorage.removeItem("pdvID")
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

    html {
        background-color: rgb(229 231 235);
    }

</style>