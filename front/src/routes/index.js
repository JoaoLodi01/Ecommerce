import { createRouter, createWebHistory } from 'vue-router'

import LoginView from '@/views/Auth/LoginView.vue'
import RegisterView from '@/views/Auth/RegisterView.vue'

import HomeView from '@/views/HomeView.vue';
import SettingsView from '@/views/Dashboard/SettingsView.vue'

import NFCeView from '../views/Dashboard/E-commerce/NFCeView.vue'
import ConsumersView from '../views/Dashboard/E-commerce/ConsumersView.vue'
import HotelDetails from '@/views/Dashboard/Hotel/HotelDetails.vue';
import CreateHotel from '@/views/Dashboard/Hotel/CreateHotel.vue';

const routes = [
  {
    path: '/',
    name: 'home',
    component: HomeView,
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

  // Hotel
  {
    path: '/hotel',
    name: 'hotel',
    component: HotelDetails

  },
  {
    path: '/hotel/create',
    name: 'hotelCreate',
    component: CreateHotel

  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})


export default router;