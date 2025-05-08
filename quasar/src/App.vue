<template>
    <div class="overflow-x-hidden">
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
    @media (max-width: 1366px)
    {
        body{
            overflow-x: auto;

        }
    }

</style>