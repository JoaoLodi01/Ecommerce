import { defineBoot } from '#q-app/wrappers'
import axios from 'axios'
import { LocalStorage } from 'quasar'

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