<template>
    <div
        class="ml-14"
    >
        <div class="flex justify-between">
            <h1>Configurações</h1>
            <q-btn 
                label="Voltar"                 
                class="h-4 mt-auto mb-auto ml-5"

            />
            
            <q-form
                @submit="onSubmit"
                @reset="onReset"
                
            >
                <q-checkbox 
                    left-label 
                    v-model="configs.addressNull" 
                    label="Permitir endereço nulo"
                />

                <q-checkbox 
                    left-label 
                    v-model="configs.numberNull" 
                    label="Permitir número nulo"
                />

                <q-select 
                    v-model="configs.typeDefault" 
                    :options="optionsType" 
                    label="Tipo pessoa padrão" 
                    filled 
                    coler="grey"
                />
                
                <div>
                    <q-btn label="Salvar" type="submit" color="grey" :disable="configs.searchOptionProduct === null"/>
                    <q-btn label="Padrão" type="reset" color="black" flat class="q-ml-sm" />
                </div>
            </q-form>
        </div>
    </div>
</template>

<script>
    export default {
        setup()
        {
            return { 
                optionsType: [
                    'Fornecedor',
                    'Motorista'
                ]       

            }
            
        },
        
        data(){
            return {
                configs: {
                    addressNull: false,
                    numberNull: false,
                    typeDefault: 'Cliente'
                }
            }
        },

        methods: {

        }
    }

</script>