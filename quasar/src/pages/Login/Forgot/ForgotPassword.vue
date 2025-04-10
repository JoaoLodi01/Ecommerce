<template>
    <div class="flex justify-center">
        <div class="login-form border border-black p-5 rounded-lg shadow-xl">
            <q-form
                @submit.prevent="forgotMethod"
            >
                <h1 class="text-xl border-b border-black w-max mb-4">Recuperar senha</h1>
                
                <q-input 
                    filled 
                    v-model="email" 
                    label="E-mail" 
                    class="mb-4"
                    color="grey-7"
                />
                
                <q-btn  
                    @click=showLoading 
                    type="submit" 
                    class="m-2"
                    flat 
                    style="color: #1F2937"   
                    
                >
                    <span>Enviar e-mail de recuperação</span>
                </q-btn>

                <q-btn
                    class="m-2"
                    flat 
                    style="color: #1F2937"   
                    
                >
                    <button><router-link to="/login">Voltar</router-link></button>
                </q-btn>
            </q-form>
        </div> 
    </div>
</template>

<script>
    import { useQuasar } from 'quasar';
    import { onBeforeUnmount } from 'vue';
    import { api } from 'src/boot/axios';

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

                    timer = setTimeout(() => {
                        $q.loading.hide()
                        timer = void 0
                    }, 3000)
                }
            }
        },

        data() {
            return {
                email: ''
            }
        },

        methods: {
            async forgotMethod(){
                const response = await api.post('/api/v1/forgot-password', {
                    email: this.email
                })

                console.log(response)

            }
        },
        mounted()
        {
            console.log(this.$route.name)
        }
    }
</script>