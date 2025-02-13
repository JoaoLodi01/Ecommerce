import { createApp } from 'vue';
import App from './App.vue';
import router from './routes';
import './assets/tailwind.css';

const app = createApp(App).use(router).mount('#app')
