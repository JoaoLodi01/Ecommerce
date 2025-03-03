<template>
    <div class="sidebar" >
        <div class="sidebar-header">
            <h2>Menu</h2>
        </div>

        <ul class="sidebar-links">
            <li><router-link to="/">Início</router-link></li>
            <li><router-link to="/consumers">Clientes</router-link></li>
            <li><router-link to="/products">Produtos</router-link></li>
            <li><router-link to="/cash-register">Caixa</router-link></li>
            <li><router-link to="/nfce">NFC-e</router-link></li>
            <li><router-link to="/hotel"></router-link>Hotel</li>
            <li><router-link to="/settings"></router-link>Configurações</li>
        </ul>
    </div>
</template>

<style>
.sidebar{
    width: 100px;
    height: 100vh;
}

@media (max-width: 768px) {
  .sidebar {
    width: 0;
    visibility: hidden;
    transition: all 0.3s ease;
  }
  
  .sidebar.active {
    width: 250px;
    visibility: visible;
  }
}
</style>