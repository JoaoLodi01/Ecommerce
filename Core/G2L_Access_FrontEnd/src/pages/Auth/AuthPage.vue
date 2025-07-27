<template>
    <div class="bg-white rounded-md h-[36rem] flex justify-center">
        <div class="p-12 max-w-[28rem] border mt-auto mb-auto">
            <h1 class="text-xl ml-auto mr-autow-max text-center">Login</h1>
            
            <q-form
                @submit.prevent="login"
                class="p-5 mt-5"
            >
                <div>
                    <q-input 
                        v-model="loginForm.email" 
                        type="text" 
                        label="E-mail" 
                        outlined
                        class="mb-5"
                        :rules="[
                            val => !!val || 'Campo necessário!'
                        ]"
                    />
                </div>
                
                <div>
                    <q-input 
                        v-model="loginForm.password" 
                        type="password" 
                        label="Senha" 
                        outlined
                        class="mb-3"
                        :rules="[
                            val => !!val || 'Campo necessário!'
                        ]"
                    />
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

                </div>
            </q-form>                
        </div>
    </div>
</template>

<script setup lang="ts">
    import { useQuasar, LocalStorage } from 'quasar';
    import { api } from 'src/boot/axios';
    import { ref } from 'vue';
    import { useRouter } from 'vue-router';

    const $q = useQuasar();
    const router = useRouter();

    const loginForm = ref<ILogin>({
        email: '',
        password: '',
    });

    const login = async () =>
    {
        const res = await api.post('/access/auth/login', loginForm.value, {
            headers: {
                Accept: 'application/json'
            }
        });

        const data = res.data;

        console.log(res.data.data);

        if(data.success)
        {
            LocalStorage.set("authToken", data.data.token);
            LocalStorage.set("user", data.data.user.name);

            $q.notify({
                color: 'green',
                message: 'Login bem sucedido!',
                position: 'top',
                timeout: 2000
            });

            router.push('/home/')
        };
    };
</script>
