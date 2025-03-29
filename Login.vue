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
            <div class="q-pa-md">
                <q-btn @click=showLoading type="submit" label="Entrar"/>
            </div>
        </form>
        <q-btn>Criar login</q-btn>
    </div>

</template>

<script>
    import { api } from "boot/axios"
    import { useQuasar, LocalStorage } from 'quasar';
    import { onBeforeUnmount } from "vue";
    
    export default {
        setup () {
            const $q = useQuasar()
            let timer

            onBeforeUnmount(() => {
            if (timer !== void 0) {
                clearTimeout(timer)
                $q.loading.hide()
            }
            })

            return {
            showLoading () {
                $q.loading.show({
                    message: 'Carregando...'
                })

                    // hiding in 3s
                timer = setTimeout(() => {
                    $q.loading.hide()
                    timer = void 0
                    }, 3000)
                }
            }
        },
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
                        this.$router.push('/home')
                        
                    } else {
                        alert("Credenciais inválidas!");

                    }

                } catch (error) {
                    console.error("Erro no login:", error);
                    alert("Erro ao tentar fazer login. Verifique suas credenciais e tente novamente.");

                }
            },
        },
        mounted(){
            const token = LocalStorage.getItem("auth_token")
            const auth = async () => {
                const response = api.get('/auth/me', {
                    headers: {
                        'Authorization': `Bearer ${token}`
                    }
                })
            
                console.log(response)
            }
            auth()
        }
    }

</script>