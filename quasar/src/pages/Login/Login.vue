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
                >
                    <h1 class="text-xl ml-auto mr-auto border-b border-black w-max mb-4">Login</h1>

                    <q-input
                        filled
                        v-model="email"
                        label="E-mail"
                        class="mb-4"
                        color="grey-7"
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
                        color="grey-7"
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
                            class="size-4 mt-5 text-gray-600 cursor-pointer"
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
                            class="size-4 mt-5 text-gray-600 cursor-pointer"
                            v-if="!showPassword"
                        >
                            <path stroke-linecap="round" stroke-linejoin="round" d="M3.98 8.223A10.477 10.477 0 0 0 1.934 12C3.226 16.338 7.244 19.5 12 19.5c.993 0 1.953-.138 2.863-.395M6.228 6.228A10.451 10.451 0 0 1 12 4.5c4.756 0 8.773 3.162 10.065 7.498a10.522 10.522 0 0 1-4.293 5.774M6.228 6.228 3 3m3.228 3.228 3.65 3.65m7.894 7.894L21 21m-3.228-3.228-3.65-3.65m0 0a3 3 0 1 0-4.243-4.243m4.242 4.242L9.88 9.88" />
                        </svg>
                    </q-input>

                    <div class="">
                        <q-btn
                            type="submit"
                            class="m-2"
                            color="grey" 
                            label="Entrar"

                        />

                        <router-link to="/forgot-password">
                            <q-btn
                                type="button"
                                color="grey" 
                                class="btn-forgot"
                                label="Esqueceu sua senha?"
                            />
                        </router-link> 

                    </div>
                </q-form>
            </div>
        </div>
    </Transition>
</template>

<script setup lang="ts">
    import { api } from "src/boot/axios"
    import { useQuasar, LocalStorage } from 'quasar';
    import { ref, onMounted, Transition } from "vue";
    import { useRouter } from 'vue-router'

    const router = useRouter();
    const $q = useQuasar();

    const email: any = ref(null);
    const password: any = ref(null);
    const showPassword: any = ref(false);
    const showContent: any = ref(false);

    const showLoading = () => {
        $q.loading.show({
            message: 'Efetuando login ...'
        })
    }

    const hideLoading = () => {
        $q.loading.hide();
    }

    const login = async () => {
        showLoading
        const details = { email: email.value, password: password.value }

        try {
            const res = await api.post("/auth/owner", details)
            console.log('Res: ', res.data);
            if(res.data.success)
            {
                LocalStorage.set("auth_token", res.data.token);
                LocalStorage.set("owner_name", res.data.owner.name)
                LocalStorage.set("owner_cpf", res.data.owner.cpf)
                LocalStorage.set("user_id", res.data.user.user_cod)
                LocalStorage.set("user_name", res.data.user.name)
                LocalStorage.set("uuse_id", res.data.uuse_id)
                router.push('/companies')
            }
            
        } catch (error) {
            console.error('Erro no login: ', error)
        } finally {
            hideLoading
        }

    }

    onMounted(() => {
        showContent.value = true
    })

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

</style>