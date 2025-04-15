<template>
    <div class="flex justify-center mt-40">
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
                    type="submit" 
                    class="m-2"
                    flat 
                    style="color: #1F2937"   
                    label="Enviar e-mail de recuperação"   
                />

                <router-link to="/login">
                    <q-btn
                        class="m-2"
                        flat 
                        type="button" 
                        style="color: #1F2937"   
                        label="Voltar"
                    />

                </router-link>
            </q-form>
        </div> 
        <div class="mt-8" v-if="message">
            {{ message }}
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
                email: '',
                message: ''
            }
        },

        methods: {
            async forgotMethod(){
                this.showLoading()
                const response = await api.post('/forgot-password', {
                    email: this.email

                })

                if(response.data.success)
                {
                    this.message = 'Confirme a sua caixa de e-mail, você já pode fechar essa página!'
                }
            }
        }
    }
</script>