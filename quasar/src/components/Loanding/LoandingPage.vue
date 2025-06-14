<template>
</template>

<script setup lang="ts">
    import { useQuasar } from 'quasar';
    import { onMounted, defineProps, defineEmits } from 'vue';
    
    const props = defineProps<PPdv>();

    const emits = defineEmits<{
        (e: 'showPage', value: boolean): void

    }>();

    const $q = useQuasar();
    let timer: any;

    const showLoading = () => 
    {
        $q.loading.show({
            message: 'Carregando esse djabão ...'
        });

        timer = setTimeout(() => {
            $q.loading.hide()
            timer = void 0

        }, 3000);
    };

    const hideLoanding = () => 
    {    
        if(timer !== void 0) {
            clearTimeout(timer)
            $q.loading.hide();

        };
    };

    onMounted(() => {
        showLoading();

        if(props.pdvView)
        {
            
        };
    });
</script>