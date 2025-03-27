import { defineBoot } from '#q-app/wrappers'
import { LocalStorage } from 'quasar'
import axios from 'axios'

axios.defaults.withCredentials = true

const api = axios.create({ 
    baseURL: process.env.VUE_APP_API_URL 
});

const response = await axios.get('/auth/me')
console.log('response pelo AXIOS.JS', response.data)

api.interceptors.request.use((config) => {
    const token = LocalStorage.getItem("auth_token");
    console.log('Token pelo axios.js', token)

    if (token) {
        config.headers.Authorization = `Bearer ${token}`;
        
    }

    return config;
});

export default defineBoot(({ app }) => {
    app.config.globalProperties.$api = api;
});


export { api };