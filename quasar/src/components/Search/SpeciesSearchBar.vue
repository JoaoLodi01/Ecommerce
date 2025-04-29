<template>
    <div class="container flex">
        <div class="">
            <q-input
                label="Espécie"
                v-model="speciesData.name"
                @click="setSpecie(speciesData)"
                @update:model-value="selectSpecies()"
                class="w-96"
                color="grey"
            />
        </div>
            <ul 
                v-if="filteredSpecies.length > 0 && speciesData.name !== '' "
                class="fixed z-50 p-3 bg-white border border-gray-300 mt-14">

                <li
                    v-for="specie in filteredSpecies"
                    :key="specie.id"
                    @click="setSpecie(specie)"
                    class="p-2 hover:bg-gray-200 cursor-pointer">

                    {{ specie.id }} - {{ specie.name }}

                </li>
            </ul>
    </div>
</template>
<script>
    import { LocalStorage } from 'quasar';
import { api } from 'src/boot/axios';

    export default{
        data(){
            return {
                filteredSpecies: [],
                speciesData:{
                    id: 0,
                    name: "",
                },
            }
        },

        methods: {
            async selectSpecies(){
                if(this.speciesData.name.length > 0) {
                    const response = await api.post(`/${LocalStorage.getItem("issuer_id")}`, {
                        search: this.speciesData.name
                    });

                    this.filteredSpecies = response.data;
                }
            },

            setSpecie(specie){
                this.speciesData.id = specie.id;
                this.speciesData.name = specie.name;
                this.$emit('update:selectSpecie', this.speciesData);
                this.filteredSpecies = [];
            },
        },
    }
</script>