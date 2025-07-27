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
        component: () => import('layouts/MainLayout.vue'),
        children: [
            { 
                path: '',  
                component: () => import('pages/Admin/AdminPage.vue')
            },
            { 
                path: '/home/customers',  
                component: () => import('pages/Admin/Customers/ListCustomers.vue')
            }
        ],

    },
    {
        path: '/:catchAll(.*)*',
        component: () => import('pages/ErrorNotFound.vue'),
    },
];

export default routes;
