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
                
            >
                <h1 class="text-xl ml-auto mr-auto border-b border-black w-max mb-4">Registrar Emitente</h1>
                <q-input 
                    v-model="text"
                    type="text" 
                    
                />

                <q-btn 
                    @click=showLoading 
                    type="submit"
                    label="Criar conta"
                    class="m-2"
                    flat 
                    style="color: #1F2937"   
                />
                
                <router-link to="/login">
                    <q-btn
                        type="button"
                        class="m-2"
                        flat 
                        style="color: #1F2937"   
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
                issuer: {
                    cnpj: '',
                    cpf: '',
                    
                }
            }
        },
        methods: {
           
        },

    }

</script>