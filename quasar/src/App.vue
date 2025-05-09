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