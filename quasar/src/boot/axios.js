import { defineBoot } from '#q-app/wrappers'
import { LocalStorage } from 'quasar'
import axios from 'axios'

axios.defaults.withCredentials = false

const api = axios.create({ 
    baseURL: process.env.VUE_APP_API_URL 
});

api.interceptors.request.use((config) => {
    const token = LocalStorage.getItem("auth_token");

    if (token) {
        config.headers.Authorization = `Bearer ${token}`;
        
    }

    return config;
});

export default defineBoot(({ app }) => {
    app.config.globalProperties.$api = api;
});


export { api };