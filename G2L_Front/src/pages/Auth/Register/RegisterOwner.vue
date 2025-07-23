<template>
    <Transition name="slide-up">
        <div v-if="showContent" class="max-w-[28rem] bg-white rounded-md h-[36rem]">
            <div class="p-12">
                <h1 class="text-2xl ml-auto mr-autow-max text-center"><b>Bem vindo!</b></h1>
                <h3 class="text-xl ml-auto mr-autow-max text-center ">Faça aqui o seu registro!</h3>

                <q-form
                    @submit.prevent="createAccount"
                    class="p-5 mt-5"

                >
                    <div v-if="!firstData">
                        <q-input 
                            v-model="form.name"
                            label="Nome" 
                            color="primary"
                            maxlength="120"
                            outlined
                            :rules="[
                                val => !!val || 'Preencha seu nome!'
                            ]"
                        />
                    
                        <q-input 
                            v-model="form.surname"
                            label="Sobrenome"
                            color="primary"
                            maxlength="90"
                            outlined
                            :rules="[
                                val => !!val || 'Preencha seu sobre-nome!'

                            ]"

                        />
                    
                        <q-input 
                            v-model="form.email"
                            label="E-mail"
                            color="primary"
                            maxlength="90"
                            outlined
                            :rules="[
                                val => {
                                    if(!val) return 'Preencha seu E-mail!';
                                    return validateEmail(val) || 'E-mail inválido!';
                                }
                                        
                            ]"

                        />
                    
                        <q-input 
                            class="mb-4"
                            color="primary"
                            label="CPF" 
                            v-model="form.cpf"
                            v-bind:mask="'###.###.###-##'"
                            maxlength="14"
                            outlined
                            :rules="[
                                val => {
                                    if(!val) return 'Preencha seu CPF!';
                                    return validateCPF(val) || 'CPF Inválido!';
                                }
                                        
                            ]"

                        />
                    </div>

                    <Transition name="slide-top">
                        <div v-if="firstData" class="mt-10">
                            <q-input 
                                label="Senha"
                                class="mb-4"
                                color="primary"
                                v-model="form.password"
                                :type="showConfirmPassword1 ? 'text' : 'password'"
                                outlined
                                :rules="[
                                    val => val.length >= 8 || 'A senha precisa possuir 8 caracters',
                                    val => checkPassword(val)
                                ]"
                            >
                                <div 
                                    @click="showConfirmPassword1 = !showConfirmPassword1"    
                                >
                                    <PasswordIcon
                                        :show="showConfirmPassword1"
                                    />
                                </div>
                            </q-input>

                            <q-input 
                                label="Confirme sua senha"
                                class="mb-4"
                                color="primary"
                                v-model="form.password_"
                                :type="showConfirmPassword2 ? 'text' : 'password'"
                                outlined
                                :rules="[
                                    val => val.length >= 8 || 'A senha precisa possuir 8 caracters',
                                    val => checkPassword(val),
                                    val => checkEqualPassword(val)
                                ]"
                            >
                                <div 
                                    @click="showConfirmPassword2 = !showConfirmPassword2"
                                >
                                    <PasswordIcon
                                        :show="showConfirmPassword2"
                                    />
                                </div>
                            </q-input>

                        </div>
                    </Transition>

                    <div class="text-center mt-4 mb-2">
                        <q-btn 
                            :label="!firstData ? 'Continuar cadastro!' : 'Finalizar cadastro!'" 
                            :type="firstData ? 'submit' : 'button'" 
                            color="primary"
                            class="p-4 rounded-md w-72 mb-4"
                            outline 
                            unelevated 
                        />
                            <br>

                        <span class="text-center">
                            Já tem uma conta? 
                            <span 
                                class="text-blue-400 cursor-pointer"
                                @click="emits('isLogin', true)"
                            >
                                Faça login agora!
                            </span>
                        </span>
                    </div>
                </q-form>
            </div>
        </div>
    </Transition>

    <LoandingPage
        v-if="showLoanding"
        :text="'Criando usuário!'"
    />
</template>

<script setup lang="ts">
    import { LocalStorage, useQuasar } from 'quasar';
    import { api } from 'src/boot/axios';
    import { watch, onMounted, ref } from 'vue';
    import { useRouter } from 'vue-router';
    import validateCPF from 'src/utils/validateCPF';
    import PasswordIcon from 'src/components/Icons/PasswordIcon.vue';
    import LoandingPage from 'src/components/Loanding/LoandingPage.vue';
    import dayjs from 'dayjs';

    interface IOwnerData
    {
        name: string,
        surname: string,
        cpf: string,
        email: string,
        password: string,
        password_: string
    };

    const emits = defineEmits<{
        (e: 'isLogin', value: boolean)
    }>();

    const $q = useQuasar();
    const router = useRouter();
    const today = dayjs();
    
    const form = ref<IOwnerData>({
        name: '',
        surname: '',
        cpf: '',
        email: '',
        password: '',
        password_: ''
        
    });
    
    let showContent = ref<boolean>(false);
    let firstData = ref<boolean>(false);
    let showConfirmPassword1 = ref<boolean>(false);
    let showConfirmPassword2 = ref<boolean>(false);
    
    let showLoanding = ref<boolean>(false);

    watch(form.value, (_) => {
        const data = form.value;

        if(
            data.name &&
            data.surname &&
            data.email &&
            (data.cpf && data.cpf.length === 14)
        ) {
            firstData.value = true;
        };
    });

    function validateEmail(email: string): boolean
    {
        if(email.split('').includes('@'))
        {
            return true;
            
        } else {
            return false;
        };
    };

    const createAccount = async () =>
    {
        showLoanding.value = true;
        const res = await api.post('/registers/owner/create', {
            name: form.value.name,
            surname: form.value.surname,
            cpf: form.value.cpf.replace(/\D/g, ''),
            email: form.value.email.toLowerCase(),
            password: form.value.password
            
        });

        const data = res.data;
        
        try {
            if(data.success)
            {
                $q.notify({
                    color: 'green',
                    message: res.data.message,
                    timeout: 1200,
                    position: 'top'
                
                });

                // 'Login'
                const details = { email: data.data.email, password: form.value.password };
                
                const login = await api.post("/auth/owner", details);
              
                if(login.data.success)
                {
                    console.log()
                    LocalStorage.set("auth_token", login.data.token);
                    LocalStorage.set("owner_name", login.data.user.name);
                    LocalStorage.set("owner_cpf", login.data.user.cpf);

                    LocalStorage.set("user_id", login.data.user.user_code);
                    LocalStorage.set("user_name", login.data.user.name);
                    LocalStorage.set("uuse_id", login.data.uuse_id);
                    
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
            } 
            
        } catch (error) {
            console.error('Erro na criação ou login: ', error)
            $q.notify({
                color: 'red',
                message: error.response ?? error.response.message,
                timeout: 1200,
                position: 'top'
            
            });
            showLoanding.value = false;
            
        } finally {
            showLoanding.value = false;

        };
    };

    const checkPassword = (password: string): boolean|string =>
    {
        const specialChars = '`!@#$^&;:?~';
        const hasSpecial = password.split('').some(char => specialChars.includes(char));
        return hasSpecial ? true : 'A senha precisa ter 1 caracter especial';

    };

    const checkEqualPassword = (confirmPassword: string): boolean|string =>
    {
        const password = form.value.password
        const isEqual = confirmPassword === password ? true : 'As senhas devem ser iguais!';
        return isEqual;

    }

    onMounted(() => {
        firstData.value = false;
        form.value.password = '',
        form.value.password_ = '',
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
    
    .slide-top-enter-from {
        opacity: 0;
        transform: translateY(-50px);

    }

    .slide-top-enter-to {
        opacity: 1;
        transform: translateY(0);
        
    }

    .slide-top-enter-active {
        transition: all 0.5s ease-out;
    }

    @media(min-width: 1366px)
    {
        .form-container{
            width: 60vh;
         
        }

    }
</style>