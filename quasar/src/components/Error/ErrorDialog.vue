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
        <q-btn flat label="Fechar" color="red" v-close-popup />
      </q-card-actions>
    </q-card>
  </q-dialog>
</template>

<script setup>
  import { ref, defineExpose } from 'vue';

  const visible = ref(false);
  const message = ref('');

  function showError(msg) {
    message.value = msg || 'Erro desconhecido';
    visible.value = true;
  }

  defineExpose({ showError });
</script>
