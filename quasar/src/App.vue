<template>
    <router-view/>
    
</template>

<script>
import { auth } from './api/auth';
export default{
    async mounted(){
        await auth()
    }
}
    
</script>