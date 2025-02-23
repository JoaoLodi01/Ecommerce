import { createRouter, createWebHistory } from 'vue-router'

import LoginView from '@/views/Auth/LoginView.vue';
import RegisterView from '@/views/Auth/RegisterView.vue';
import AboutView from '@/views/Dashboard/Ecommerce/AboutView.vue';
import SettingsView from '@/views/Dashboard/Ecommerce/SettingsView.vue';
import NFCeView from '@/views/Dashboard/Ecommerce/NFCeView.vue';
import ConsumersView from '@/views/Dashboard/Ecommerce/ConsumersView.vue';
import HomeView from '@/views/Dashboard/HomeView.vue';
import PaymentsForm from '@/views/components/PaymentsForm.vue';

import HotelDetails from '@/views/Dashboard/Hotel/HotelDetails.vue';
import CreateHotel from '@/views/Dashboard/Hotel/CreateHotel.vue';
import RoomDetails from '@/views/Dashboard/Hotel/RoomDetails.vue';
import CustomerHome from '@/views/Dashboard/Hotel/UserArea/CustomerHome.vue';
import WhatsAppConection from '@/views/Dashboard/WhatsAppConection.vue';


const routes = [
  {
    path: '/',
    name: 'home',
    component: HomeView,
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
    path: '/consumers',
    name: 'consumers',
    component: ConsumersView,
  },
  {
    path: '/nfce',
    name: 'nfce',
    component: NFCeView,
  },
  {
    path: '/payments',
    name: 'payments',
    component: PaymentsForm,
  },

  // Hotel routes
  {
    path: '/hotel',
    name: 'HotelDetails',
    component: HotelDetails

  },
  {
    path: '/hotel/user-area',
    name: 'UserArea',
    component: CustomerHome
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

  {
    path: '/wa',
    component: WhatsAppConection
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
  
})

export default router;