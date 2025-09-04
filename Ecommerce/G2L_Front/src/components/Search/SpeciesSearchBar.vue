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

<script lang="ts">
    import { LocalStorage } from 'quasar'
    import { api } from 'src/boot/axios'
    import { onMounted, ref } from 'vue';

    interface ISpecieField {
        id: number,
        name: string

    };

    const issuerID = ref<number>(LocalStorage.getItem("issuer_id"));

    let speciesData = ref<ISpecieField>({
        id: 0,
        name: 'Selecionar..'
        
    });
    
    let filteredSpecies = ref<ISpecieField[]>([]);
    let allSpecies = ref<ISpecieField[]>([]);

    const selectSpecies = async () =>{ 
        const res = await api.get(`/species/all/${issuerID}`);
        console.log('Aqui:', res.data);

    };

    onMounted(() => {
        selectSpecies();
    });
</script>

  
<!--script>  
    export default {
    data() {
        return {
        
        }
    },
  
    methods: {
        async selectSpecies() {
            try {
                const response = await 
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
</script-->
  