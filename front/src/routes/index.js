import { createRouter, createWebHistory } from 'vue-router'

import LoginView from '@/views/Auth/LoginView.vue';
import RegisterView from '@/views/Auth/RegisterView.vue';
import AboutView from '@/views/Dashboard/Ecommerce/AboutView.vue';
import SettingsView from '@/views/Dashboard/Ecommerce/SettingsView.vue';
import PDVView from '@/views/Dashboard/Ecommerce/PDVView.vue';
import ConsumersView from '@/views/Dashboard/Ecommerce/ConsumersView.vue';
import HomeView from '@/views/Dashboard/HomeView.vue';
import PaymentsForm from '@/views/components/PaymentsForm.vue';
import HotelDetails from '@/views/Dashboard/Hotel/HotelDetails.vue';
import CreateHotel from '@/views/Dashboard/Hotel/CreateHotel.vue';
import RoomDetails from '@/views/Dashboard/Hotel/RoomDetails.vue';
import CustomerHome from '@/views/Dashboard/UserArea/CustomerHome.vue';
import CashRegisterView from '@/views/Dashboard/Ecommerce/CashRegisterView.vue';
import UsersView from '@/views/Dashboard/Ecommerce/UsersView.vue';
import ProductsView from '@/views/Dashboard/Ecommerce/ProductsView.vue';


const routes = [
  {
    path: '/',
    name: 'home',
    component: HomeView,
  },
  {
    path: '/updates',
    name: 'updates',
    //component:
  },
  {
    path: '/sobre',
    name: 'sobre',
    component: AboutView,
  },
  {
    path: "/login",
    name: "login",
    component: LoginView,
  },
  {
    path: "/register",
    name: "register",
    component: RegisterView,
  },
  {
    path: "/settings",
    name: "settings",
    component: SettingsView,
  },
  {
    path: '/cash-register',
    name: 'cash-register',
    component: CashRegisterView,
  },
  {
    path: '/products',
    name: 'products',
    component: ProductsView,
  },
  {
    path: '/consumers',
    name: 'consumers',
    component: ConsumersView,
  },
  {
    path: '/pdv',
    name: 'pdv',
    component: PDVView,
  },
  {
    path: '/payments',
    name: 'payments',
    component: PaymentsForm,
  },
  {
    path: '/user-area',
    name: 'UserArea',
    component: CustomerHome
  },
  {
    path: '/users-view',
    name: 'users-view',
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