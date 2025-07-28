import type { RouteRecordRaw } from 'vue-router';

const routes: RouteRecordRaw[] = [
    {
        path: '/',
        name: 'AuthPage',
        component: () => import('pages/Auth/AuthPage.vue')
        
    },
    {
        path: '/home',
        name: 'Home',
        component: () => import('layouts/SideBar.vue'),
        children: [
            { 
                path: '/',  
                component: () => import('pages/Admin/AdminPage.vue')
            },
            { 
                path: '/home/customers',  
                component: () => import('pages/Admin/Customers/ListCustomers.vue')
            },
            { 
                path: '/home/receive',  
                component: () => import('pages/Admin/Receive/ListReceive.vue')
            },
        ],

    },
    {
        path: '/:catchAll(.*)*',
        component: () => import('pages/ErrorNotFound.vue'),
    },
];

export default routes;
