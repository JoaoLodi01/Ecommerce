<template>
  <div class="absolute top-1">
    <Sidebar />
  </div>

  <div class="relative ml-56">
    <router-view></router-view>
  </div>
</template>

<script>
import Sidebar from './components/Sidebar.vue';

  export default {
    components: {
      Sidebar
    }
  }

</script>
