import { api } from 'boot/axios';
import { LocalStorage } from 'quasar';

const auth = () => {
    const token = LocalStorage.getItem("auth_token")
    api.get('/auth/me', {
        headers: {
            'Authorization': `Bearer ${token}`
        }
    })
}
auth 

export { auth }