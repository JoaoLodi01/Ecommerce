import ListPDVView from 'src/pages/PDV/ListPDVView.vue'
import PDVView from 'src/pages/PDV/PDVView.vue'

const routes = [
  {
    path: '/',
    component: () => import('layouts/MainLayout.vue'),
    children: [
      { path: '', component: () => import('pages/IndexPage.vue') }
    ]
  },

  // Always leave this as last one,
  // but you can also remove it
  {
    path: '/:catchAll(.*)*',
    component: () => import('pages/ErrorNotFound.vue')
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
  {
    path: '/sale/list-pdv',
    name: 'ListPDV',
    component: ListPDVView

  },
]

export default routes
