<template>
    <div>
        <h1>Clip</h1>
    </div>
    <q-btn 
        color="primary" 
        label="Copiar" 
        class="btn"
        @click="clipBoard" 
        :data-clipboard-text="textoAcopiar"
    />
</template>

<script setup lang="ts">
    import clipBoard from 'src/services/clipboard';
    import { ref } from 'vue'

    let textoAcopiar = ref('Texto copiado')

</script>