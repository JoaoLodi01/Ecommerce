import Sidebar from 'src/layouts/Sidebar.vue';

const financialPrefix = 'financial';
const salePrefix = 'sale';

const routes = [
  {
    path: '/',
    name: 'Home',
    component: () => import('src/pages/Home/HomePage.vue')
  },
  {
    path: '/login',
    name: 'Login',
    component: () => import('pages/Login/Login.vue')
  },
  {
    path: '/register-owner',
    name: 'RegisterOwner',
    component: () => import('src/pages/Login/Register/RegisterOwner.vue')
  },
  {
    path: '/register-issuer',
    name: 'RegisterIssuer',
    component: () => import('src/pages/Login/Register/RegisterIssuer.vue')
  },
  {
    path: '/forgot-password',
    name: 'ForgotPassowrd',
    component: () => import('pages/Login/Forgot/ForgotPassword.vue')
  },
  {
    path: '/reset-password/:token',
    name: 'FormResetPassword',
    component: () => import('src/pages/Login/Forgot/FormResetPassword.vue')
  },
  {
    path: '/companies',
    name: 'Companies',
    component: () => import('src/pages/Owner/Companies.vue')
  },
  {
    path: '/:name/first/companie-data',
    name: 'FirstIssuerData',
    component: () => import('src/pages/Issuer/IssuerData.vue')
  },
  {
    path: '/',
    component: Sidebar,
    children: [
      {
        path: '/:name/home',
        name: 'Start',
        component: () => import('src/pages/Start.vue')
      },
      {
        path: `/:name/${salePrefix}/pdv`,
        name: 'PDV',
        component: () => import('src/pages/Ecommerce/PDV/PDVView.vue')
      },
      {
        path: `/:name/${salePrefix}/save/pdv/:idPDV`,
        name: 'PDVID',
        component: () => import('src/pages/Ecommerce/PDV/PDVView.vue'),
        props: true

      },
      {
        path: `/:name/${salePrefix}/list-pdv`,
        name: 'ListPDV',
        component: () => import('src/pages/Ecommerce/PDV/ListPDVView.vue')

      },
      {
        path: `/:name/${financialPrefix}/cash-register`,
        name: 'CashRegister',
        component: () => import('src/pages/Ecommerce/Financial/CashRegisterView.vue')
      },
      {
        path: `/:name/${financialPrefix}/receive`,
        name: 'ToReceiveView',
        component: () => import('src/pages/Ecommerce/Financial/ToReceiveView.vue')
      },
      {
        path: `/:name/${financialPrefix}/to-pay`,
        name: 'ToPayView',
        component: () => import('src/pages/Ecommerce/Financial/ToPayView.vue')
      },
      {
        path: `/:name/customers`,
        name: 'CustomersView',
        component: () => import('src/pages/Customers/CustomersView.vue')
      },
      {
        path: `/:name/products`,
        name: 'ProductsView',
        component: () => import('src/pages/Products/ProductsView.vue')
      },
      {
        path: '/:name/companie-data',
        name: 'IssuerData',
        component: () => import('src/pages/Issuer/IssuerData.vue')
      },
      {
        path: '/:name/species',
        name: 'SpeciesForm',
        component: () => import('src/pages/Registers/SpeciesForm.vue')
      },
      {
        path: '/:name/list-users',
        name: 'ListUsers',
        component: () => import('src/pages/Users/ListUsers.vue')
      },
      {
        path: '/:name/level-users',
        name: 'LevelUsers',
        component: () => import('src/pages/Users/LevelUsers.vue')
      },
      {
        path: '/:name/:catchAll(.*)*',
        name: '404',
        component: () => import('pages/ErrorNotFound.vue')
      },
      
    ]
  },
]

export default routes
