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
                    
                    // Enviar os dados corretamente
                    const response = await api.post("/auth/auth", this.details);
                    console.log("Resposta:", response.data);

                    if (response.data.status && response.data.token) {
                        // Salvar o token no LocalStorage
                        LocalStorage.set("auth_token", response.data.token);
                        
                        // Atualizar o estado logado
                        this.loged = true;
                    } else {
                        alert("Credenciais inválidas!");
                    }
                } catch (error) {
                    console.error("Erro no login:", error);
                    alert("Erro ao tentar fazer login. Verifique suas credenciais.");
                }
            },
        },

        mounted()
        {
            
        }
    }

</script>