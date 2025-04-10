import { defineBoot } from '#q-app/wrappers'
import { LocalStorage } from 'quasar'
import axios from 'axios'

axios.defaults.withCredentials = false

const api = axios.create({ 
    baseURL: process.env.API_URL 

});

export default defineBoot(({ app, router }) => {
    api.interceptors.request.use((config) => {
        const token = LocalStorage.getItem("auth_token");
        // Não checar aqui, vai criar um laço infinito
        console.log('Token axios line 16: ', token)
        const publicAPIRoutes = ['/forgot-password']
        if (!token) {
            router.replace({path: '/login'})
            console.log('Está deslogado - token ausente');
            
        } else {
            config.headers.Authorization = `Bearer ${token}`;
            console.log(token);
        }
    
        return config;
    });

    app.config.globalProperties.$api = api;
});


export { api };