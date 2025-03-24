import { createApp } from 'vue';
import { createI18n } from 'vue-i18n';
import App from './App.vue';
import router from './routes';
import vuetify from './plugins/vuetify';
import './assets/tailwind.css';

const messages = {
    en: {
      message: {
        constraints: 'o campo CNPJ deve ser uma valor que obedece ao algoritmo de verificação cnpj',
      },
    },

    fr: {
      message: {
        hello: 'Bonjour le monde',
      },
    },
  };

const i18n = createI18n({
    locale: 'en',
    fallbackLocale: 'pt-BR',
    messages
})

createApp(App).use(router).use(i18n).mount('#app')
