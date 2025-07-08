<template>
    <div class="fixed inset-0 z-50 flex items-center justify-center bg-opacity-40 backdrop-blur-sm">
        <div class="bg-white p-8 rounded-xl shadow-lg flex flex-col items-center gap-4">
            <h1 class="text-2xl font-bold text-gray-700">Confirmação</h1>

            <div class="flex">
                <div class="mr-4">
                    <q-btn 
                        color="primary" 
                        label="Confirmar" 
                        @click="submitEmit(true)" 
                        
                    />
                </div>
                
                <div class="mr-4">
                    <q-btn 
                        color="red" 
                        label="Cancelar" 
                        @click="submitEmit(false)" 

                    />
                </div>
            </div>
        </div>
  </div>
</template>


<script setup lang="ts">
    import { defineEmits, defineProps } from 'vue';

    const props = defineProps<{
        operation: string
    }>();

    const emits = defineEmits<{
        (e: 'confirm', value: TEmit[]): void
    }>();

    const submitEmit = (value: boolean) =>
    {
        const data: TEmit[] = [{
            operation: value ? props.operation : 'cancel', 
            value
        }];

        emits('confirm', data);
    }

</script>