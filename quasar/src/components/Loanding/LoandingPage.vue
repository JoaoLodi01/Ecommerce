<template>
</template>

<script setup lang="ts">
    import { useQuasar } from 'quasar';
    import { onMounted, defineEmits, defineProps } from 'vue';
    
    const props = defineProps<{
        page: string
    }>();

    const emits = defineEmits<{
        (e: 'showPage', value: boolean): void

    }>();

    const $q = useQuasar();
    let timer: any;

    const showLoading = () => 
    {
        $q.loading.show({
            message: `Carregando a página ${props.page} ...`
            
        });

        timer = setTimeout(() => {
            $q.loading.hide()
            timer = void 0
            emits('showPage', true);

        }, 3000);
    };

    onMounted(() => {
        showLoading();

    });
</script>