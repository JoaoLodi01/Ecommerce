<template>
    {{ reqR }}
</template>
<script setup lang="ts">
    import axios from 'axios';
    import { onMounted, ref } from 'vue';
    
    let reqR = ref<any>();

    const req = async () => 
    {
        const res = await axios.get('http://192.168.1.103:8000/api/exception', {
            headers: {
                Accept: 'application/json'
            }
        });
        reqR.value = res;
        console.log(reqR.value);
    }

    onMounted(() => {
        req()
    })
</script>