<template>
    <div class="flex ml-16">
        <div class="flex border border-black">
            <q-input 
                type="text" 
                v-model="search"
                @update:model-value="searchNCM"
                :disable="ncms.length <= 0"
            />

            <button
                class="p-2"
                @click="showAllNCMs()" 
                :disabled="ncms.length <= 0"
            >
                <svg v-if="!showNCMs" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="mt-auto mb-auto size-5">
                    <path stroke-linecap="round" stroke-linejoin="round" d="m19.5 8.25-7.5 7.5-7.5-7.5" />
                </svg>

                <svg v-if="showNCMs" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="mt-auto mb-auto size-5">
                    <path stroke-linecap="round" stroke-linejoin="round" d="m4.5 15.75 7.5-7.5 7.5 7.5" />
                </svg> 

            </button>
        </div>
        <div
            v-if="showNCMs"
        >
            <div v-if="searchedNCM.length <= 0">
                <ul v-for="ncm in ncms" class="bg-gray-600">
                    <li 
                    class="w-max text-white p-2 hover:bg-slate-400"
                    @click="selectNCM(ncm)"
                >
                        {{ ncm.ncm }} - {{ ncm.description }}
                    </li>
                    
                </ul>
            </div>
        </div>
        <div>
            <ul v-for="ncm in searchedNCM" class="bg-gray-600">
                <li
                    class="w-max text-white p-2 hover:bg-slate-400"
                    @click="selectNCM(ncm)"
                >
                    {{ ncm.ncm }} - {{ ncm.description }}
                </li>
            </ul>
        </div>
        
    </div>
</template>

<script setup>
    import { LocalStorage } from 'quasar';
    import { api } from 'src/boot/axios';
    import { onMounted, ref } from 'vue';
    
    let ncms = ref([])
    let searchedNCM = ref([]);
    let showNCMs = ref(false)
    let option = ref(null)
    let search = ref(null)
    const issuer_id = LocalStorage.getItem("issuer_id");
    
    const searchNCM = async () => {
        console.log(search.value.length)
        if(search.value.length >= 2)
        {
            const response = await api.post(`ecommerce/ncm/search`, {
                issuer_id: issuer_id,
                search: search.value
            });

            console.log(response.data.ncm)
            searchedNCM = response.data.ncm

        }        
    }

    const showAllNCMs = () => {
        showNCMs.value = !showNCMs.value
        searchedNCM = []
        search = null
    }

    const selectNCM = (ncm) => {
        option.value = ncm

    }

    const getAllNCMs = async () => { 
        const response = await api.get(`ecommerce/ncm/all/${issuer_id}`)
        if(response.data.success)
        {
            ncms.value = response.data.all.data
            
        }
    }

    onMounted(() => {
        getAllNCMs()

    })
</script>