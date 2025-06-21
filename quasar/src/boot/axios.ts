import { defineBoot } from '#q-app/wrappers';
import { LocalStorage } from 'quasar';
import axios from 'axios';
import emitter from 'src/utils/eventBus';

axios.defaults.withCredentials = false;

const api = axios.create({
  baseURL: process.env.API_URL,
});

export default defineBoot(({ app, router }) => {
  api.interceptors.request.use(
    (config) => {
      const token = LocalStorage.getItem("auth_token");

      const publicAPIRoutes = [
        '/forgot-password',
        '/reset-password',
        '/auth/check',
        '/owner'
      ];

      const isPublic = publicAPIRoutes.some(route => config.url.includes(route));

      if (!token && !isPublic)
      {
        console.log('token:', token)
        router.replace({ path: '/login' });
        
        return Promise.reject(new Error("Usuário não autenticado"));
      }

      if (token) {
        config.headers.Authorization = `Bearer ${token}`;
      }

      return config;
    },
    (error) => {
      emitter.emit('global-error', 'Erro ao enviar requisição');
      return Promise.reject(error);
    }
  );

  api.interceptors.response.use(
    (response) => response,
    (error) => {
      const publicAPIRoutes = [
        '/forgot-password',
        '/reset-password',
        '/auth/check',
        '/owner'
      ];
      
      // Corrigido: verifica se a URL da requisição é pública
      const requestUrl = error.config?.url || '';
      const isPublic = publicAPIRoutes.some(route => requestUrl.includes(route));

      if(error.response?.status === 401 && !isPublic)
      {
        const msg = 'Usuário não autenticado';
        router.replace({ path: '/login' });

        emitter.emit('global-error', msg);
        return Promise.reject(error);
      } else {
        if(error.response.data.status === 401)
        {
            router.replace({ path: '/login' });
            console.log('Error: ', error.response.data)

        }
        const msg =
          error.response?.data?.message ||
          error.response?.data?.errorMessage ||
          error.message ||
          'Erro inesperado na resposta da API';
          emitter.emit('global-error', msg);
          return Promise.reject(error);

      };
    }
  );

  app.config.globalProperties.$api = api;
  app.config.globalProperties.$bus = emitter;
});

export { api };
