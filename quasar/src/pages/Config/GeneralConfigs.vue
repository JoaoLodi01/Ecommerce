<template>
    <div v-if="!showPage">
        <LoandingPage
            @show-page="showPage = $event"
            :page="'de configurações'"

        />

    </div>
    <div class="ml-16 text-3xl" v-if="showPage">
        <h1>Configs gerais</h1>

    </div>


</template>

<script setup lang="ts">
    import LoandingPage from 'src/components/Loanding/LoandingPage.vue';
    import { ref } from 'vue';

    let showPage = ref<boolean>(false);

</script>