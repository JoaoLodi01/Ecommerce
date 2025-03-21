import PDVView from 'src/pages/PDV/PDVView.vue'

const routes = [
  {
    path: '/',
    
  },
  {
    path: '/sale/pdv',
    name: 'PDV', 
    component: PDVView
  },
  {
    path: '/sale/save/pdv/:idPDV',
    name: 'PDVID',
    component: PDVView,
    props: true

  },
]

export default routes
