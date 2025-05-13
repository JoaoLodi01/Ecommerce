<template>
    <div class="container flex">
      <q-select
        v-model="speciesData"
        :options="filteredSpecies"
        option-label="especie"
        option-value="id"
        label="Espécie"
        :emit-value="false"
        map-options
        class="w-96"
        color="grey"
      />
    </div>
  </template>
  
  <script>
  import { LocalStorage } from 'quasar'
  import { api } from 'src/boot/axios'
  
  export default {
    data() {
      return {
        filteredSpecies: [],
        speciesData: { 
          id: null,
          especie: 'Escolher...'
        },
      }
    },
  
    methods: {
      async selectSpecies() {
        console.log(this.speciesData.especie)
        try {
          const response = await api.get(`payments/all/${LocalStorage.getItem('issuer_id')}`)
          this.filteredSpecies = response.data

        } catch (error) {
          console.error('Erro ao carregar espécies:', error)
        }
      },
  
      setSpecies(specie){
        this.speciesData.id = specie.id;
        this.speciesData.especie = specie.especie;
        this.$emit('update:selectSpecie', this.speciesData)
      },

    },
  
    mounted() {
      this.selectSpecies()
    },

  }
  </script>
  