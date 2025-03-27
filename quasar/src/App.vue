<template>
    <div v-if="!loged" class="flex justify-center">
        <form @submit.prevent="loginMethod">
            <input
                placeholder="E-mail" 
                v-model="details.email"
                type="text"
            />

            <input 
                placeholder="Senha" 
                v-model="details.password"
                type="password"
                
            />
            <button>Entrar</button>
        </form>
    </div>

    <div v-if="loged" class="absolute top-1">
        <Sidebar/>

    </div>

   
</template>

<script>
    import { api } from "boot/axios"
    import Sidebar from 'src/components/Sidebar.vue';
    import { LocalStorage } from 'quasar';
import axios from "axios";

    export default {
        data(){
            return {
                details: {
                    email: '',
                    password: ''
                },
                loged: false,
                api: process.env.VUE_APP_API_URL 
            }
        },

        components: {
            Sidebar
            
        },
        
        methods: {
            async loginMethod() {
                try {
                    console.log("Enviando dados:", this.details);
                    
                    
                    const response = await api.post("/auth/auth", this.details);
                    
                    console.log("Resposta:", response.data);

                    if (response.data.status && response.data.token) {
                        
                        LocalStorage.set("auth_token", response.data.token);
                        const token = LocalStorage.getItem("auth_token");
                        LocalStorage.set("loged", true);
                        console.log('token: ', token)

                        this.loged = true;
                    } else {
                        alert("Credenciais inválidas!");
                    }
                } catch (error) {
                    console.error("Erro no login:", error);
                    alert("Erro ao tentar fazer login. Verifique suas credenciais.");
                }
            },

            async checkAuth() {
                const token = LocalStorage.getItem("auth_token");
                try {
                    const response = await api.get('/auth/me')
                    console.log('token', token)
                    console.log('response checkAuth', response)
                    if(response.data.status)
                    {
                        console.log('token logado', token)
                        this.loged = true
                        LocalStorage.set("loged", true);

                    } else {
                        this.logout()
                    }
                    
                } catch (error) {
                    console.error('Erro checkAuth, token:', token)
                    console.log('token', token)
                }
                
            },
            
            logout()
            {
                console.log("Saindo ...")
                LocalStorage.remove("auth_token")
                LocalStorage.remove("loged");
                this.loged = false
            }
        },

        mounted()
        {
            const a = axios.get('http://192.168.98.51:8000/sanctum/csrf-cookie');
            console.log('a: ', a)
            this.loged = LocalStorage.getItem("loged") || false
            this.checkAuth()
            console.log('Token atual no LocalStorage: ', LocalStorage.getItem("auth_token"));

        }
    }

</script>