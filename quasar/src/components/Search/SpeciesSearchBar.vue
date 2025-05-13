<template>
  <div class="container flex">
    <q-select
      v-model="speciesData"
      :options="[{ id: null, especie: 'Escolher...' }, ...filteredSpecies]"
      option-label="especie"
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
      async loadSpecies() {
        try {
          const response = await api.get(`payments/all/${LocalStorage.getItem('issuer_id')}`)
          this.filteredSpecies = response.data

        } catch (error) {
          console.error('Erro ao carregar espécies:', error)
        }
      },

      speciesData(newVal) {
        this.$emit('update:selectSpecie', newVal)
      },
      
    },
  
    mounted() {
      this.loadSpecies()
    },
  }
  </script>
  