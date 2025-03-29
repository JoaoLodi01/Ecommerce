<template>
    <div class="flex justify-center" v-if="!loged">
        <div class="login-form border border-black p-5 rounded-lg shadow-xl">
            <q-form
                @submit.prevent="loginMethod"
                v-if="showLogin"
            >
                <h1 class="text-xl border-b border-black w-12 mb-4">Login</h1>
                <q-input 
                    filled 
                    v-model="details.email" 
                    label="E-mail" 
                    stack-label 
                    class="mb-4"
                />
                
                <q-input 
                    filled 
                    v-model="details.password" 
                    label="Senha"
                    type="password"
                    class="mb-4"
                />
           
                <q-btn 
                    @click=showLoading 
                    type="submit" 
                    label="Entrar"
                    class="m-2"
                    flat 
                    style="color: #1F2937"          
                />

                <q-btn 
                    @click=showLoading 
                    type="button"
                    flat 
                    style="color: #1F2937"    
                >   
                    <button @click="showRegisterForm">Não possui uma conta?</button>
                </q-btn>
                <span class="flex justify-end cursor-pointer hover:">Esqueceu sua senha?</span>
            </q-form>
            

            <Register 
                v-if="showRegister"
                @close="hideFormRegister($event)"
            />
        </div> 
    </div>
</template>

<script>
    import { api } from "boot/axios"
    import { useQuasar, LocalStorage } from 'quasar';
    import { onBeforeUnmount } from "vue";
    import Register from '../Login/Register.vue'

    export default {
        components: {
            Register
        },

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

                loged: LocalStorage.getItem("loged"),
                showRegister: false,
                showLogin: true,
            }
        },

        methods: {
            hideFormRegister(event)
            {
                this.showLogin = true
                this.showRegister = false
                console.log('event', event)

            },

            forgetPassword()
            {

            },

            async loginMethod() {
                try {                    
                    const response = await api.post("/auth/auth", this.details);
              
                    if (response.data.status && response.data.token) {
                        console.log('Vai enviar para o /')
                        alert('Login bem sucessido!')
                        
                        LocalStorage.setItem("auth_token", response.data.token);
                        LocalStorage.setItem("loged", response.data.status);
                        
                        this.$router.push('/')
                        window.location.reload()
                 
                    } else {
                        alert("Credenciais inválidas!");

                    }
                    
                    
                } catch (error) {
                    console.error("Erro no login:", error);
                    alert("Erro ao tentar fazer login. Verifique suas credenciais e tente novamente.");

                }
            },

            showRegisterForm()
            {
                this.showRegister = !this.showRegister
                this.showLogin = false
            }
        },
        
        mounted(){
           
        }
    }

</script>