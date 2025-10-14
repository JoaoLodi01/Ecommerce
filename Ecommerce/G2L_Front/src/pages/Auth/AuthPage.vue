<template>
    <div class="auth-page">
        <RegisterOwner
            v-if="!isLogin"
            @is-login="isLogin = $event"
            class="auth-card"
        />

        <Login
            v-if="isLogin"
            @is-login="isLogin = $event"
            class="auth-card"
        />

    </div>
</template>

<script setup lang="ts">
    import Login from './Login.vue';
    import RegisterOwner from './Register/RegisterOwner.vue';
    import { ref, onMounted } from 'vue';

    let isLogin = ref<boolean>(false);
    let witdhScreen = ref<number>(0);

    onMounted(() => {
        isLogin.value = true;
        witdhScreen.value = screen.width;
    });
</script>

<style lang="scss">
    .auth-page {
        min-height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 12px;
        background-color: #f7f7f8;
    }

    .auth-card {
        width: 100%;
        max-width: 420px;
    }

    @media (min-width: 768px) {
        .auth-card { max-width: 520px; }
    }

    @media (min-width: 1024px) {
        .auth-card { max-width: 640px; }
    }
</style>