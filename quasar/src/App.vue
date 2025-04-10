<template>
    <router-view/>
    
</template>

<script>
import { auth } from './api/auth';
export default{
    mounted(){
        console.log(auth)
    }
}
    
</script>