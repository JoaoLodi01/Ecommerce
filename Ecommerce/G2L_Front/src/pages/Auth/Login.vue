<template>
    <Transition name="slide-up">
        <div v-if="showContent" class="max-w-[28rem] bg-white rounded-md h-[36rem]">
            <div class="p-12">
                <h1 class="text-2xl ml-auto mr-autow-max text-center"><b>Bem vindo de volta!</b></h1>
                <h1 class="text-xl ml-auto mr-autow-max text-center">Login</h1>
                
                <q-form
                    @submit.prevent="login"
                    class="p-5 mt-5"
                >
                    <div>
                        <q-input 
                            v-model="email" 
                            type="text" 
                            label="E-mail" 
                            outlined
                            class="mb-5"
                            :rules="[
                                val => !!val || 'O e-mail necessário!'
                            ]"
                        />
                    </div>
                    
                    <div>
                        <q-input 
                            v-model="password" 
                            :type="showConfirmPassword ? 'text' : 'password'"
                            label="Senha" 
                            outlined
                            class="mb-3"
                            :rules="[
                                val => !!val || 'A senha é necessária!'
                            ]"

                        >
                            <div 
                                @click="showConfirmPassword = !showConfirmPassword"
                            >
                                <PasswordIcon
                                    :show="showConfirmPassword"
                                />
                            </div>

                        </q-input>
                        <span class="text-xs flex justify-end cursor-pointer">
                            Esqueceu sua senha?
                        </span>
                    </div>

                    <div class="text-center mt-4 mb-2">
                        <q-btn 
                            label="Entrar!" 
                            type="submit" 
                            color="primary"
                            class="p-4 rounded-md w-72 mb-4"
                            outline 
                            unelevated 
                        />

                        <span class="text-center">
                            Não tem uma conta?
                            <span 
                                class="text-blue-400 cursor-pointer"
                                @click="emits('isLogin', false)"
                            >
                                Se registre agora!
                            </span>
                        </span>
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
    import PasswordIcon from 'src/components/Icons/PasswordIcon.vue';
    import dayjs from 'dayjs';

    const emits = defineEmits<{
        (e: 'isLogin', value: boolean)
    }>();

    const today = dayjs();
    const router = useRouter();
    const $q = useQuasar();
    const email = ref<string>('');
    const password = ref<string>('');
    const showContent = ref<boolean>(false);
    let showConfirmPassword = ref<boolean>(false);
    let loandingLogin = ref<boolean>(false);

    const login = async () => {
        const details = { email: email.value, password: password.value }
        loandingLogin.value = true;
        
        $q.notify({
            color: 'green',
            message: 'Validando dados ...',
            position: 'top',
            timeout: 2000
            
        });

        try {
            const res = await api.post("/auth/owner", details, {
                headers: {
                    Accept: 'application/json'
                }
            });
            console.log(res.data);

            if(res.data.success)
            {
                loandingLogin.value = false;
                LocalStorage.set("auth_token", res.data.token);
                LocalStorage.set("owner_name", res.data.user.name);
                LocalStorage.set("owner_cpf", res.data.user.cpf);
                
                LocalStorage.set("user_id", res.data.user.user_code);
                LocalStorage.set("user_name", res.data.user.name);
                LocalStorage.set("uuse_id", res.data.uuse_id);
                LocalStorage.set("call_color", true);

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
            loandingLogin.value = false;

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