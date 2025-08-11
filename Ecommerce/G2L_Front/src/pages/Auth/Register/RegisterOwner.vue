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
                            @update:model-value="handleCPF"
                            :rules="[
                                val => {
                                    if(!val) return 'Preencha seu CPF!';
                                    return validateCPF(val) || 'CPF Inválido!';
                                }        
                            ]"

                        />
                    </div>

                    <Transition name="slide-top">
                        <div v-if="firstData">
                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-5 mb-4 cursor-pointer" @click="firstData = !firstData ">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M9 15 3 9m0 0 6-6M3 9h12a6 6 0 0 1 0 12h-3" />
                            </svg>

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
                            v-if="!firstData"
                            label="Continuar cadastro!" 
                            type="button" 
                            color="primary"
                            class="p-4 rounded-md w-72 mb-4"
                            outline 
                            unelevated
                            @click.prevent="validateCPF(form.cpf) ? firstData = !firstData : notifyCPF()"

                        />

                        <q-btn 
                            v-if="firstData"
                            label="Finalizar cadastro!" 
                            type="submit" 
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
    import { ref, onMounted } from 'vue';
    import { useRouter } from 'vue-router';
    import validateCPF from 'src/utils/validateCPF';
    import PasswordIcon from 'src/components/Icons/PasswordIcon.vue';
    import LoandingPage from 'src/components/Loanding/LoandingPage.vue';
    import dayjs from 'dayjs';
    import { createCustomerInAccess } from 'src/services/Access/AccessAdminService';
    import checks from 'src/services/Exists/checkExists' 

    interface IOwnerData
    {
        name: string,
        surname: string,
        cpf: string,
        email: string,
        password: string,
        password_: string
    };

    type TaccessReturn = {
        status: boolean,
        message: string

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

    function formateCPF(cpf: string): string
    {
        return cpf.replace(/\D/g, '');    
    };
    
    function validateEmail(email: string): boolean
    {
        if(email.split('').includes('@') && email.split('@')[1].length >= 4)
        {
            return true;
            
        } else {
            return false;
        };
    };

    const createAccount = async () =>
    {
        showLoanding.value = true;

        try {
            //http://192.168.1.105:8080/api/v1/access/customers/create
            //http://192.168.1.105:8080/api/v1/access/customers/create
            
            const customerData: ICustomerData = {
                fullName: form.value.name + ' ' + form.value.surname,
                email: form.value.email,
                cpf: form.value.cpf
            };

            const createAccess: TaccessReturn = await createCustomerInAccess(customerData);

            if(createAccess.status)
            {
                const res = await api.post('/registers/owner/create', {
                    name: form.value.name,
                    surname: form.value.surname,
                    cpf: form.value.cpf.replace(/\D/g, ''),
                    email: form.value.email.toLowerCase(),
                    password: form.value.password
                    
                });

                const data = res.data;
                
                if(data.success)
                {
                    // 'Login'
                    const details = { email: data.data.email, password: form.value.password };
                    
                    const login = await api.post("/auth/owner", details);
                
                    if(login.data.success)
                    {
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
                };
            } else {
                $q.notify({
                    color: 'red',
                    message: createAccess.message,
                    position: 'top',
                    timeout: 2000
                });
            };
            
        } catch (error) {
            console.error('Erro na criação ou login: ', error);
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

    };

    const notifyCPF = () =>
    {
        $q.notify({
            color: 'red',
            message: 'O campo do CPF está ausente ou inválido!',
            position: 'top',
            timeout: 1800
        });
    };  

    const handleCPF = async (cpf: string) =>
    {
        const existis = await checks.checkExistsCPF(cpf);
        const formatedCPF = formateCPF(cpf);

        if(formatedCPF.length === 11) 
        {
            if(!existis)
            {
                firstData.value = false;
                $q.notify({
                    color: 'red',
                    message: 'CPF já cadastrado!',
                    position: 'top',
                    timeout: 1800
                });

                form.value.cpf = '';
                form.value.name = '';
                form.value.surname = '';
                form.value.email = '';
                
            } else {
                return;
                
            };
        };
    };

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