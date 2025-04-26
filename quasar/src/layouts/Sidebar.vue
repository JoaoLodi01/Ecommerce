<template>
  <div class="relative bg-gray-200 h-screen">
    <!-- Sidebar com transição -->
    <div
      :class="{
        'transform translate-x-0': sidebarActive, 
        'transform -translate-x-full': !sidebarActive,
        
      }"
      class="transition-transform duration-300 bg-gray-800 text-white h-screen w-64 fixed top-0 left-0 z-40"
      title="Sidebar">

      <!-- Botão Sidebar-->
      <button 
        @click="toggleSidebar"
        class="absolute top-4 right-4 p-2 delay-75 bg-gray-800 hover:text-blue-300 border-none rounded-lg cursor-pointer z-50">
        <span 
          v-if="!sidebarActive"
        />

        <span 
          v-else
          
        >
        <!-- Botão quando a SideBar está aberta-->
          <div class="border border-white w-6 mb-1"></div>
          <div class="border border-white w-6 mt-1"></div>
          <div class="border border-white w-6 mt-1"></div>
        </span>
      </button>

      <!-- Links Sidebar-->
      <div class="sidebar-header p-4">
        <h1 class="text-2xl font-semibold ml-5">Menu</h1>
      </div>
      <div class="sidebar-links p-4">
        <ul class="space-y-4">
          <li>
            <router-link to="jjjj" class="ml-5 hover:text-blue-300 flex items-center">
              <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                <path stroke-linecap="round" stroke-linejoin="round" d="m2.25 12 8.954-8.955c.44-.439 1.152-.439 1.591 0L21.75 12M4.5 9.75v10.125c0 .621.504 1.125 1.125 1.125H9.75v-4.875c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125V21h4.125c.621 0 1.125-.504 1.125-1.125V9.75M8.25 21h8.25" />
              </svg>
              <span class="ml-2">Home</span>
            </router-link>
          </li>
          <li>
            <router-link to="/customers" class="ml-5 hover:text-blue-300 flex items-center">
              <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                <path stroke-linecap="round" stroke-linejoin="round" d="M15 19.128a9.38 9.38 0 0 0 2.625.372 9.337 9.337 0 0 0 4.121-.952 4.125 4.125 0 0 0-7.533-2.493M15 19.128v-.003c0-1.113-.285-2.16-.786-3.07M15 19.128v.106A12.318 12.318 0 0 1 8.624 21c-2.331 0-4.512-.645-6.374-1.766l-.001-.109a6.375 6.375 0 0 1 11.964-3.07M12 6.375a3.375 3.375 0 1 1-6.75 0 3.375 3.375 0 0 1 6.75 0Zm8.25 2.25a2.625 2.625 0 1 1-5.25 0 2.625 2.625 0 0 1 5.25 0Z" />
              </svg>
              <span class="ml-2">Clientes</span>
            </router-link> 
          </li>
          <li>
            <router-link to="/products" class="ml-5 hover:text-blue-300 flex items-center">
              <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                <path stroke-linecap="round" stroke-linejoin="round" d="m20.25 7.5-.625 10.632a2.25 2.25 0 0 1-2.247 2.118H6.622a2.25 2.25 0 0 1-2.247-2.118L3.75 7.5M10 11.25h4M3.375 7.5h17.25c.621 0 1.125-.504 1.125-1.125v-1.5c0-.621-.504-1.125-1.125-1.125H3.375c-.621 0-1.125.504-1.125 1.125v1.5c0 .621.504 1.125 1.125 1.125Z" />
              </svg>
              <span class="ml-2">Produtos</span>
            </router-link>
          </li>
          <li class="w-max">
            <a class="ml-5 hover:text-blue-300 flex items-center">
              <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                <path stroke-linecap="round" stroke-linejoin="round" d="M12 21v-8.25M15.75 21v-8.25M8.25 21v-8.25M3 9l9-6 9 6m-1.5 12V10.332A48.36 48.36 0 0 0 12 9.75c-2.551 0-5.056.2-7.5.582V21M3 21h18M12 6.75h.008v.008H12V6.75Z" />
              </svg>
              <button @click="showFinancialFn()">
                <span @click="downRow2 = !downRow2" class="inline-flex ml-2">Financeiro
                    <svg 
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 16 16"
                    fill="currentColor" 
                    class="mt-auto mb-auto size-4"
                    v-if="!downRow2">
                    <path fill-rule="evenodd" d="M8 2a.75.75 0 0 1 .75.75v8.69l3.22-3.22a.75.75 0 1 1 1.06 1.06l-4.5 4.5a.75.75 0 0 1-1.06 0l-4.5-4.5a.75.75 0 0 1 1.06-1.06l3.22 3.22V2.75A.75.75 0 0 1 8 2Z" clip-rule="evenodd" />
                  </svg> <!-- Flecha pra baixo -->

                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 16 16"
                    fill="currentColor"
                    class="mt-auto mb-auto size-4"
                    v-if="downRow2">
                    <path fill-rule="evenodd" d="M8 14a.75.75 0 0 0 .75-.75V4.56l1.22 1.22a.75.75 0 1 0 1.06-1.06l-2.5-2.5a.75.75 0 0 0-1.06 0l-2.5 2.5a.75.75 0 0 0 1.06 1.06l1.22-1.22v8.69c0 .414.336.75.75.75Z" clip-rule="evenodd" />
                  </svg> <!-- Flecha pra cima -->
                </span>
              </button>
            </a>
            <div v-if="showFinancial" class="ml-12 bg-gray-700 p-4 rounded-lg m-2 space-y-2">

              <p class="flex items-center gap-2">
                <a href="/financial/to-pay" class="hover:text-blue-400 flex items-center gap-2">
                  Pagar
                  <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M2.25 6 9 12.75l4.286-4.286a11.948 11.948 0 0 1 4.306 6.43l.776 2.898m0 0 3.182-5.511m-3.182 5.51-5.511-3.181" />
                  </svg>
                </a>
              </p>
              
              <p class="flex items-center gap-2">
                <a href="/financial/receive" class="hover:text-blue-400 flex items-center gap-2">
                  Receber
                  <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M2.25 18 9 11.25l4.306 4.306a11.95 11.95 0 0 1 5.814-5.518l2.74-1.22m0 0-5.94-2.281m5.94 2.28-2.28 5.941" />
                  </svg>
                </a>
              </p>

              <p class="flex items-center gap-2">
                <a href="/financial/cash-register" class="hover:text-blue-400 flex items-center gap-2">
                  Caixa
                  <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M12 6v12m-3-2.818.879.659c1.171.879 3.07.879 4.242 0 1.172-.879 1.172-2.303 0-3.182C13.536 12.219 12.768 12 12 12c-.725 0-1.45-.22-2.003-.659-1.106-.879-1.106-2.303 0-3.182s2.9-.879 4.006 0l.415.33M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z" />
                  </svg>
                </a>
              </p>
            </div>

          </li>
          <li class="w-max">
            <a class="ml-5 hover:text-blue-300 flex items-center">
              <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 10.5V6a3.75 3.75 0 1 0-7.5 0v4.5m11.356-1.993 1.263 12c.07.665-.45 1.243-1.119 1.243H4.25a1.125 1.125 0 0 1-1.12-1.243l1.264-12A1.125 1.125 0 0 1 5.513 7.5h12.974c.576 0 1.059.435 1.119 1.007ZM8.625 10.5a.375.375 0 1 1-.75 0 .375.375 0 0 1 .75 0Zm7.5 0a.375.375 0 1 1-.75 0 .375.375 0 0 1 .75 0Z" />
                </svg>
              <button @click="showPDVFn">
                <span @click="downRow = !downRow" class="inline-flex ml-2">Vendas
                  <svg 
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 16 16"
                    fill="currentColor" 
                    class="mt-auto mb-auto size-4"
                    
                    v-if="!downRow"
                  >
                    <path fill-rule="evenodd" d="M8 2a.75.75 0 0 1 .75.75v8.69l3.22-3.22a.75.75 0 1 1 1.06 1.06l-4.5 4.5a.75.75 0 0 1-1.06 0l-4.5-4.5a.75.75 0 0 1 1.06-1.06l3.22 3.22V2.75A.75.75 0 0 1 8 2Z" clip-rule="evenodd" />
                  </svg> <!-- Flecha pra baixo -->

                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 16 16"
                    fill="currentColor"
                    class="mt-auto mb-auto size-4"
                    v-if="downRow"
                  >
                    <path fill-rule="evenodd" d="M8 14a.75.75 0 0 0 .75-.75V4.56l1.22 1.22a.75.75 0 1 0 1.06-1.06l-2.5-2.5a.75.75 0 0 0-1.06 0l-2.5 2.5a.75.75 0 0 0 1.06 1.06l1.22-1.22v8.69c0 .414.336.75.75.75Z" clip-rule="evenodd" />
                  </svg> <!-- Flecha pra cima -->

                </span>
              </button>
            </a>
            
            <div v-if="showPDV" class="ml-12 bg-gray-700 p-4 rounded-lg m-2 space-y-2">

              <p class="flex items-center gap-2">
                <a href="/sale/pdv" class="hover:text-blue-400 flex items-center gap-2">
                  PDV
                  <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M9 17.25v1.007a3 3 0 0 1-.879 2.122L7.5 21h9l-.621-.621A3 3 0 0 1 15 18.257V17.25m6-12V15a2.25 2.25 0 0 1-2.25 2.25H5.25A2.25 2.25 0 0 1 3 15V5.25m18 0A2.25 2.25 0 0 0 18.75 3H5.25A2.25 2.25 0 0 0 3 5.25m18 0V12a2.25 2.25 0 0 1-2.25 2.25H5.25A2.25 2.25 0 0 1 3 12V5.25" />
                  </svg>
                </a>
              </p>
              <p class="flex items-center gap-2">
                <a href="/sale/list-pdv" class="hover:text-blue-400 flex items-center gap-2">
                  Listagem PDV
                </a>
              </p>
              <p class="flex items-center gap-2">
                <a href="/#" class="hover:text-blue-400 flex items-center gap-2">
                  DAV
                </a>
              </p>
              <p class="flex items-center gap-2">
                <a href="/#" class="hover:text-blue-400 flex items-center gap-2">
                  Devolução
                </a>
              </p>
            </div>

          </li>
          <li disabled title="EM BREVE">
            <router-link to="/hotel" class="ml-5 hover:text-blue-300 flex items-center">
              <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                <path stroke-linecap="round" stroke-linejoin="round" d="M2.25 21h19.5m-18-18v18m10.5-18v18m6-13.5V21M6.75 6.75h.75m-.75 3h.75m-.75 3h.75m3-6h.75m-.75 3h.75m-.75 3h.75M6.75 21v-3.375c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125V21M3 3h12m-.75 4.5H21m-3.75 3.75h.008v.008h-.008v-.008Zm0 3h.008v.008h-.008v-.008Zm0 3h.008v.008h-.008v-.008Z" />
              </svg>
              <span class="ml-2">Hotel</span>
            </router-link>
          </li>
          <li disabled title="EM BREVE">
            <router-link to="/settings" class="ml-5 hover:text-blue-300 flex items-center">
              <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                <path stroke-linecap="round" stroke-linejoin="round" d="M10.343 3.94c.09-.542.56-.94 1.11-.94h1.093c.55 0 1.02.398 1.11.94l.149.894c.07.424.384.764.78.93.398.164.855.142 1.205-.108l.737-.527a1.125 1.125 0 0 1 1.45.12l.773.774c.39.389.44 1.002.12 1.45l-.527.737c-.25.35-.272.806-.107 1.204.165.397.505.71.93.78l.893.15c.543.09.94.559.94 1.109v1.094c0 .55-.397 1.02-.94 1.11l-.894.149c-.424.07-.764.383-.929.78-.165.398-.143.854.107 1.204l.527.738c.32.447.269 1.06-.12 1.45l-.774.773a1.125 1.125 0 0 1-1.449.12l-.738-.527c-.35-.25-.806-.272-1.203-.107-.398.165-.71.505-.781.929l-.149.894c-.09.542-.56.94-1.11.94h-1.094c-.55 0-1.019-.398-1.11-.94l-.148-.894c-.071-.424-.384-.764-.781-.93-.398-.164-.854-.142-1.204.108l-.738.527c-.447.32-1.06.269-1.45-.12l-.773-.774a1.125 1.125 0 0 1-.12-1.45l.527-.737c.25-.35.272-.806.108-1.204-.165-.397-.506-.71-.93-.78l-.894-.15c-.542-.09-.94-.56-.94-1.109v-1.094c0-.55.398-1.02.94-1.11l.894-.149c.424-.07.765-.383.93-.78.165-.398.143-.854-.108-1.204l-.526-.738a1.125 1.125 0 0 1 .12-1.45l.773-.773a1.125 1.125 0 0 1 1.45-.12l.737.527c.35.25.807.272 1.204.107.397-.165.71-.505.78-.929l.15-.894Z" />
                <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
              </svg>
              <span class="ml-2">Configurações</span>
            </router-link>
          </li>
          <li class="w-max" disabled title="EM BREVE">
            <a class="ml-5 hover:text-blue-300 flex items-center">
              <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                <path stroke-linecap="round" stroke-linejoin="round" d="M17.982 18.725A7.488 7.488 0 0 0 12 15.75a7.488 7.488 0 0 0-5.982 2.975m11.963 0a9 9 0 1 0-11.963 0m11.963 0A8.966 8.966 0 0 1 12 21a8.966 8.966 0 0 1-5.982-2.275M15 9.75a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
              </svg>
              <button @click="showProfileFn()">
                <span @click="downRow3 = !downRow3" class="inline-flex ml-2">Perfil
                    <svg 
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 16 16"
                    fill="currentColor" 
                    class="mt-auto mb-auto size-4"
                    
                    v-if="!downRow3"
                  >
                    <path fill-rule="evenodd" d="M8 2a.75.75 0 0 1 .75.75v8.69l3.22-3.22a.75.75 0 1 1 1.06 1.06l-4.5 4.5a.75.75 0 0 1-1.06 0l-4.5-4.5a.75.75 0 0 1 1.06-1.06l3.22 3.22V2.75A.75.75 0 0 1 8 2Z" clip-rule="evenodd" />
                  </svg> <!-- Flecha pra baixo -->

                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 16 16"
                    fill="currentColor"
                    class="mt-auto mb-auto size-4"
                    v-if="downRow3"
                  >
                    <path fill-rule="evenodd" d="M8 14a.75.75 0 0 0 .75-.75V4.56l1.22 1.22a.75.75 0 1 0 1.06-1.06l-2.5-2.5a.75.75 0 0 0-1.06 0l-2.5 2.5a.75.75 0 0 0 1.06 1.06l1.22-1.22v8.69c0 .414.336.75.75.75Z" clip-rule="evenodd" />
                  </svg> <!-- Flecha pra cima -->
                </span>
                
              </button>
            </a>
            
            <div v-if="showProfile" class="ml-12 bg-gray-700 p-2 rounded-lg">
              <p class="flex items-center gap-2">
                <a href="/profile" class="hover:text-blue-400">
                  Editar perfil
                </a>
              </p>
              <p class="flex items-center gap-2">
                <a href="/#" class="hover:text-blue-400">
                  Configurações
                </a>
              </p>
            </div>

          </li>
          <li class="fixed bottom-auto" disabled title="EM BREVE">
            <button >
              <router-link to="/updates" class="ml-5 hover:text-blue-300 flex items-center mb-10">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M12 7.5h1.5m-1.5 3h1.5m-7.5 3h7.5m-7.5 3h7.5m3-9h3.375c.621 0 1.125.504 1.125 1.125V18a2.25 2.25 0 0 1-2.25 2.25M16.5 7.5V18a2.25 2.25 0 0 0 2.25 2.25M16.5 7.5V4.875c0-.621-.504-1.125-1.125-1.125H4.125C3.504 3.75 3 4.254 3 4.875V18a2.25 2.25 0 0 0 2.25 2.25h13.5M6 7.5h3v3H6v-3Z" />
                </svg>
                <span class="ml-2 mb-auto">Atualizações</span>
              </router-link>
            </button>
          </li>
          <li class="fixed bottom-0" :class="{
            'bottom-10': widthScreen <= 1080
          }">
              <q-btn class="ml-5 hover:text-blue-300 flex items-center mb-10" @click="logout()">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 9V5.25A2.25 2.25 0 0 0 13.5 3h-6a2.25 2.25 0 0 0-2.25 2.25v13.5A2.25 2.25 0 0 0 7.5 21h6a2.25 2.25 0 0 0 2.25-2.25V15M12 9l-3 3m0 0 3 3m-3-3h12.75" />
                </svg>

                <span class="ml-2 mb-auto">Sair</span>
              </q-btn>
            </li>
            
          </ul>
        </div>
    </div>

    <div class="flex transition" id="q-app" :class="{
        'top-10 left-0': widthScreen <= 1080,
        'ml-52': widthScreen > 1080,
        'mr-44': widthScreen > 1080 && widthScreen < 1600,
        'transform -translate-x-24': !sidebarActive && widthScreen > 1080,
        
    }">   
        <router-view/>
    </div>

    <!-- Botão da Sidebar fechada -->
    <button  
      @click="toggleSidebar"
      class="transition opacity-0 toggle-btn absolute top-2 left-4 p-3 bg-gray-800 text-white border-none cursor-pointer z-50 rounded-lg"
      :class="{
        'opacity-100 delay-300': !sidebarActive,
        'transform transition translate-x-36': sidebarActive,
      }"
    >
      <span>
        <div class="border border-white w-6 mb-1"></div>
        <div class="border border-white w-6 mt-1"></div>
        <div class="border border-white w-6 mt-1"></div>
      </span>
    </button>
  </div>
  
</template>

<script>
  import { LocalStorage } from 'quasar';

  export default {
    data() {
      return {
        sidebarActive: true,
        showFinancial: false,
        showPDV: false,
        showProfile: false,
        downRow: false,
        downRow2: false,
        downRow3: false,
        widthScreen: 0,
        issuer_name: ''
      };
    },
    
    methods: {
      async logout()
      {
        const ofCourse = confirm('Deseja realmente sair?')
        if(ofCourse)
        {
            LocalStorage.remove("auth_token")
            const token = LocalStorage.getItem("auth_token")
            console.log('Token side bar line 325: ', token)
            this.$router.push('/login')
            /*if(response.data.success)
            {
                LocalStorage.remove("auth_token")                
                this.$router.push('/login')
              
            }*/
        }        
      },
      
      toggleSidebar() {
        this.sidebarActive = !this.sidebarActive;
        this.$emit('toggleSidebar', this.sidebarActive)
      },

      showFinancialFn()
      {
        this.showFinancial = !this.showFinancial
        this.showPDV = false
        this.downRow = false
      },

      showProfileFn()
      {
          this.showProfile = !this.showProfile
          this.showPDV = false
          this.showFinancial = false
          
      },

      showPDVFn()
      {
          this.showPDV = !this.showPDV
          this.showFinancial = false
          this.downRow2 = false
          this.downRow3 = false
      },

    },

    mounted()
    { 
      this.issuer_name = history.state?.name
      this.widthScreen += screen.width
      
      if(this.widthScreen <= 1080)
      {   
          this.sidebarActive = false   
      }
  }

};
</script>

<style>
  * {
    outline: none;
  }

</style>