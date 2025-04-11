<template>
    <div class="flex justify-center">
        <div class="login-form border border-black p-5 rounded-lg shadow-xl">
            <q-form
                @submit.prevent="updatePassword()"
            >
                <h1 class="text-xl border-b border-black w-max mb-4">Recuperar senha</h1>
                
                <q-input 
                    filled 
                    v-model="data.email" 
                    label="E-mail" 
                    class="mb-4"
                    color="grey-7"
                />

                <q-input 
                    filled 
                    v-model="data.password" 
                    label="Nova senha" 
                    class="mb-4"
                    type="password"
                    color="grey-7"
                />

                <q-input 
                    filled 
                    v-model="data.password_confirmation" 
                    @change="checkPassword()"
                    label="Confirme a nova senha" 
                    class="mb-4"
                    type="password"
                    color="grey-7"
                />
                
                <q-btn  
                    @click=showLoading 
                    type="submit" 
                    class="m-2"
                    flat 
                    style="color: #1F2937"   
                    label="Alterar senha"   
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
    </div>
    <div class="" v-if="message">
        {{ message }}
    </div>
</template>

<script>
    import { api } from 'src/boot/axios';
    import { useQuasar } from 'quasar';
    import { onBeforeUnmount } from 'vue';

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

        data()
        {
            return{ 
                data: {
                    token: this.$route.params.token,
                    email: '',
                    password: '',
                    password_confirmation: ''
                    
                },
                message: ''
                
            }
        },

        methods: {
            async updatePassword()
            {
                const response = await api.post('/reset-passowrd', this.data)
                if(response.data.success)
                {
                    this.$router.push({path: '/login'})   
                }
                
            },

            checkPassword()
            {
                if(this.data.password !== this.data.password)
                {
                    this.message = 'As senhas são diferentes'
                    console.log('As senhas são diferentes')
                }
                
            }
        }
    }
</script>