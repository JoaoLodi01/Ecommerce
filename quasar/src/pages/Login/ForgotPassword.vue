<template>
    <div class="Register-form">

    </div>
</template>

<script>
    import { useQuasar } from 'quasar'
    import { onBeforeUnmount } from 'vue'
    import { api } from 'src/boot/axios'

    export default {
        setup()
        {
            const $q = useQuasar()
            let timer

            onBeforeUnmount(() => {
                if(timer !== void 0)
                {
                    clearTimeout(timer)
                    $q.loading.hide
                }
            })

            return {
                showLoading () {
                    $q.loading.show({
                        message: 'Criando sua conta ...'
                    })

                    timer = setTimeout(() => {
                        $q.loading.hide()
                        timer = void 0

                    }, 2000)
                }
            }
        },

        data()
        {
            return {
                userDetail: {
                    email: '',

                },
                messages: []
            }
        },

        methods: {
            async emitForgotPassword(){
                this.messages = []

                const response = await api.get('http://192.168.1.100:8000/forgot-password');

                console.log(response)

            },
        },

        mounted()
        {
            this.emitForgotPassword
        }
    }

</script>
