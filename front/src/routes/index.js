import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '@/views/HomeView.vue';
import LoginView from '@/views/Auth/LoginView.vue'
import RegisterView from '@/views/Auth/RegisterView.vue'
import SettingsView from '@/views/Dashboard/SettingsView.vue'
import ConsumersView from '../views/Dashboard/ConsumersView.vue'
import NFCeView from '../views/Dashboard/NFCeView.vue'
import AboutView from '@/views/AboutView.vue'

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
  {
    path: '/about',
    name: 'about',
    component: AboutView,
  },
]

const router = createRouter({
  history: createWebHistory(),
  routes
})


export default router;