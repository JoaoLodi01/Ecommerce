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
        @update:model-value="setSpecies"

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
        allSpecies: [],
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
            const response = await api.get(`/species/all/${parseInt(LocalStorage.getItem("issuer_id"))}`)
            this.allSpecies = response.data.all
            if(response.data.success)
            {
                this.fillterSpecies()
            }
        } catch (error) {
          console.error('Erro ao carregar espécies:', error)
        }
      },

      fillterSpecies()
      {
        switch (this.module_) {
          case 'cash':
            this.allSpecies.forEach((v, _) => {
                if(v.tipo_lancamento === 'Caixa')
                {
                    this.filteredSpecies.push(v)

                }

            })

            break;
        
          default:
            break;
        }
      },
  
      setSpecies(specie){
        this.speciesData.id = specie.id;
        this.speciesData.especie = specie.especie;
        this.$emit('selectSpecie', this.speciesData)
      },

    },

    props: {
      module_: {
        type: String,
        required: true
      }
    },
  
    mounted() {
      this.selectSpecies()
    },

  }
  </script>
  