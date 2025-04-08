<template>
    <div class="Register-form">
        <q-form
            @submit.prevent="emitForgotPassword"
            
        >
            <h1 class="text-xl border-b border-black w-max mb-4">Recuperar senha</h1>                
                <q-input 
                    filled 
                    label="E-mail"
                    v-model="userDetail.email"
                    type="email"
                    class="mb-4"
                />

                <q-btn 
                    @click=showLoading 
                    type="submit"
                
                >Enviar</q-btn>

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
    import { onBeforeUnmount } from 'vue'
    import { api } from 'src/boot/axios'
    
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
                userDetail: {
                    email: '',
                    
                },
                messages: []
            }
        },
        methods: {
            async emitForgotPassword(){
                this.messages = []
                
                const response = await api.post('/forgot-password', {
                    email: this.userDetail.email

                });

                console.log(response)
            },
        },
    }

</script>