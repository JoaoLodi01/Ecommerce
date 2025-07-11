<template>
    <div class="p-10 flex">
        <router-link to="/" class="flex">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                <path stroke-linecap="round" stroke-linejoin="round" d="M10.5 19.5 3 12m0 0 7.5-7.5M3 12h18" />
            </svg>
            <span class="mt-0.5 ml-2">Voltar</span>
        </router-link>
    </div>
    
    <Transition name="slide-up">
        <div v-if="showContent" class="flex justify-center">
            <div class="bg-white border border-black p-5 rounded-lg shadow-xl">
                <q-form
                    @submit.prevent="login"
                    :class="{
                        'w-[18.8rem] h-[17.9rem]': loandingLogin
                    }"
                >
                    <h1 class="text-xl ml-auto mr-auto border-b border-black w-max mb-4">Login</h1>

                    <q-input
                        filled
                        v-model="email"
                        label="E-mail"
                        class="mb-4"
                        color="primary"
                        :rules="[
                            val => !!val || 'O e-mail é obrigatório'
                        ]"
                    />

                    <q-input
                        filled
                        v-model="password"
                        label="Senha"
                        :type="showPassword ? 'text' : 'password'"
                        class="mb-4"
                        color="primary"
                        :rules="[
                            val => !!val || 'A senha é obrigatório'
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

                    <div v-if="!loandingLogin">
                        <q-btn
                            type="submit"
                            color="primary"
                            class="m-2 text-white" 
                            label="Entrar"

                        />

                        <router-link to="/forgot-password">
                            <q-btn
                                type="button"
                                color="primary"
                                class="btn-forgot m-2 text-white" 
                                label="Esqueceu sua senha?"
                            />
                        </router-link> 
                    </div>
                    
                    <div v-if="loandingLogin">
                        <span class="loader"></span>
                    </div>
                </q-form>
            </div>
        </div>
    </Transition>
</template>

<script setup lang="ts">
    import { api } from 'src/boot/axios';
    import { useQuasar, LocalStorage } from 'quasar';
    import { ref, onMounted, Transition } from "vue";
    import { useRouter } from 'vue-router'
    import dayjs from 'dayjs';

    const today = dayjs();
    const router = useRouter();
    const $q = useQuasar();

    let loandingLogin = ref<boolean>(false);
    const email = ref<string>('');
    const password = ref<string>('');
    const showPassword = ref<boolean>(false);
    const showContent = ref<boolean>(false);

    const login = async () => {
        const details = { email: email.value, password: password.value }
        loandingLogin.value = true;

        try {
            const res = await api.post("/auth/owner", details);
            console.log(res.data);

            if(res.data.success)
            {
                loandingLogin.value = false;
                LocalStorage.set("auth_token", res.data.token);
                LocalStorage.set("owner_name", res.data.user.name);
                LocalStorage.set("owner_cpf", res.data.user.cpf);

                LocalStorage.set("user_id", res.data.user.user_cod);
                LocalStorage.set("user_name", res.data.user.name);
                LocalStorage.set("uuse_id", res.data.uuse_id);

                const expire = today.add(8, 'hours');

                LocalStorage.set("expire", expire.toISOString());

                $q.notify({
                    color: 'green',
                    message: 'Login bem sucedido!',
                    position: 'top',
                    timeout: 2000
                    
                });

                router.push('/companies')

            } else {
                $q.notify({
                    color: 'red',
                    message: 'Erro no login',
                    position: 'top',
                    timeout: 2000
                })
            };
            
        } catch (error) {
            console.error('Erro no login: ', error);

        } finally {
            loandingLogin.value = false;

        };


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

    .loader {
        width: 12px;
        height: 12px;
        border-radius: 50%;
        display: block;
        margin:15px auto;
        position: relative;
        color: #000;
        box-sizing: border-box;
        animation: animloader 2s linear infinite;
    }

    @keyframes animloader {
        0% {
            box-shadow: 14px 0 0 -2px,  38px 0 0 -2px,  -14px 0 0 -2px,  -38px 0 0 -2px;
        }
        25% {
            box-shadow: 14px 0 0 -2px,  38px 0 0 -2px,  -14px 0 0 -2px,  -38px 0 0 2px;
        }
        50% {
            box-shadow: 14px 0 0 -2px,  38px 0 0 -2px,  -14px 0 0 2px,  -38px 0 0 -2px;
        }
        75% {
            box-shadow: 14px 0 0 2px,  38px 0 0 -2px,  -14px 0 0 -2px,  -38px 0 0 -2px;
        }
        100% {
            box-shadow: 14px 0 0 -2px,  38px 0 0 2px,  -14px 0 0 -2px,  -38px 0 0 -2px;
        }
    }

</style>