<template>
    <router-view/>
    <ErrorDialog ref="errorDialog" />
</template>

<script setup lang="ts">
    import ErrorDialog from 'src/components/Error/ErrorDialog.vue';
    import emitter from 'src/utils/eventBus';
    import { onMounted, ref, onBeforeUnmount } from 'vue';
    import { LocalStorage } from 'quasar';
    import { api } from './boot/axios';

    const errorDialog = ref(null);
    const expire = ref(LocalStorage.getItem("expire"))
    const token = ref(LocalStorage.getItem("auth_token"))
    const hour = ref(null)
    let intervalID

    const showGlobalError = (msg: string) => {
        errorDialog.value?.showError(msg);
        
    };

    const confirmExpireToken = () => {
        const currentDate = new Date()
        const formatter = new Intl.DateTimeFormat('pt-BR', {
            hour: '2-digit',
            minute: '2-digit',
            second: '2-digit',
            timeZone: 'America/Sao_Paulo'

        })
        
        hour.value = formatter.format(currentDate)
        if(hour.value >= expire.value)
        {   
            LocalStorage.removeItem("auth_token");
            LocalStorage.removeItem("expire");
            console.log('O tempo expirou faça login novamente!')

            const res = api.get('auth/me', {
                headers: {
                    Authorization: `Bearer ${token.value}`
                }
            })
            console.log('Res: ', res.data)
            clearInterval(intervalID)

        } else {
            console.log('O tempo ainda não expirou, não precisa fazer login novamente!')

        }
    }

    onMounted(() => {
        console.log('Expire: ', expire.value)
        console.log('Token: ', token.value)
        if(token.value && expire.value)
        {
            console.log('Tem expire e token')
            intervalID = setInterval(confirmExpireToken, 3000);               
        }
        
        LocalStorage.removeItem("pdvID")
        emitter.on('global-error', showGlobalError);

    });

    onBeforeUnmount(() => {
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