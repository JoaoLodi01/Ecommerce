<template>
  <q-dialog v-model="visible" persistent>
    <q-card class="bg-red-100 text-red-900">
      <q-card-section class="text-h6">
        Ocorreu um erro
      </q-card-section>

      <q-card-section>
        {{ message }}
      </q-card-section>

      <q-card-actions align="right">
        <q-btn id="closeButton" flat label="Fechar" color="red" v-close-popup />
      </q-card-actions>
    </q-card>
  </q-dialog>
</template>

<script setup lang="ts">
    import { ref, defineExpose, onMounted } from 'vue';

    const visible = ref<boolean>(false);
    const message = ref<string>('');

    function showError(msg: string) 
    {
        message.value = msg || 'Erro desconhecido';
        visible.value = true;
    };

    defineExpose({ showError });
    
    onMounted(() => {
        document.addEventListener('keydown', (event: KeyboardEvent) => {
            const keyName = event.key;

            if(keyName === ' ' || keyName === 'Escape') {
                visible.value = false;
            };
        });
    });
</script>   