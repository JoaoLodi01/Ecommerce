import { defineBoot } from '#q-app/wrappers';
import axios, { type AxiosInstance } from 'axios';
import { LocalStorage, useQuasar } from 'quasar';
declare module 'vue' {
    interface ComponentCustomProperties {
        $axios: AxiosInstance;
        $api: AxiosInstance;
    }
}

// Be careful when using SSR for cross-request state pollution
// due to creating a Singleton instance here;
// If any client changes this (global) instance, it might be a
// good idea to move this instance creation inside of the
// "export default () => {}" function below (which runs individually
// for each client)
const api = axios.create({ baseURL: process.env.API_URL });

export default defineBoot(({ app, router }) => {
    api.interceptors.request.use(
        (config) => {
            const token = LocalStorage.getItem("authToken");
            const loginRoute = '/access/auth/login';

            if(!token && !config.url?.includes(loginRoute))
            {
                console.log(token);
                alert('Usuário não está logado');
                router.push('/');
            };

            if(token)
            {
                console.log(token);
                config.headers.Authorization = `Bearer ${token}`;
            };

            return config;
        }
    );

    api.interceptors.response.use(
        (config) => {
            return config;
        },
        (error) => {
            console.error('Erro na API: ', error);
            const errorMessage = error.response?.message || error.response?.data.message || 'Erro na API'

            app.config.globalProperties.$q.notify({
                color: 'red',
                message: errorMessage,
                position: 'top',
                timeout: 2000
            });
        }
    )
  
    app.config.globalProperties.$axios = axios;
    

    app.config.globalProperties.$api = api;
    
});

export { api };
