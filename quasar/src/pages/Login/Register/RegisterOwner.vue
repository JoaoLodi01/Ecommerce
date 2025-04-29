<template>
    <div class="p-10 flex">
        <router-link to="/" class="flex">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                <path stroke-linecap="round" stroke-linejoin="round" d="M10.5 19.5 3 12m0 0 7.5-7.5M3 12h18" />
            </svg>
            <span class="mt-0.5 ml-2">Voltar</span>
        </router-link>
    </div>
    <div class="flex justify-center">
        <div class="login-form border border-black p-5 rounded-lg shadow-xl">
            <q-form
                @submit.prevent="createAccount"
                class="form-container"
            >
                <h1 class="text-xl ml-auto mr-auto border-b border-black w-max mb-4">Crie a sua conta!</h1>
                
                <q-input 
                    filled        
                    label="Nome" 
                    class="mb-4"
                    color="grey"
                    v-model="form.name"
                    maxlength="120"
                />

                <q-input 
                    filled        
                    label="Sobrenome" 
                    class="mb-4"
                    color="grey"
                    v-model="form.surname"
                    maxlength="90"

                />

                <q-input 
                    filled        
                    label="E-mail"                      
                    class="mb-4"
                    color="grey"
                    v-model="form.email"
                    maxlength="90"

                />

                <q-input 
                    filled
                    class="mb-4"
                    color="grey"
                    label="CPF" 
                    v-model="form.cpf"
                    v-bind:mask="'###.###.###-##'"
                    maxlength="14"

                />        
                        
                <q-input 
                    filled 
                    label="Senha"
                    class="mb-4"
                    color="grey"
                    v-model="form.password"
                    :type="showPassword ? 'text' : 'password'"
                    
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
                    
                    class="mb-4"
                    color="grey"
                    label="Confirme sua Senha"
                    v-model="form.password_"
                    :type="showPassword ? 'text' : 'password'"
                    
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
                    type="submit"
                    label="Criar conta"
                    class="m-2"
                    color="grey"  
                />
                
                <router-link to="/login">
                    <q-btn
                        type="button"
                        class="m-2"
                        color="grey"   
                        label="Já possui uma conta?"
                    />
                </router-link>
                
            </q-form>
            <div v-if="messages.length > 0 ">
                <p v-for="message in messages">
                    {{ message }}
                </p>
            </div>
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
                    $q.loading.hide() 
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
            
                    }, 1000)
                }
            }
        },

        data()
        {
            return {
                form: {
                    name: '',
                    surname: '',
                    cpf: '',
                    email: '',
                    password: '',
                    password_: ''
                    
                },

                showRegister: true,
                showPassword: false,

                messages: []
            }
        },
        
        methods: {
            async createAccount(){
                this.messages = []
                this.showLoading()
                const password = this.checkPassword()
                if(password)
                {
                    console.log('Vai criar')
                    try {
                        const response = await api.post('/registers/owner/create', {
                            name: this.form.name,
                            surname: this.form.surname,
                            cpf: this.form.cpf.replace(/\D/g, ''),
                            email: this.form.email.toLowerCase(),
                            password: this.form.password,
                            
                        })

                        if(response.data.success)
                        {
                            this.$router.push({path: '/login'})

                        }  else {
                            alert(`Erro: ${response.data.th ?? response.data}`)

                        }
                        
                    } catch (error) {
                        console.error('Erro catch', error)
                        //this.messages.push(error.response.data.code ?? null)
                        switch (error.response.data.code) {
                            case "23000":
                                this.messages.push('CPF já cadastrado!')
                                break;
                        
                            default:
                                break;
                        }
                    }
                } 
            },

            checkPassword(){
                const specialChars = '`!@#$^&;:?~.';
                if(this.form.password.length >= 8 && this.form.password_.length >= 8)
                {
                    if(specialChars.split('').some(specialChars => this.form.password.includes(specialChars)) === true)
                    {
                        if(this.form.password_ !== this.form.password)
                        {
                            this.messages.push('As senhas não iguais!')
                            return false
    
                        } else {
                            return true
                        }
                        
                    } else {
                        this.messages.push('A senha deve conter pelo menos 1 caracter especial')
                        return false
                    }

                } else {
                    this.form.password
                    this.messages.push('A senha deve conter pelo menos 8 caracteres')
                    return false
                }  
            }   
        },
    }

</script>

<style>
    @media(min-width: 1366px)
    {
        .form-container{
            width: 60vh;
         
        }

    }
    
</style>