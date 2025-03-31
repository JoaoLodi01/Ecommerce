<template>
    <div class="Register-form">
        <q-form
            v-if="showRegister"
            @submit.prevent="createAccount"
            
        >
            <h1 class="text-xl border-b border-black w-max mb-4">Registrar</h1>
            <q-input 
                filled        
                label="Nome" 
                v-model="registerDetails.name"
                stack-label 
                class="mb-4"
            />

            <q-input 
                filled        
                label="E-mail" 
                v-model="registerDetails.email"
                stack-label 
                class="mb-4"
            />

            <q-input 
                filled        
                label="Confirme seu E-mail" 
                v-model="registerDetails.email_"
                stack-label
                class="mb-4"
                
            />
            
            <q-input 
                filled 
                label="Senha"
                v-model="registerDetails.password"
                :type="showPassword ? 'text' : 'password'"
                class="mb-4"
            >
                <svg 
                    @click="showPassword = !showPassword" 
                    xmlns="http://www.w3.org/2000/svg"
                    fill="none" 
                    viewBox="0 0 24 24" 
                    stroke-width="1.5" 
                    stroke="currentColor" 
                    class="size-4 mt-5"
                    v-if="showPassword"
                >
                    <path stroke-linecap="round" stroke-linejoin="round" d="M2.036 12.322a1.012 1.012 0 0 1 0-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178Z" />
                    <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
                </svg>

                <svg 
                    @click="showPassword = !showPassword"         
                    xmlns="http://www.w3.org/2000/svg" 
                    fill="none" 
                    viewBox="0 0 24 24" 
                    stroke-width="1.5" 
                    stroke="currentColor" 
                    class="size-4 mt-5 text-gray-600"
                    v-if="!showPassword"
                >
                    <path stroke-linecap="round" stroke-linejoin="round" d="M3.98 8.223A10.477 10.477 0 0 0 1.934 12C3.226 16.338 7.244 19.5 12 19.5c.993 0 1.953-.138 2.863-.395M6.228 6.228A10.451 10.451 0 0 1 12 4.5c4.756 0 8.773 3.162 10.065 7.498a10.522 10.522 0 0 1-4.293 5.774M6.228 6.228 3 3m3.228 3.228 3.65 3.65m7.894 7.894L21 21m-3.228-3.228-3.65-3.65m0 0a3 3 0 1 0-4.243-4.243m4.242 4.242L9.88 9.88" />
                </svg>
            </q-input>

            <q-input 
                filled 
                label="Confirme sua Senha"
                v-model="registerDetails.password_"
                :type="showPassword ? 'text' : 'password'"
                class="mb-4"
            >
                <svg 
                    @click="showPassword = !showPassword" 
                    xmlns="http://www.w3.org/2000/svg"
                    fill="none" 
                    viewBox="0 0 24 24" 
                    stroke-width="1.5" 
                    stroke="currentColor" 
                    class="size-4 mt-5"
                    v-if="showPassword"
                >
                    <path stroke-linecap="round" stroke-linejoin="round" d="M2.036 12.322a1.012 1.012 0 0 1 0-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178Z" />
                    <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
                </svg>

                <svg 
                    @click="showPassword = !showPassword"         
                    xmlns="http://www.w3.org/2000/svg" 
                    fill="none" 
                    viewBox="0 0 24 24" 
                    stroke-width="1.5" 
                    stroke="currentColor" 
                    class="size-4 mt-5 text-gray-600"
                    v-if="!showPassword"
                >
                    <path stroke-linecap="round" stroke-linejoin="round" d="M3.98 8.223A10.477 10.477 0 0 0 1.934 12C3.226 16.338 7.244 19.5 12 19.5c.993 0 1.953-.138 2.863-.395M6.228 6.228A10.451 10.451 0 0 1 12 4.5c4.756 0 8.773 3.162 10.065 7.498a10.522 10.522 0 0 1-4.293 5.774M6.228 6.228 3 3m3.228 3.228 3.65 3.65m7.894 7.894L21 21m-3.228-3.228-3.65-3.65m0 0a3 3 0 1 0-4.243-4.243m4.242 4.242L9.88 9.88" />
                </svg>
            </q-input>

            <q-btn 
                @click=showLoading 
                type="submit"
                label="Criar conta"
            />

            <q-btn
                type="button"
                @click="hideForm" 
                label="Já possui uma conta?"
                class="m-2"

            />
            </q-form>
            <div v-if="messages.length > 0 ">
                <p v-for="message in messages">
                    {{ message }}
                </p>
            </div>
            
        </div>
</template>

<script>
    import { useQuasar } from 'quasar'
    import { api } from 'src/boot/axios'
    import { onBeforeUnmount } from 'vue'
    
    export default {
        setup()
        {
            const $q = useQuasar()
            let timer

            onBeforeUnmount(() => {
                if(timer !== void 0)
                {
                    clearTimeout(timer)
                    $q.loading.hide   
                }
            })

            return {
                showLoading () {
                    $q.loading.show({
                        message: 'Criando sua conta ...'
                    })

                    timer = setTimeout(() => {
                        $q.loading.hide()
                        timer = void 0
            
                    }, 2000)
                }
            }
        },

        data()
        {
            return {
                showRegister: true,
                showPassword: false,
                registerDetails: {
                    name: '',
                    email: '',
                    email_: '',
                    password: '',
                    password_: ''
                    
                },
                messages: []
            }
        },
        methods: {
            async createAccount(){
                this.messages = []
                const email = this.checkEmail()
                const password = this.checkPassword()
                if(!email && !password)
                {
                    try {
                        const response = await api.post('/users/create', {
                            name: this.registerDetails.name,
                            email: this.registerDetails.email.toLowerCase(),
                            password: this.registerDetails.password
                        })
                        
                        if(response.data.success)
                        {
                            alert(`Bem vindo! ${response.data.user.name}`)
                            this.hideForm()
                        } 
                        
                    } catch (error) {
                        this.messages.push(error.response.data.message ?? null)
                        const register = this.registerDetails
                        switch (error.response.data.message) {
                            case 'Esse e-mail já está sendo usado!':
                                register.email = null
                                register.email_ = null
                                break;
                        
                            default:
                                break;
                        }
                    }
                } 
            },
            hideForm()
            {
                this.showRegister = !this.showRegister
                this.$emit("close", true)
                window.location.reload()
            },

            checkEmail(){
                if(this.registerDetails.email_ !== this.registerDetails.email)
                {
                    console.log('e-mail')
                    this.messages.push('Os e-mails não iguais!')
                    return true
                } else {
                    return false
                }
            },
            checkPassword(){
                if(this.registerDetails.password_ !== this.registerDetails.password)
                {
                    this.messages.push('As senhas não iguais!')
                    return true

                } else {
                    return false
                }
            
            }   

        },

    }

</script>