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
            :disable="disable"
            outlined
            dense
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
            speciesData: null,
        }
    },
  
    methods: {
        async selectSpecies() {
            try {
                const response = await api.get(`/species/all/${parseInt(LocalStorage.getItem("issuer_id"))}`)
                this.allSpecies = response.data.all
                    if (response.data.success) {
                        this.fillterSpecies()
                        console.log(response.data)
                    }
            } catch (error) {
                console.error('Erro ao carregar espécies:', error)
            }
        },

        fillterSpecies() {
            this.filteredSpecies = this.allSpecies.filter(v => {
                if (this.module_ === 'cash') return v.tipo_lancamento === 'Caixa';
                if (this.module_ === 'receive') return v.tipo_lancamento === 'Receber';
                return false;
            });
        },
    
        setSpecies(specie){
            this.speciesData = specie;
            this.$emit('selectSpecie', specie);
        },
    },

    props: {
      module_: {
        type: String,
        required: true
      },
      disable: {
        type: Boolean,
        default: false
      }
    },
  
    mounted() {
      this.selectSpecies()
    },

  }
  </script>
  