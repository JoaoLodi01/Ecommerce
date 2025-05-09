<template>
    <div class="">
        <router-view/>

    </div>
    
</template>

<script>
import { auth } from './api/auth';
export default{
    async mounted(){
        await auth()
    }
}
    
</script>

<style lang="scss">
    @media (min-width: 1366px)
    {
        body{
            overflow-x: hidden;

        }
    }

</style>