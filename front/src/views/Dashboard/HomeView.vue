<template>
  <div class="welcome">
    <h1 class="title bg-white p-2">Bem vindo!</h1>
  </div>
  <Sidebar />

</template>

<script>
import Sidebar from '../components/Sidebar.vue';

export default{

  components: {
    Sidebar,
  },
};
</script>
