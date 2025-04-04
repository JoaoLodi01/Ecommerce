import { defineBoot } from '#q-app/wrappers'
import { LocalStorage } from 'quasar'
import axios from 'axios'

axios.defaults.withCredentials = false

const api = axios.create({ 
    baseURL: process.env.API_URL 
});

const token = LocalStorage.getItem("auth_token");
console.log('De axios.js: ', token)  
if(!token)
{
    console.log('Estado atual: deslogado')
    
} else {
    api.interceptors.request.use((config) => {
        if (token) {
            config.headers.Authorization = `Bearer ${token}`;
            console.log('Estado atual: logado')   
        } 

        return config;
    });
}

export default defineBoot(({ app }) => {
    app.config.globalProperties.$api = api;
});


export { api };