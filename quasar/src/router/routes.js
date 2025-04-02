const financialPrefix = 'financial';
const salePrefix = 'sale';

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
    path: '/start',
    name: 'LoginView',
    component: () => import('pages/Login/Login.vue')
  },
  {
    path: `/${salePrefix}/pdv`,
    name: 'PDV',
    component: () => import('src/pages/Ecommerce/PDV/PDVView.vue') 
  },
  {
    path: `/${salePrefix}/save/pdv/:idPDV`,
    name: 'PDVID',
    component: () => import('src/pages/Ecommerce/PDV/PDVView.vue'),
    props: true

  },
  {
    path: `/${salePrefix}/list-pdv`,
    name: 'ListPDV',
    component: () => import('src/pages/Ecommerce/PDV/ListPDVView.vue')

  },
  {
    path: `/${financialPrefix}/cash-register`,
    name: 'CashRegister',
    component: () => import('src/pages/Ecommerce/Financial/CashRegisterView.vue')
  },
  {
    path: `/${financialPrefix}/receive`,
    name: 'ToReceiveView',
    component: () => import('src/pages/Ecommerce/Financial/ToReceiveView.vue')
  },
  {
    path: `/${financialPrefix}/to-pay`,
    name: 'ToPayView',
    component: () => import('src/pages/Ecommerce/Financial/ToPayView.vue')
  },
  {
    path: `/customers`,
    name: 'CustomersView',
    component: () => import('src/pages/Others/CustomersView.vue')
  },
  {
    path: `/products`,
    name: 'ProductsView',
    component: () => import('src/pages/Products/ProductsView.vue')
  },
  {
    path: '/profile',
    name: 'ProfileView',
    component: () => import('src/pages/Profile/Profile.vue')
  },
  {
    path: '/:catchAll(.*)*',
    name: '404',
    component: () => import('pages/ErrorNotFound.vue')
  },
 
]

export default routes
