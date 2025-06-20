<template>
  <div class="relative h-screen">
    <!-- Sidebar com transição -->
    <div
        :class="{
            'transform translate-x-0 w-64': sidebarActive, 
            'transform -translate-x-10 w-36': !sidebarActive,
            'transform -translate-x-full w-38 ml-0': !sidebarActive && widthScreen < 1600,

        }"
        
        class="transition-transform duration-300 bg-[#2C363F] text-white text-base h-screen fixed top-0 left-0 z-40"
        title="Sidebar"
      >
      
      <!-- Botão Sidebar-->
      <button 
        @click="toggleSidebar()"
        class="absolute top-6 right-4 bg-gray-800 hover:text-blue-300 border-none rounded-lg cursor-pointer z-50 mt-6"
        v-if="sidebarActive"
      >
        <div class="border border-white w-6 mb-1"></div>
        <div class="border border-white w-6 mt-1"></div>
        <div class="border border-white w-6 mt-1"></div>

      </button>
      <button 
        @click="toggleSidebar()"
        :class="{
          'closeSideBar': widthScreen > 1080,
          'relative top-2 left-40 bg-gray-800 p-3 rounded-md': widthScreen <= 1600
        }" 
        v-if="!sidebarActive" 
      >
        <div
        
        >
            <div class="border border-white w-6 mb-1"></div>
            <div class="border border-white w-6 mt-1"></div>
            <div class="border border-white w-6 mt-1"></div>
        </div>
      </button>

      <!-- Links Sidebar-->
      <div class="sidebar-header p-4 flex mt-6">
        <img 
          src="https://www.php.net/images/logos/php-icon-black.gif" 
          width="" 
          alt="Logo"
          :class="{
            'ml-14 mt-5': !sidebarActive
          }"
        />
        <h1 
          class="text-xl font-semibold ml-5 mt-0.5"
          v-if="sidebarActive"
        >
          {{ issuer_name.substring(0, 12) }}
        </h1>
        
      </div>
      <div class="sidebar-links p-5 ml-1.5">
        <ul class="space-y-4">
          <li>
            <router-link :to="`/${issuer_first_name}/home`" class="hover:text-blue-300 flex items-center gap-4">
              <svg 
                xmlns="http://www.w3.org/2000/svg" 
                fill="none" 
                viewBox="0 0 24 24" 
                stroke-width="1.5" 
                stroke="currentColor" 
                class="size-6"
                :class="{
                  'ml-12': !sidebarActive
                }"
              >
                
                <path stroke-linecap="round" stroke-linejoin="round" d="m2.25 12 8.954-8.955c.44-.439 1.152-.439 1.591 0L21.75 12M4.5 9.75v10.125c0 .621.504 1.125 1.125 1.125H9.75v-4.875c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125V21h4.125c.621 0 1.125-.504 1.125-1.125V9.75M8.25 21h8.25" />
              </svg>
              <span v-if="sidebarActive" class="ml-2">Home</span>
            </router-link>
          </li>
          <li>
            <router-link :to="`/${issuer_first_name}/customers`" class="hover:text-blue-300 flex items-center gap-4">
              <svg 
                :class="{
                   'ml-12 mr-auto': !sidebarActive
                }"
                xmlns="http://www.w3.org/2000/svg" 
                fill="none" 
                viewBox="0 0 24 24" 
                stroke-width="1.5" 
                stroke="currentColor" 
                class="size-6"
            >
                <path stroke-linecap="round" stroke-linejoin="round" d="M15 19.128a9.38 9.38 0 0 0 2.625.372 9.337 9.337 0 0 0 4.121-.952 4.125 4.125 0 0 0-7.533-2.493M15 19.128v-.003c0-1.113-.285-2.16-.786-3.07M15 19.128v.106A12.318 12.318 0 0 1 8.624 21c-2.331 0-4.512-.645-6.374-1.766l-.001-.109a6.375 6.375 0 0 1 11.964-3.07M12 6.375a3.375 3.375 0 1 1-6.75 0 3.375 3.375 0 0 1 6.75 0Zm8.25 2.25a2.625 2.625 0 1 1-5.25 0 2.625 2.625 0 0 1 5.25 0Z" />
              </svg> <!-- Icone -->
              <span v-if="sidebarActive" class="ml-2">Clientes</span> <!-- Escrita -->
            </router-link> 
          </li>
          <li>
            <router-link :to="`/${issuer_first_name}/products`" class="hover:text-blue-300 flex items-center gap-4">
              <svg
                :class="{
                  'ml-12 mr-auto': !sidebarActive
                }" 
                xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                <path stroke-linecap="round" stroke-linejoin="round" d="m20.25 7.5-.625 10.632a2.25 2.25 0 0 1-2.247 2.118H6.622a2.25 2.25 0 0 1-2.247-2.118L3.75 7.5M10 11.25h4M3.375 7.5h17.25c.621 0 1.125-.504 1.125-1.125v-1.5c0-.621-.504-1.125-1.125-1.125H3.375c-.621 0-1.125.504-1.125 1.125v1.5c0 .621.504 1.125 1.125 1.125Z" />
              </svg> <!-- Icone -->
              <span v-if="sidebarActive" class="ml-2">Produtos</span> <!-- Texto-->
            </router-link>
          </li>

          <li class="w-max">
            <a class="hover:text-blue-300 flex items-center cursor-pointer gap-6" @click="toggleFinancial()">
                <svg
                    :class="{
                        'ml-12 ': !sidebarActive,
                        '-mr-4': downRowFinancial && !sidebarActive,
                    }"  

                    xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M12 21v-8.25M15.75 21v-8.25M8.25 21v-8.25M3 9l9-6 9 6m-1.5 12V10.332A48.36 48.36 0 0 0 12 9.75c-2.551 0-5.056.2-7.5.582V21M3 21h18M12 6.75h.008v.008H12V6.75Z" />
                </svg> <!-- Icone -->
                <span class="flex items-center">
                  <span v-if="sidebarActive"> Financeiro </span> <!-- Icone -->
                  
                  <svg 
                    xmlns="http://www.w3.org/2000/svg" 
                    fill="none" 
                    viewBox="0 0 24 24" 
                    stroke-width="1.5" 
                    stroke="currentColor"
                    :class="{
                        'ml-1 mt-auto mb-auto size-5': sidebarActive,
                        '-ml-4 size-5': !sidebarActive
                    }"
                    v-if="!downRowFinancial"
                >
                    <path stroke-linecap="round" stroke-linejoin="round" d="m19.5 8.25-7.5 7.5-7.5-7.5" />
                </svg> <!-- Flecha para baixo -->

                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" 
                    class="mt-auto mb-auto size-5"
                    v-if="downRowFinancial">
                    <path stroke-linecap="round" stroke-linejoin="round" d="m4.5 15.75 7.5-7.5 7.5 7.5" />
                </svg> <!-- Flecha para cima -->
            </span> 
            </a>
            <div v-if="showFinancial" class="ml-12 bg-gray-700 p-4 rounded-lg m-2 space-y-2">

              <p class="flex items-center gap-2">
                <router-link :to="`/${issuer_first_name}/financial/to-pay`" class="hover:text-blue-400 flex items-center gap-2">
                  Pagar
                </router-link>
              </p>
              
              <p class="flex items-center gap-2">
                <router-link :to="`/${issuer_first_name}/financial/receive`" class="hover:text-blue-400 flex items-center gap-2">
                  Receber
                </router-link>
              </p>

              <p class="flex items-center gap-2">
                <router-link :to="`/${issuer_first_name}/financial/cash-register`" class="hover:text-blue-400 flex items-center gap-2">
                  Caixa
                </router-link>
              </p>
            </div>
          </li>

          <li class="w-max">
            <a class="hover:text-blue-300 flex items-center gap-4 cursor-pointer" @click="togglePDVMenu()">
                <svg 
                    :class="{
                        'ml-12': !sidebarActive,
                        '-mr-2': downRowSales && !sidebarActive,
                    }" 
                    xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 10.5V6a3.75 3.75 0 1 0-7.5 0v4.5m11.356-1.993 1.263 12c.07.665-.45 1.243-1.119 1.243H4.25a1.125 1.125 0 0 1-1.12-1.243l1.264-12A1.125 1.125 0 0 1 5.513 7.5h12.974c.576 0 1.059.435 1.119 1.007ZM8.625 10.5a.375.375 0 1 1-.75 0 .375.375 0 0 1 .75 0Zm7.5 0a.375.375 0 1 1-.75 0 .375.375 0 0 1 .75 0Z" />
                </svg>
                <span class="flex items-center" >
                    <span v-if="sidebarActive" class="ml-2 mr-2">Vendas</span>

                    <svg 
                        xmlns="http://www.w3.org/2000/svg" 
                        fill="none" 
                        viewBox="0 0 24 24" 
                        stroke-width="1.5" 
                        stroke="currentColor"
                        class="mt-auto mb-auto size-5"
                        :class="{
                            'ml-1 mt-auto mb-auto size-5': sidebarActive,
                            '-ml-2 size-5': !sidebarActive
                        }"
                        v-if="!downRowSales"
                    >
                        <path stroke-linecap="round" stroke-linejoin="round" d="m19.5 8.25-7.5 7.5-7.5-7.5" />
                    </svg> <!-- Flecha para baixo -->
                    
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" 
                    class="mt-auto mb-auto size-5"
                    v-if="downRowSales">
                        <path stroke-linecap="round" stroke-linejoin="round" d="m4.5 15.75 7.5-7.5 7.5 7.5" />
                    </svg> <!-- Flecha para cima -->
                </span>
            </a>
            <div v-if="showPDV" class="ml-12 bg-gray-700 p-4 rounded-lg m-2 space-y-2">

              <p class="flex items-center gap-2">
                <router-link :to="`/${issuer_first_name}/sale/pdv`" class="hover:text-blue-400 flex items-center gap-2">
                  PDV
                </router-link>
              </p>

              <p class="flex items-center gap-2">
                <router-link :to="`/${issuer_first_name}/sale/list-pdv`" class="hover:text-blue-400 flex items-center gap-2">
                  Listagem PDV
                </router-link>
              </p>

              <p class="flex items-center gap-2">
                <router-link :to="`/${issuer_first_name}/sale/pdv`" class="hover:text-blue-400 flex items-center gap-2">
                  DAV
                </router-link>
              </p>

              <p class="flex items-center gap-2">
                <router-link :to="`/${issuer_first_name}/sale/pdv`" class="hover:text-blue-400 flex items-center gap-2">
                  Devolução
                </router-link>
              </p>
              
            </div>
          </li>
          <li class="w-max">
            <a class="hover:text-blue-300 flex items-center gap-4 cursor-pointer" @click="toggleRegisters">
              <svg 
                :class="{
                    'ml-12': !sidebarActive,
                    '-mr-2': showRegisters && !sidebarActive,
                    
                }"  
                xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                <path stroke-linecap="round" stroke-linejoin="round" d="M2.25 12.75V12A2.25 2.25 0 0 1 4.5 9.75h15A2.25 2.25 0 0 1 21.75 12v.75m-8.69-6.44-2.12-2.12a1.5 1.5 0 0 0-1.061-.44H4.5A2.25 2.25 0 0 0 2.25 6v12a2.25 2.25 0 0 0 2.25 2.25h15A2.25 2.25 0 0 0 21.75 18V9a2.25 2.25 0 0 0-2.25-2.25h-5.379a1.5 1.5 0 0 1-1.06-.44Z" />
              </svg>

              <span v-if="sidebarActive" class="ml-2">Cadastros</span>

              <svg 
                :class="{
                    'ml-1 mt-auto mb-auto size-5': sidebarActive,
                    '-ml-2 size-5': !sidebarActive
                }"
                xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"
                class="mt-auto mb-auto size-5"
                v-if="!showRegisters">
                <path stroke-linecap="round" stroke-linejoin="round" d="m19.5 8.25-7.5 7.5-7.5-7.5" />
              </svg> <!-- Flecha para baixo -->
              <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" 
                class="mt-auto mb-auto size-5"
                v-if="showRegisters">
                <path stroke-linecap="round" stroke-linejoin="round" d="m4.5 15.75 7.5-7.5 7.5 7.5" />
              </svg> <!-- Flecha para cima -->
            </a>
            <div v-if="showRegisters" class="ml-8 bg-gray-700 p-4 rounded-lg m-2 space-y-2">
              <p class="flex items-center gap-2">
                <router-link :to="`/${issuer_first_name}/species`" class="hover:text-blue-400 flex items-center gap-2">
                  Espécies
                </router-link>
              </p>

              <p class="flex items-center gap-2">
                <router-link :to="`/${issuer_first_name}/sale/pdv`" class="hover:text-blue-400 flex items-center gap-2">
                  Centro de custo
                </router-link>
              </p>

              <p class="flex items-center gap-2">
                <router-link :to="`/${issuer_first_name}/sale/pdv`" class="hover:text-blue-400 flex items-center gap-2">
                  Plano de contas
                </router-link>
              </p>

              <p class="flex items-center gap-2">
                <router-link :to="`/${issuer_first_name}/sale/pdv`" class="hover:text-blue-400 flex items-center gap-2">
                  Grupos
                </router-link>
              </p>

              <p class="flex items-center gap-2">
                <router-link :to="`/${issuer_first_name}/sale/pdv`" class="hover:text-blue-400 flex items-center gap-2">
                  Unidade de medida
                </router-link>
              </p>

              <p class="flex items-center gap-2">
                <router-link :to="`/${issuer_first_name}/sale/pdv`" class="hover:text-blue-400 flex items-center gap-2">
                  Natureza de operação
                </router-link>
              </p>
            </div>
          </li>
          <li class="w-max">
            <a class="hover:text-blue-300 flex items-center gap-4 cursor-pointer" @click="toggleUsers()">
              <svg 
                :class="{
                    'ml-12': !sidebarActive,
                    '-mr-2': downRowUsers && !sidebarActive,
                }"  
                xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                <path stroke-linecap="round" stroke-linejoin="round" d="M15 19.128a9.38 9.38 0 0 0 2.625.372 9.337 9.337 0 0 0 4.121-.952 4.125 4.125 0 0 0-7.533-2.493M15 19.128v-.003c0-1.113-.285-2.16-.786-3.07M15 19.128v.106A12.318 12.318 0 0 1 8.624 21c-2.331 0-4.512-.645-6.374-1.766l-.001-.109a6.375 6.375 0 0 1 11.964-3.07M12 6.375a3.375 3.375 0 1 1-6.75 0 3.375 3.375 0 0 1 6.75 0Zm8.25 2.25a2.625 2.625 0 1 1-5.25 0 2.625 2.625 0 0 1 5.25 0Z" />
              </svg>
              <span class="ml-2" v-if="sidebarActive" >Usuários</span>
                <svg 
                    :class="{
                        'ml-1 mt-auto mb-auto size-5': sidebarActive,
                        '-ml-2 size-5': !sidebarActive
                    }"
                    xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"
                    class="mt-auto mb-auto size-5"
                    v-if="!downRowUsers">
                    <path stroke-linecap="round" stroke-linejoin="round" d="m19.5 8.25-7.5 7.5-7.5-7.5" />
                  </svg> <!-- Flecha para baixo -->

                  <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" 
                    class="mt-auto mb-auto size-5"
                    v-if="downRowUsers">
                    <path stroke-linecap="round" stroke-linejoin="round" d="m4.5 15.75 7.5-7.5 7.5 7.5" />
                  </svg> <!-- Flecha para cima -->
            </a>
            <div v-if="showUsers" class="ml-12 bg-gray-700 p-4 rounded-lg m-2 space-y-2">
              <p class="flex items-center gap-2">
                <router-link :to="`/${issuer_first_name}/list-users`" class="hover:text-blue-400 flex items-center gap-2">
                  Listagem de usuários
                </router-link>
              </p>

              <p class="flex items-center gap-2">
                <router-link :to="`/${issuer_first_name}/level-users`" class="hover:text-blue-400 flex items-center gap-2">
                  Nível de acesso
                </router-link>
              </p>
            </div>
          </li>
          <li disabled title="EM BREVE">
            <router-link :to="`/${issuer_first_name}/sale/pdv`" class="hover:text-blue-300 flex items-center gap-4">
              <svg 
                :class="{
                    'ml-12 mr-auto': !sidebarActive
                }"  
                xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                <path stroke-linecap="round" stroke-linejoin="round" d="M2.25 21h19.5m-18-18v18m10.5-18v18m6-13.5V21M6.75 6.75h.75m-.75 3h.75m-.75 3h.75m3-6h.75m-.75 3h.75m-.75 3h.75M6.75 21v-3.375c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125V21M3 3h12m-.75 4.5H21m-3.75 3.75h.008v.008h-.008v-.008Zm0 3h.008v.008h-.008v-.008Zm0 3h.008v.008h-.008v-.008Z" />
              </svg>
              <span class="ml-2" v-if="sidebarActive">Hotel</span>
            </router-link>
          </li>
          <li>
            <router-link :to="`/${issuer_first_name}/configs`" class="hover:text-blue-300 flex items-center gap-4">
              <svg 
                :class="{
                    'ml-12 mr-auto': !sidebarActive
                    
                }"                      
                xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                <path stroke-linecap="round" stroke-linejoin="round" d="M10.343 3.94c.09-.542.56-.94 1.11-.94h1.093c.55 0 1.02.398 1.11.94l.149.894c.07.424.384.764.78.93.398.164.855.142 1.205-.108l.737-.527a1.125 1.125 0 0 1 1.45.12l.773.774c.39.389.44 1.002.12 1.45l-.527.737c-.25.35-.272.806-.107 1.204.165.397.505.71.93.78l.893.15c.543.09.94.559.94 1.109v1.094c0 .55-.397 1.02-.94 1.11l-.894.149c-.424.07-.764.383-.929.78-.165.398-.143.854.107 1.204l.527.738c.32.447.269 1.06-.12 1.45l-.774.773a1.125 1.125 0 0 1-1.449.12l-.738-.527c-.35-.25-.806-.272-1.203-.107-.398.165-.71.505-.781.929l-.149.894c-.09.542-.56.94-1.11.94h-1.094c-.55 0-1.019-.398-1.11-.94l-.148-.894c-.071-.424-.384-.764-.781-.93-.398-.164-.854-.142-1.204.108l-.738.527c-.447.32-1.06.269-1.45-.12l-.773-.774a1.125 1.125 0 0 1-.12-1.45l.527-.737c.25-.35.272-.806.108-1.204-.165-.397-.506-.71-.93-.78l-.894-.15c-.542-.09-.94-.56-.94-1.109v-1.094c0-.55.398-1.02.94-1.11l.894-.149c.424-.07.765-.383.93-.78.165-.398.143-.854-.108-1.204l-.526-.738a1.125 1.125 0 0 1 .12-1.45l.773-.773a1.125 1.125 0 0 1 1.45-.12l.737.527c.35.25.807.272 1.204.107.397-.165.71-.505.78-.929l.15-.894Z" />
                <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
              </svg>
              <span class="ml-2" v-if="sidebarActive">Configurações</span>
            </router-link>
          </li>
          <li class="w-max" disabled title="EM BREVE">
            <a class="hover:text-blue-300 flex items-center gap-4">
              <svg 
                :class="{
                  'ml-12': !sidebarActive,
                  '-mr-2': downRow3 && !sidebarActive
                }"
                xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                <path stroke-linecap="round" stroke-linejoin="round" d="M17.982 18.725A7.488 7.488 0 0 0 12 15.75a7.488 7.488 0 0 0-5.982 2.975m11.963 0a9 9 0 1 0-11.963 0m11.963 0A8.966 8.966 0 0 1 12 21a8.966 8.966 0 0 1-5.982-2.275M15 9.75a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
              </svg>
              <span @click="showProfileFn()" class="flex items-center">
                <span v-if="sidebarActive" class="ml-2">Perfil</span>
                    <svg 
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 16 16"
                    fill="currentColor" 
                    class="mt-auto mb-auto size-5"
                    :class="{
                        'mt-auto mb-auto size-5': sidebarActive,
                        '-ml-2 size-5': !sidebarActive
                    }"
                    v-if="!downRow3"
                  >
                    <path fill-rule="evenodd" d="M8 2a.75.75 0 0 1 .75.75v8.69l3.22-3.22a.75.75 0 1 1 1.06 1.06l-4.5 4.5a.75.75 0 0 1-1.06 0l-4.5-4.5a.75.75 0 0 1 1.06-1.06l3.22 3.22V2.75A.75.75 0 0 1 8 2Z" clip-rule="evenodd" />
                  </svg> <!-- Flecha pra baixo -->

                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 16 16"
                    fill="currentColor"
                    class="mt-auto mb-auto size-5"
                    v-if="downRow3"
                  >
                    <path fill-rule="evenodd" d="M8 14a.75.75 0 0 0 .75-.75V4.56l1.22 1.22a.75.75 0 1 0 1.06-1.06l-2.5-2.5a.75.75 0 0 0-1.06 0l-2.5 2.5a.75.75 0 0 0 1.06 1.06l1.22-1.22v8.69c0 .414.336.75.75.75Z" clip-rule="evenodd" />
                  </svg> <!-- Flecha pra cima -->
                
              </span>
            </a>
            
            <div v-if="showProfile" class="ml-12 bg-gray-700 p-2 rounded-lg">
              <p class="flex items-center gap-2">
                <a href="/profile" class="hover:text-blue-400 flex items-center gap-2">
                  Editar perfil
                </a>
              </p>
              <p class="flex items-center gap-2">
                <a href="/#" class="hover:text-blue-400 flex items-center gap-2">
                  Configurações
                </a>
              </p>
            </div>

          </li>
          <li class="fixed bottom-auto" disabled title="EM BREVE">
            <button >
              <router-link :to="`/${issuer_first_name}/sale/pdv`" class="hover:text-blue-300 flex items-center gap-4">
                <svg 
                    :class="{
                        'ml-12 mr-auto': !sidebarActive
                    }"    
                    xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M12 7.5h1.5m-1.5 3h1.5m-7.5 3h7.5m-7.5 3h7.5m3-9h3.375c.621 0 1.125.504 1.125 1.125V18a2.25 2.25 0 0 1-2.25 2.25M16.5 7.5V18a2.25 2.25 0 0 0 2.25 2.25M16.5 7.5V4.875c0-.621-.504-1.125-1.125-1.125H4.125C3.504 3.75 3 4.254 3 4.875V18a2.25 2.25 0 0 0 2.25 2.25h13.5M6 7.5h3v3H6v-3Z" />
                </svg>
                <span class="ml-2 mb-auto" v-if="sidebarActive">Atualizações</span>
              </router-link>
            </button>
          </li>
            <li 
                v-if="sidebarActive"
                class="fixed bottom-0" 
                :class="{
                    'bottom-10': widthScreen <= 1080
                }"
            >
                <q-btn 
                    class="ml-5 w-max hover:text-blue-300 flex items-center mb-10" 
                    @click="backCompanies()"
                >
                    <span class="ml-2 mb-auto">Trocar de empresa</span>
                </q-btn>

                <q-btn 
                    class="ml-5 w-max hover:text-blue-300 flex items-center mb-10" 
                    @click="logout()"
                >
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 9V5.25A2.25 2.25 0 0 0 13.5 3h-6a2.25 2.25 0 0 0-2.25 2.25v13.5A2.25 2.25 0 0 0 7.5 21h6a2.25 2.25 0 0 0 2.25-2.25V15M12 9l-3 3m0 0 3 3m-3-3h12.75" />
                    </svg>

                    <span class="ml-2 mb-auto">Sair</span>
                </q-btn>
            </li>
            <li 
                class="fixed bottom-5 right-12" 
                :class="{
                    'bottom-10': widthScreen <= 1080
                }"
                v-if="!sidebarActive"
            >
                <svg 
                    title="Trocar de empresa" 
                    xmlns="http://www.w3.org/2000/svg" 
                    fill="none" 
                    viewBox="0 0 24 24" 
                    stroke-width="1.5" 
                    stroke="currentColor" 
                    class="size-6 cursor-pointer mb-8"
                    @click="backCompanies()"
                >
                    <path stroke-linecap="round" stroke-linejoin="round" d="M13.5 21v-7.5a.75.75 0 0 1 .75-.75h3a.75.75 0 0 1 .75.75V21m-4.5 0H2.36m11.14 0H18m0 0h3.64m-1.39 0V9.349M3.75 21V9.349m0 0a3.001 3.001 0 0 0 3.75-.615A2.993 2.993 0 0 0 9.75 9.75c.896 0 1.7-.393 2.25-1.016a2.993 2.993 0 0 0 2.25 1.016c.896 0 1.7-.393 2.25-1.015a3.001 3.001 0 0 0 3.75.614m-16.5 0a3.004 3.004 0 0 1-.621-4.72l1.189-1.19A1.5 1.5 0 0 1 5.378 3h13.243a1.5 1.5 0 0 1 1.06.44l1.19 1.189a3 3 0 0 1-.621 4.72M6.75 18h3.75a.75.75 0 0 0 .75-.75V13.5a.75.75 0 0 0-.75-.75H6.75a.75.75 0 0 0-.75.75v3.75c0 .414.336.75.75.75Z" />
                </svg>

                <svg 
                    title="Sair" 
                    xmlns="http://www.w3.org/2000/svg" 
                    fill="none" 
                    viewBox="0 0 24 24" 
                    stroke-width="1.5" 
                    stroke="currentColor" 
                    class="size-6 cursor-pointer"
                    @click="logout()"
                >
                    <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 9V5.25A2.25 2.25 0 0 0 13.5 3h-6a2.25 2.25 0 0 0-2.25 2.25v13.5A2.25 2.25 0 0 0 7.5 21h6a2.25 2.25 0 0 0 2.25-2.25V15M12 9l-3 3m0 0 3 3m-3-3h12.75" />
                </svg>
            </li>
          </ul>
        </div>
    </div>

    <div class="flex transition" id="q-app" :class="{
        'top-10 left-0': widthScreen <= 1600,
        'ml-52': widthScreen > 1080,
        'routerView': widthScreen <= 1600,
        'transform -translate-x-24': !sidebarActive && widthScreen > 1080,
        
    }">   
        <router-view/> <!-- Views -->
    </div>

    <!-- Botão da Sidebar fechada -->
    
  </div>
  
</template>

<script>
  import { LocalStorage } from 'quasar';
  import { api } from 'src/boot/axios';

  export default {
    data() {
      return {
        sidebarActive: true,
        showFinancial: false,
        showPDV: false,
        showProfile: false,
        showRegisters: false,
        showUsers: false,
        showSales: false,
        downRowRegisters: false,
        downRowFinancial: false,
        downRowSales: false,
        downRowUsers: false,
        downRow3: false,
        widthScreen: 0,
        issuer_first_name: LocalStorage.getItem("first_name"),
        issuer_name: LocalStorage.getItem("issuer_name")
      };
    },
    
    methods: {
      async logout()
      {
        const ofCourse = confirm('Deseja realmente sair?')
        if(ofCourse)
        {
          const res = await api.post('/auth/logout')
          if(res.data.success)
          {
            LocalStorage.remove("auth_token")  
            this.$router.push(res.data.route)

          }
        }
      },

      backCompanies()
      {
        const ofCourse = confirm('Deseja trocar de empresa?')
        if(ofCourse)
        {
          LocalStorage.remove("issuer_name")
          LocalStorage.remove("issuer_id")
          LocalStorage.remove("first_name")
          this.$router.push({ path: '/companies' })
        }
      },
      
      toggleSidebar() {
            this.sidebarActive = !this.sidebarActive;
            
            this.showFinancial = false;
            this.downRowFinancial = false;

            // Cadastros
            this.showRegisters = false;
            this.downRowRegisters = false;

            // Vendas
            this.showPDV = false;
            this.downRowSales = false;

            // Usuários
            this.showUsers = false;
            this.downRowUsers = false;
      },

      toggleFinancial() {
            !this.sidebarActive ? this.toggleSidebar() : null
            this.showFinancial = !this.showFinancial;
            this.downRowFinancial = this.showFinancial;

            // Cadastros
            this.showRegisters = false;
            this.downRowRegisters = this.showRegisters;

            // Vendas
            this.showPDV = false;
            this.downRowSales = this.showPDV;

            // Usuários
            this.showUsers = false;
            this.downRowUsers = this.showUsers;
      },

      togglePDVMenu() {
            !this.sidebarActive ? this.toggleSidebar() : null
            this.showPDV = !this.showPDV;
            this.downRowSales = this.showPDV;

            //Financeiro 
            this.showFinancial = false;
            this.downRowFinancial = this.showFinancial;

            // Cadastros
            this.showRegisters = false;
            this.downRowRegisters = this.showRegisters;

            // Usuários
            this.showUsers = false;
            this.downRowUsers = this.showUsers;
      },

      toggleRegisters(){
            !this.sidebarActive ? this.toggleSidebar() : null
            this.showRegisters = !this.showRegisters;
            this.downRowRegisters = this.showRegisters;

            //Financeiro 
            this.showFinancial = false;
            this.downRowFinancial = this.showFinancial;

            // Vendas
            this.showPDV = false;
            this.downRowSales = this.showPDV;

            // Usuários
            this.showUsers = false;
            this.downRowUsers = this.showUsers;
      },

      toggleUsers(){
            !this.sidebarActive ? this.toggleSidebar() : null
            this.showUsers = !this.showUsers;
            this.downRowUsers = this.showUsers;

            //Financeiro 
            this.showFinancial = false;
            this.downRowFinancial = this.showFinancial;

            // Vendas
            this.showPDV = false;
            this.downRowSales = this.showPDV;
            
            // Cadastros
            this.showRegisters = false;
            this.downRowRegisters = this.showRegisters;
      },

      showProfileFn()
      {
        !this.sidebarActive ? this.toggleSidebar() : null
        this.showProfile = !this.showProfile
        this.showPDV = false
        this.showFinancial = false
          
      },
    },

    mounted()
    { 
      this.widthScreen = screen.width
      this.widthScreen < 1366 ? this.sidebarActive = false : this.sidebarActive= true
      document.addEventListener('keydown', (event) => {
          const keyName = event.key
          console.log('keyName: ', keyName)
          if(event.altKey && keyName.toLowerCase() === 'g')
          {
            this.toggleSidebar()

          } 
      })
      
    }       

};
</script>

<style>
  * {
    outline: none;
  }

  .closeSideBar {
    position: relative;
    left: 4.7rem;
    top: 2rem;

  }

  @media (max-width: 1080px)
  {
      
    .routerView{
        position: relative;
        left: -.01rem;
        border: solid #000;
        
    }
  }
</style>