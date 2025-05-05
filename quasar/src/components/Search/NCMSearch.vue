<template>
    <div class="ml-16">
        <h1>NCMSSSS</h1>
        {{ ncms }}
        <div class="" v-for="ncm in ncms">

            NCM: {{ ncm.ncm }}
            Descrição: {{ ncm.description }}
            {{ ncm }}

        </div>
    </div>
</template>

<script setup>
    import { LocalStorage } from 'quasar';
    import { api } from 'src/boot/axios';
    import { ref } from 'vue';
    
    let ncms = ref([])
    const issuer_id = LocalStorage.getItem("issuer_id");

    const getAllNCMs = async () => { 
        const response = await api.get(`ecommerce/all/ncms/${issuer_id}`)
        console.log(response.data.all.data)

        if(response.data.success)
        {
            ncms = response.data.all.data
            
        }
    }
    getAllNCMs()

</script>