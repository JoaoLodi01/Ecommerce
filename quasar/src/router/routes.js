const routes = [
  {
    path: '/',
    name: "SideBar",
    component: () => import('src/pages/SideBarPage.vue')
  },  
  {
    path: '/home',
    name: "Home",
    component: () => import('src/pages/HomePage.vue')
  },

  {
    path: '/profile',
    name: 'Profile',
    component: () => import('src/pages/Profile/Profile.vue')
  },











  {
    path: '/login',
    name: 'LoginView',
    component: () => import('pages/Login/Login.vue')
  }, 
  {
    path: '/sale/pdv',
    name: 'PDV',
    component: () => import('src/pages/Ecommerce/PDV/PDVView.vue') 
  },
  {
    path: '/sale/save/pdv/:idPDV',
    name: 'PDVID',
    component: () => import('src/pages/Ecommerce/PDV/PDVView.vue'),
    props: true

  },
  {
    path: '/sale/list-pdv',
    name: 'ListPDV',
    component: () => import('src/pages/Ecommerce/PDV/ListPDVView.vue')

  },
  {
    path: '/financial/cash-register',
    name: 'CashRegister',
    component: () => import('src/pages/Ecommerce/Financial/CashRegisterView.vue')
  },
  {
    path: '/financial/receive',
    name: 'ToReceiveView',
    component: () => import('src/pages/Ecommerce/Financial/ToReceiveView.vue')
  },
  {
    path: '/financial/to-pay',
    name: 'ToPayView',
    component: () => import('src/pages/Ecommerce/Financial/ToPayView.vue')
  },


  {
    path: '/:catchAll(.*)*',
    component: () => import('pages/ErrorNotFound.vue')
  },
 
]

export default routes
