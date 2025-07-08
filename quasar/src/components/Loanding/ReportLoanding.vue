<template>
  <div v-if="props.generate" class="fixed inset-0 z-50 flex items-center justify-center  bg-opacity-40 backdrop-blur-sm">
    <div class="bg-white p-8 rounded-xl shadow-lg flex flex-col items-center gap-4">
      <h1 class="text-2xl font-bold text-gray-700"> {{ baseText }}</h1>
      <span class="loader"></span>
      
    </div>
  </div>
</template>


<script setup lang="ts">
    import { ref, defineProps, onMounted } from 'vue';

    let baseText = ref<string>('Gerando relatório...');

    const props = defineProps<{
        generate: boolean,
        report: string
        
    }>();

    onMounted(() => {
        const texts = {
            'products': 'Gerando relatórios de produtos ...',
            'customer': 'Gerando relatórios de clientes ...',
        };

        baseText.value = texts[props.report];
        console.log('Novo baseText: ', baseText.value);
    
    });

</script>

<style lang="scss">
    .loader {
      width: 64px;
      height: 64px;
      border-radius: 50%;
      position: relative;
      animation: rotate 1s linear infinite;
      margin: 0 auto;
      display: block;
    }

    .loader::before {
      content: "";
      box-sizing: border-box;
      position: absolute;
      inset: 0px;
      border-radius: 50%;
      border: 5px solid #3B82F6; // Azul Quasar/Tailwind
      border-top-color: transparent;
      animation: prixClipFix 2s linear infinite;
    }

    @keyframes rotate {
      100% { transform: rotate(360deg); }
    }

    @keyframes prixClipFix {
      0%   { clip-path: polygon(50% 50%, 0 0, 0 0, 0 0, 0 0, 0 0); }
      25%  { clip-path: polygon(50% 50%, 0 0, 100% 0, 100% 0, 100% 0, 100% 0); }
      50%  { clip-path: polygon(50% 50%, 0 0, 100% 0, 100% 100%, 100% 100%, 100% 100%); }
      75%  { clip-path: polygon(50% 50%, 0 0, 100% 0, 100% 100%, 0 100%, 0 100%); }
      100% { clip-path: polygon(50% 50%, 0 0, 100% 0, 100% 100%, 0 100%, 0 0); }
    }

</style>