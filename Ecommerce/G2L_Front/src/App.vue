<template>
    <router-view/>
    <ErrorDialog ref="errorDialog" />
</template>

<script setup lang="ts">
    import ErrorDialog from 'src/components/Error/ErrorDialog.vue';
    import emitter from 'src/utils/eventBus';
    import { onMounted, onBeforeUnmount, ref } from 'vue';
    import { useRouter } from 'vue-router';
    import { LocalStorage, useQuasar } from 'quasar';
    import dayjs from 'dayjs';
    import getColors from './services/getColors';

    const $q = useQuasar();
    const router = useRouter();
    const errorDialog = ref(null);
    const intervalID = ref<ReturnType<typeof setInterval> | null>(null);
    
    const showGlobalError = (msg: string) => 
    {
        errorDialog.value?.showError(msg);
        
    };
    
    const checkLogin = () =>
    {
        const now = dayjs();
        const expireStr = LocalStorage.getItem("expire");

        if(expireStr && typeof expireStr === 'string')
        {
            const expireDate = dayjs(expireStr);
            if(now.isAfter(expireDate))
            {
                $q.notify({
                    color: 'yellow-7',
                    message: 'Sessão expirada!',
                    position: 'top'

                });

                LocalStorage.remove("auth_token");
                LocalStorage.remove("expire");
                router.push('/');
                
            } 
        };
    };

   onMounted(() => {
        LocalStorage.removeItem("pdvID")
        emitter.on('global-error', showGlobalError);

        checkLogin();

        setInterval(checkLogin, 30 * 1000);

        if(LocalStorage.getItem("auth_token") && LocalStorage.getItem("call_color"))
        {
            console.warn('Vai chamar o get colors');

            intervalID.value = setInterval(() => getColors(LocalStorage.getItem("issuer_id")), 40 * 100); 
            
        } else {
            clearInterval(intervalID.value);
            return;
            
        };
    });

    onBeforeUnmount(() => {
        if(intervalID.value)
        {
            clearInterval(intervalID.value);
            console.log('Vai parar de chamar o getColors');
        }

        emitter.off('global-error', showGlobalError);
    });
</script>


<style lang="scss">
    @media (min-width: 1366px)
    {
        body{
            overflow-x: hidden;

        }
    }

    html {
        background-color: rgb(229 231 235);
    }

</style>