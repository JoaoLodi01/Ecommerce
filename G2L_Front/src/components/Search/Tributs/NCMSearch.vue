<template>
    <div>
        <q-select 
            v-model="ncm" 
            :options="ncms" 
            label="NCM" 
            color="grey-7"
            class="m-2"
            :option-label="opt => `${opt.ncm} - ${opt.description}`"
            @update:model-value="selectNCM"

        />
    </div>
</template>

<script setup>
    import { LocalStorage } from 'quasar';
    import { api } from 'src/boot/axios';
    import { onMounted, ref, toRaw } from 'vue';
    
    let ncms = ref([])
    let searchedNCM = ref([]);
    let showNCMs = ref(false)
    let search_ = ref('')
    let ncm = ref(null)

    const issuer_id = LocalStorage.getItem("issuer_id");
    
    /*const searchNCM = async () => {
        console.log('ncm.value', ncm.value)
        search_.value = ncm.value
        console.log('search.value', search_.value)
        if(search_.value)
        {
            if(search_.value.length >= 2)
            {
                const response = await api.post(`ecommerce/tributs/search`, {
                    issuer_id: issuer_id,
                    search: search_.value

                });
                
            } 
            
            if(ncm.value.length >= 2) 
            {
                const response = await api.post(`ecommerce/tributs/search`, {
                    issuer_id: issuer_id,
                    search: search_.value

                });
                
            }   

            console.log(response.data.ncm)
            searchedNCM = response.data.ncm

        }        
    }*/

    const selectNCM = (item) => {
        emits('selected', toRaw(item))
        searchedNCM.value = []
        
        showNCMs.value = false
    
    }

    const showAllNCMs = () => {
        showNCMs.value = !showNCMs.value
        searchedNCM = []
        search_ = null
    }

    const getAllNCMs = async () => { 
        const response = await api.get(`ecommerce/tributs/all/${issuer_id}`)
        if(response.data.success)
        {
            ncms.value = response.data.all.data
            
        }
    }

    const emits = defineEmits([
        'selected'
    ])

    onMounted(() => {
        getAllNCMs()

    })
</script>

<style lang="scss">
    .view-ncms{
        width: 425vh;
    }
    
    .q-input {
        width: 92%;
    }

</style>