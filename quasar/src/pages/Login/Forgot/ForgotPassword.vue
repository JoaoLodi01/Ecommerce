<template>
    <div class="flex justify-center" v-if="!loged">
        <div class="login-form border border-black p-5 rounded-lg shadow-xl">
            <q-form
                @submit.prevent="forgotMethod"
            >
                <h1 class="text-xl border-b border-black w-max mb-4">Recuperar senha</h1>
                
                <q-input 
                    filled 
                    v-model="details.email" 
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
                <br>
                <q-btn
                    type="button"   
                    flat 
                    style="color: #1F2937"
                    class="btn-forgot"
                >
                    <button><a href="http://192.168.98.18:8000/forgot-password">Esqueceu sua senha?</a></button>

                </q-btn>
            </q-form>
        </div> 
    </div>
</template>

<script>
    import { api } from 'src/boot/axios';

    export default {
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