<template>
    <div class="flex justify-center">
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

                        console.log('token no LocalStorage: ', token)
                        this.$router.push('/home')
                        
                    } else {
                        alert("Credenciais inválidas!");

                    }

                } catch (error) {
                    console.error("Erro no login:", error);
                    alert("Erro ao tentar fazer login. Verifique suas credenciais.");

                }
            },
        },
    }

</script>