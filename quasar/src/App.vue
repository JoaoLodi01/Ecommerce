<template>
    <router-view/>
    <ErrorDialog ref="errorDialog" />
</template>

<script setup lang="ts">
    import ErrorDialog from 'src/components/Error/ErrorDialog.vue';
    import emitter from 'src/utils/eventBus';
    import { onMounted, onBeforeUnmount, ref } from 'vue';
    import { LocalStorage } from 'quasar';

    const errorDialog: any = ref(null);
    const expire: any = ref(LocalStorage.getItem("expire"));
    const token: any = ref(LocalStorage.getItem("auth_token"));
    const currentHour: any = ref(null);
    let intervalID: any = null

    const showGlobalError = (msg: string) => {
        errorDialog.value?.showError(msg);
        
    };

    const confirmExpireToken = async () => {
        console.log("Conferindo se está logado dentro de confirmExpireToken: \n")
        
        const currentDate = new Date()
        const formatter = new Intl.DateTimeFormat('pt-BR', {
            hour: '2-digit',
            minute: '2-digit',
            second: '2-digit',
            timeZone: 'America/Sao_Paulo'
            
        })
        
        currentHour.value = formatter.format(currentDate)

        // Resolver isso daqui
        // Se a currentHour = 22:00:00 pm e o expire = 10:00:00 am, vai dar expirado, mesmo que não seja maior
        if(currentHour.value >= expire.value)
        {
            console.log("logout");
            LocalStorage.remove('auth_token');
            LocalStorage.remove('expire');
            clearInterval(intervalID);
        }
    }

    onMounted(() => {
        if(token.value)
        {
            intervalID = setInterval(confirmExpireToken, 3000)
        }

        LocalStorage.removeItem("pdvID")
        emitter.on('global-error', showGlobalError);

    });

    onBeforeUnmount(() => {
        emitter.off('global-error', showGlobalError);
        if(intervalID)
        {
            clearInterval(intervalID);
        }
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