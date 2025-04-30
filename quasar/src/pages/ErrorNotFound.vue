<template>
  <div class="fullscreen bg-blue text-white text-center q-pa-md flex flex-center">
    <div>
      <img src="https://blog.superbid.net/wp-content/uploads/2018/09/escavadeira.png" alt="" srcset="">

      <div class="text-h2 mt-5" style="opacity:.4">
        Em construção!
        <span>404 not found</span>
      </div>
      

      <q-btn
        class="q-mt-xl"
        color="white"
        text-color="blue"
        unelevated
        :to="`/${issuer_name}/home`"
        label="Voltar para a página inicial"
        no-caps
      />
    </div>
  </div>
</template>

<script setup>
    import { LocalStorage } from 'quasar';
    const issuer_name = LocalStorage.getItem("first_name")
</script>
