import { createRouter, createWebHistory } from 'vue-router'

import LoginView from '@/views/Auth/LoginView.vue';
import RegisterView from '@/views/Auth/RegisterView.vue';
import AboutView from '@/views/Dashboard/Ecommerce/AboutView.vue';
import SettingsView from '@/views/Dashboard/Ecommerce/SettingsView.vue';
import PDVView from '@/views/Dashboard/Ecommerce/PDV/PDVView.vue';
import ConsumersView from '@/views/Dashboard/Ecommerce/ConsumersView.vue';
import HomeView from '@/views/Dashboard/HomeView.vue';
import HotelDetails from '@/views/Dashboard/Hotel/HotelDetails.vue';
import CreateHotel from '@/views/Dashboard/Hotel/CreateHotel.vue';
import RoomDetails from '@/views/Dashboard/Hotel/RoomDetails.vue';
import CustomerHome from '@/views/Dashboard/UserArea/CustomerHome.vue';
import CashRegisterView from '@/views/Dashboard/Ecommerce/Financial/CashRegisterView.vue';
import UsersView from '@/views/Dashboard/Ecommerce/UsersView.vue';
import ProductsView from '@/views/Dashboard/Ecommerce/ProductsView.vue';
import ListPDVView from '@/views/Dashboard/Ecommerce/PDV/ListPDVView.vue';
import ToReceiveView from '@/views/Dashboard/Ecommerce/Financial/ToReceiveView.vue';
import ToPayView from '@/views/Dashboard/Ecommerce/Financial/ToPayView.vue';

const routes = [
  {
    path: '/',
    name: 'Home',
    component: HomeView,
  },
  {
    path: '/updates',
    name: 'Updates',
    //component:
  },
  {
    path: '/about',
    name: 'about',
    component: AboutView,
  },
  {
    path: "/login",
    name: "Login",
    component: LoginView,
  },
  {
    path: "/register",
    name: "Register",
    component: RegisterView,
  },
  {
    path: "/settings",
    name: "Settings",
    component: SettingsView,
  },
  {
    path: '/financial/cash-register',
    name: 'CashRegister',
    component: CashRegisterView,
  },
  {
    path: '/financial/receive',
    name: 'ToReceiveView',
    component: ToReceiveView,
  },
  {
    path: '/financial/to-pay',
    name: 'ToPayView',
    component: ToPayView,
  },
  {
    path: '/products',
    name: 'Products',
    component: ProductsView,
  },
  {
    path: '/consumers',
    name: 'Consumers',
    component: ConsumersView,
  },
  {
    path: '/sale/save/pdv/:idPDV',
    name: 'PDVID',
    component: PDVView,
    props: true

  },
  {
    path: '/sale/pdv',
    name: 'PDV',
    component: PDVView,
    props: true
    
  },
  {
    path: '/sale/list-pdv',
    name: 'ListPDV',
    component: ListPDVView

  },
  
  {
    path: '/user-area',
    name: 'UserArea',
    component: CustomerHome
  },
  {
    path: '/users-view',
    name: 'UsersView',
    component: UsersView
  },

  // Hotel routes
  {
    path: '/hotel',
    name: 'HotelDetails',
    component: HotelDetails

  },
  {
    path: '/hotel/rooms',
    name: 'RoomDetails',
    component: RoomDetails

  },
  {
    path: '/hotel/create',
    name: 'CreateHotel',
    component: CreateHotel

  },

]

const router = createRouter({
  history: createWebHistory(),
  routes
  
})

export default router;