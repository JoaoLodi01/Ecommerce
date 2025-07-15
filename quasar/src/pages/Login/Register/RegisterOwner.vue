<template>
    <Transition name="slide-up">
        <div v-if="showContent">
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
                            color="primary"
                            v-model="form.name"
                            maxlength="120"
                            :rules="[
                                val => !!val || 'Preencha seu nome!'
                            ]"
                        />

                        <q-input 
                            filled        
                            label="Sobrenome" 
                            class="mb-4"
                            color="primary"
                            v-model="form.surname"
                            maxlength="90"
                            :rules="[
                                val => !!val || 'Preencha seu sobre-nome!'
                            ]"

                        />

                        <q-input 
                            filled        
                            label="E-mail"                      
                            class="mb-4"
                            color="primary"
                            v-model="form.email"
                            maxlength="90"
                            :rules="[
                                val => !!val || 'Preencha seu e-mail!'
                            ]"

                        />

                        <q-input 
                            filled
                            class="mb-4"
                            color="primary"
                            label="CPF" 
                            v-model="form.cpf"
                            v-bind:mask="'###.###.###-##'"
                            maxlength="14"
                            :rules="[
                                val => {
                                    if(!val) return 'Preencha seu CPF!';
                                    return validateCPF(val) || 'CPF Inválido!';
                                }
                                        
                            ]"

                        />        
                                
                        <q-input 
                            filled 
                            label="Senha"
                            class="mb-4"
                            color="primary"
                            v-model="form.password"
                            :type="showPassword ? 'text' : 'password'"
                            :rules="[
                                val => val.length >= 8 || 'A senha precisa possuir 8 caracters',
                                val => checkPassword(val)
                            ]"
                        >
                            <svg 
                                @click="showPassword = !showPassword" 
                                xmlns="http://www.w3.org/2000/svg"
                                fill="none" 
                                viewBox="0 0 24 24" 
                                stroke-width="1.5" 
                                stroke="currentColor" 
                                class="size-4 mt-5 cursor-pointer"
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
                                class="size-4 mt-5 cursor-pointer"
                                v-if="!showPassword"
                            >
                                <path stroke-linecap="round" stroke-linejoin="round" d="M3.98 8.223A10.477 10.477 0 0 0 1.934 12C3.226 16.338 7.244 19.5 12 19.5c.993 0 1.953-.138 2.863-.395M6.228 6.228A10.451 10.451 0 0 1 12 4.5c4.756 0 8.773 3.162 10.065 7.498a10.522 10.522 0 0 1-4.293 5.774M6.228 6.228 3 3m3.228 3.228 3.65 3.65m7.894 7.894L21 21m-3.228-3.228-3.65-3.65m0 0a3 3 0 1 0-4.243-4.243m4.242 4.242L9.88 9.88" />
                            </svg>
                        </q-input>

                        <q-input 
                            filled 
                            class="mb-4"
                            color="primary"
                            label="Confirme sua Senha"
                            v-model="form.password_"
                            :type="showPassword_ ? 'text' : 'password'"
                            :rules="[
                                val => val.length >= 8 || 'A senha precisa possuir 8 caracters',
                                val => checkPassword(val)
                            ]"
                        >
                            <svg 
                                @click="showPassword_ = !showPassword_" 
                                xmlns="http://www.w3.org/2000/svg"
                                fill="none" 
                                viewBox="0 0 24 24" 
                                stroke-width="1.5" 
                                stroke="currentColor" 
                                class="size-4 mt-5 cursor-pointer"
                                v-if="showPassword_"
                            >
                                <path stroke-linecap="round" stroke-linejoin="round" d="M2.036 12.322a1.012 1.012 0 0 1 0-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178Z" />
                                <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
                            </svg>

                            <svg 
                                @click="showPassword_ = !showPassword_"         
                                xmlns="http://www.w3.org/2000/svg" 
                                fill="none" 
                                viewBox="0 0 24 24" 
                                stroke-width="1.5" 
                                stroke="currentColor" 
                                class="size-4 mt-5 cursor-pointer"
                                v-if="!showPassword_"
                            >
                                <path stroke-linecap="round" stroke-linejoin="round" d="M3.98 8.223A10.477 10.477 0 0 0 1.934 12C3.226 16.338 7.244 19.5 12 19.5c.993 0 1.953-.138 2.863-.395M6.228 6.228A10.451 10.451 0 0 1 12 4.5c4.756 0 8.773 3.162 10.065 7.498a10.522 10.522 0 0 1-4.293 5.774M6.228 6.228 3 3m3.228 3.228 3.65 3.65m7.894 7.894L21 21m-3.228-3.228-3.65-3.65m0 0a3 3 0 1 0-4.243-4.243m4.242 4.242L9.88 9.88" />
                            </svg>
                        </q-input>

                        <div class="flex justify-center">
                            <q-btn  
                                type="submit"
                                label="Criar conta"
                                class="m-2"
                                color="primary"  
                            />
                            
                            <router-link to="/login">
                                <q-btn
                                    type="button"
                                    class="m-2"
                                    color="primary"   
                                    label="Já possui uma conta?"
                                />
                            </router-link>
                        </div>

                    </q-form>
                    
                </div>
            </div>
        </div>
    </Transition>
</template>

<script setup lang="ts">
    import { useQuasar } from 'quasar';
    import { api } from 'src/boot/axios';
    import { onMounted, ref } from 'vue';
    import { useRouter } from 'vue-router';
    import validateCPF from 'src/utils/validateCPF';

    interface IOwnerData
    {
        name: string,
        surname: string,
        cpf: string,
        email: string,
        password: string,
        password_: string
    };

    const $q = useQuasar();
    const router = useRouter();
    
    const form = ref<IOwnerData>({
        name: '',
        surname: '',
        cpf: '',
        email: '',
        password: '',
        password_: ''
        
    });
    
    let showContent = ref<boolean>(false);
    let showPassword = ref<boolean>(false);
    let showPassword_ = ref<boolean>(false);

    const createAccount = async () =>
    {
        const res = await api.post('/registers/owner/create', {
            name: form.value.name,
            surname: form.value.surname,
            cpf: form.value.cpf.replace(/\D/g, ''),
            email: form.value.email.toLowerCase(),
            password: form.value.password
            
        });

        if(res.data.success)
        {
            $q.notify({
                color: 'green',
                message: res.data.message,
                timeout: 1200,
                position: 'top'
            
            });

            router.push({path: '/login'});

        }  else {
            console.log('Res: ', res.data);
            $q.notify({
                color: 'red',
                message: res.data.th ?? res.data,
                timeout: 1200,
                position: 'top'
            
            });
        };
    };

    const checkPassword = (password: string) =>
    {
        const specialChars = '`!@#$^&;:?~';
        const hasSpecial = password.split('').some(char => specialChars.includes(char));
        return hasSpecial ? true : 'A senha precisa ter 1 caracter especial';
    };

    onMounted(() => {
        showContent.value = true;
    });
</script>

<style>
    .slide-up-enter-from {
        opacity: 0;
        transform: translateY(50px);

    }

    .slide-up-enter-to {
        opacity: 1;
        transform: translateY(0);
        
    }

    .slide-up-enter-active {
        transition: all 0.5s ease-out;
    }
    
    @media(min-width: 1366px)
    {
        .form-container{
            width: 60vh;
         
        }

    }
    
</style>