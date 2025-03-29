<template>
    <div class="flex justify-center" v-if="!loged">
        <!--form @submit.prevent="loginMethod" class="p-5 border border-black">
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
            <div class="flex">
                <div class="q-pa-md">
                    <q-btn @click=showLoading type="submit" label="Entrar"/>
    
                </div>
    
                <div class="q-pa-md">
                    <q-btn @click="this.$router.push('/register')">Criar Conta</q-btn>
    
                </div>
            </div>
                
        </form-->
   
        <div class="login-form border border-black p-5">
            <q-form
                @submit.prevent="loginMethod"
            >
                <div class=""></div>
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
                />

                <q-btn 
                    @click=showLoading 
                    type="submit" 
                    
                >   
                    <button @click="showRegister">Registrar</button>
                </q-btn>
            </q-form>
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
            }
        },

        methods: {
            async loginMethod() {
                try {                    
                    const response = await api.post("/auth/auth", this.details);
              
                    if (response.data.status && response.data.token) {
                        console.log('Vai enviar para o /')
                        alert('Login bem sucessido!')
                        
                        LocalStorage.setItem("auth_token", response.data.token);
                        LocalStorage.setItem("loged", response.data.status);
                        
                        this.$router.push('/')
                        //
                 
                    } else {
                        alert("Credenciais inválidas!");

                    }
                    
                    window.location.reload()
                } catch (error) {
                    console.error("Erro no login:", error);
                    alert("Erro ao tentar fazer login. Verifique suas credenciais e tente novamente.");

                }
            },
        },
        
        mounted(){
           
        }
    }

</script>