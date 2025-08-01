<template>
    <div 
        :class="{
            'max-w-[500vh] relative top-10 ml-auto mr-auto bg-indigo-500 rounded-md w-max': witdhScreen >= 1680,
            
        }"
    >
        <div 
            :class="{
                'p-12 flex': witdhScreen > 1366,
                
            }"

        >
            <img 
                class="rounded"
                :class="{
                    'w-[1034px]': witdhScreen >= 2560,
                    'w-[860px]': witdhScreen >= 1920,
                    'w-[650px]': witdhScreen < 1920
                }"
                
                src="public/image/background_3.jpg"
                v-if="witdhScreen > 1440"
                :height="witdhScreen > 1366 ? '1024px' : '520px'"

            >
                
            <div class="ml-24">
                <RegisterOwner
                    v-if="!isLogin"
                    @is-login="isLogin = $event"

                />

                <Login
                    v-if="isLogin"
                    @is-login="isLogin = $event"
                />

            </div>
        </div>
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
