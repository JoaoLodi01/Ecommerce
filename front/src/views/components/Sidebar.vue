<template>
  <div class="relative">
    <!-- Sidebar com transição -->
    <b-sidebar
      :class="{
        'transform translate-x-0': sidebarActive, 
        'transform -translate-x-full': !sidebarActive}"
      class="transition-transform duration-300 bg-gray-800 text-white h-screen w-64 fixed top-0 left-0 z-40"
      title="Sidebar">

      <!-- Botão Sidebar-->
      <button 
        @click="toggleSidebar"
        class="absolute top-4 right-4 p-2 bg-gray-800 hover:text-blue-300 text-white border-none rounded-lg cursor-pointer z-50">
        <span 
          v-if="!sidebarActive"
          class=""
        >
          Open
        </span>

        <span 
          v-else
          class="transition-transform duration-300"
        >
          <div class="border border-white w-4 mb-1"></div>
          <div class="border border-white w-5 mt-1"></div>
          <div class="border border-white w-6 mt-1"></div>
        </span>
      </button>

      <!-- Links Sidebar-->
      <div class="sidebar-header p-4">
        <h1 class="text-2xl font-semibold">Menu</h1>
      </div>
      <div class="sidebar-links p-4">
        <ul class="space-y-4">
          <li>
            <router-link to="/" class="text-white hover:text-blue-300">Início</router-link>
          </li>
          <li>
            <router-link to="/consumers" class="text-white hover:text-blue-300">Clientes</router-link>
          </li>
          <li>
            <router-link to="/products" class="text-white hover:text-blue-300">Produtos</router-link>
          </li>
          <li>
            <router-link to="/cash-register" class="text-white hover:text-blue-300">Caixa</router-link>
          </li>
          <li>
            <router-link to="/pdv" class="text-white hover:text-blue-300">PDV</router-link>
          </li>
          <li>
            <router-link to="/hotel" class="text-white hover:text-blue-300">Hotel</router-link>
          </li>
          <li>
            <router-link to="/settings" class="text-white hover:text-blue-300">Configurações</router-link>
          </li>
          </ul>
        </div>
    </b-sidebar>

    <!-- Botão da Sidebar fechada -->
    <button 
      v-if="!sidebarActive"
      @click="toggleSidebar"
      class="toggle-btn absolute top-2 left-4 p-3 bg-gray-800 text-white border-none cursor-pointer z-50 rounded-lg transform transition-all">
      <span>
        <div class="border border-white w-6 mb-1"></div>
        <div class="border border-white w-5 mt-1"></div>
        <div class="border border-white w-4 mt-1"></div>
      </span>
    </button>
  </div>
</template>

<script>
export default {
  data() {
    return {
      sidebarActive: false,
    };
  },
  methods: {
    toggleSidebar() {
      this.sidebarActive = !this.sidebarActive;
    },
  },
};
</script>
