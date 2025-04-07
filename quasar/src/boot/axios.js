import { defineBoot } from '#q-app/wrappers'
import { LocalStorage } from 'quasar'
import axios from 'axios'

axios.defaults.withCredentials = false

const api = axios.create({ 
    baseURL: process.env.API_URL 
});

const token = LocalStorage.getItem("auth_token");

if(!token)
{
    console.log('Está deslogado line 15')

} else {
    api.interceptors.request.use((config) => {
        const token = LocalStorage.getItem("auth_token");
    
        if (token) {
            config.headers.Authorization = `Bearer ${token}`;
        } else {
            console.log('Está deslogado - token ausente');
        }
    
        return config;
    });
}

export default defineBoot(({ app }) => {
    app.config.globalProperties.$api = api;
});


export { api };