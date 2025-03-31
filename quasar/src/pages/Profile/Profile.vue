<template>
    <div
        class="w-max ml-14 rounded-lg mt-10" 
        id="pdv-view"
           
    >
        <h2>Perfil de: {{ userName }}</h2>
    </div>
</template>

<script>
    import { LocalStorage } from 'quasar';

    export default {
        data()
        {
            return {
                userName: LocalStorage.getItem("user_name")
            }
        }
    }

</script>