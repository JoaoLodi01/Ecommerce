import { api } from 'boot/axios';
import { LocalStorage } from 'quasar';
import routes from '../router/routes'

const auth = async () => {
  const token = LocalStorage.getItem("auth_token");

  if (!token) {
    routes.push({ path: '/login' });
    return;
  }

  try {
    await api.get('/auth/me', {
      headers: {
        'Authorization': `Bearer ${token}`
      }
    });
  } catch (error) {
    if (error.response && error.response.status === 401) {
      LocalStorage.removeItem("auth_token");
      routes.push({ path: '/login' });
    }
  }
};

export { auth };
