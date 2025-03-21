import HomeView from 'src/pages/HomeView.vue'
import PDVView from 'src/pages/PDV/PDVView.vue'

const routes = [
  {
    path: '/',
    name: 'Home',
    component: HomeView
  },

  {
    path: '/sale/pdv',
    name: 'PDV',
    component: PDVView
  }
  
]

export default routes
