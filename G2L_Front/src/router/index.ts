import { createRouter, createWebHistory, createMemoryHistory, createWebHashHistory } from 'vue-router'
import routes from './routes'

export default function () {
  const createHistory = process.env.SERVER
    ? createMemoryHistory()
    : (process.env.VUE_ROUTER_MODE === 'history' ? createWebHistory() : createWebHashHistory())

  const router = createRouter({
    history: createHistory,
    routes,
    scrollBehavior: () => ({ top: 0 })
  })

  return router
}
