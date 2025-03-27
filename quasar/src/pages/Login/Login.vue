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

</template>

<script>
    import { api } from "boot/axios"
    import { LocalStorage } from 'quasar';

    export default {
        data(){
            return {
                details: {
                    email: '',
                    password: ''
                },
                
            }
        },

        methods: {
            async loginMethod() {
                try {
                    
                    const response = await api.post("/auth/auth", this.details);
                    
                    console.log("Resposta:", response.data);

                    if (response.data.status && response.data.token) {
                        
                        localStorage.setItem("auth_token", response.data.token);
                        const token = LocalStorage.getItem("auth_token");

                        LocalStorage.set("loged", true);
                        console.log('token no LocalStorage: ', token)

                        
                    } else {
                        alert("Credenciais inválidas!");

                    }

                } catch (error) {
                    console.error("Erro no login:", error);
                    alert("Erro ao tentar fazer login. Verifique suas credenciais.");

                }
            },

            async checkAuth() {
                try {
                    const token = LocalStorage.getItem("auth_token");

                    const response = api.get('/auth/me', {
                        headers: {
                            'Authorization': `Bearer ${token}`
                        }
                    })
                    
                    console.log('token', token)
                    console.log('response checkAuth', response)
                    if(response.data)
                    {
                        console.log('token logado', token)
                        this.loged = true
                        LocalStorage.set("loged", true);

                    } else {
                        this.logout()
                    }
                    
                } catch (error) {
                    console.error('Erro checkAuth, token:', token)
                    console.error('error', error)
                }
                
            },
            
            logout()
            {
                console.log("Saindo ...")
                LocalStorage.remove("auth_token")
                LocalStorage.remove("loged");
                
            }
        },

        mounted()
        {
            this.checkAuth()

        }
    }

</script>