import { api } from 'boot/axios';
import { LocalStorage } from 'quasar';

export default async function login(email, password) {
    try {
        const response = await api.post('/login', {
            email,
            password 
            
        })

        if(response.data.success)
        {
            LocalStorage.set("auth_token", response.data.token)

        }   
        return response.data

    } catch (error) {
        console.error("Erro no login:", error);
        throw error;
    }
}