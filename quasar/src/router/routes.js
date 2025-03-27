const routes = [
  {
    path: '/',
    component: () => import('pages/HomePage.vue')
  },  
  {
    path: '/login',
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
