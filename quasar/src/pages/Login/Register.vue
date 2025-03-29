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
                type="password"
                class="mb-4"
            />
        
            <q-input 
                filled 
                label="Confirme sua Senha"
                v-model="registerDetails.password_"
                type="password"
                class="mb-4"
            />

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