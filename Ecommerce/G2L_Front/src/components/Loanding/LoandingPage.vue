<template>
  <div class="fixed inset-0 z-50 flex items-center justify-center bg-opacity-40 backdrop-blur-sm">
    <div class="bg-white p-8 rounded-xl shadow-lg flex flex-col items-center gap-4">
        <h1 class="text-2xl font-bold text-gray-700">{{ props.text }}</h1>
        <q-spinner color="primary" size="40px" />      
    </div>
  </div>
</template>

<script setup lang="ts">
    import { defineEmits, defineProps, onMounted } from 'vue';

    const emits = defineEmits<{
        (e: 'showPage', value: boolean)
        
    }>();

    const props = defineProps<{
        text: string

    }>();

    onMounted(() => {
        setTimeout(() =>{
            emits('showPage', true);

        }, 2000);
    });
</script>