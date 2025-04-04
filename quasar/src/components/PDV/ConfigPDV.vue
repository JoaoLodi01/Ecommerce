<template>
    <div
        class="ml-14"
    >
        <h1>Configuarações</h1>
        <q-form
            @submit="onSubmit"
            class="q-gutter-md"
        >

            <q-checkbox 
                left-label 
                v-model="nmFinaly" 
                :label="'Permitir venda sem emissão fiscal ( Nota Manual )'"
                label="Orange" 
            />

            <q-checkbox 
                left-label 
                v-model="saleNegativeorReset" 
                :label="'Permitir venda com estoque negativo ou zerado'"
                label="Orange" 
            />

            <q-select 
                v-model="model" 
                :options="searchOptions" 
                label="Busca" 
                filled 
            />
            
            <div>
                <q-btn label="Salvar" type="submit" color="primary"/>
                <q-btn label="Padrão" type="reset" color="primary" flat class="q-ml-sm" />
            </div>
        </q-form>
    </div>

</template>
<script>
    import { api } from 'src/boot/axios'

    export default {
        data()
        {
            return {
                model: null,
                nmFinaly: true,
                saleNegativeorReset: false,
                searchOptions: [
                    'Cód barras',
                    'Cód barras interno'
                ]
            }
        },

        methods: {
            async getConfig()
            {
                const response = await api.get('');
                
            },
        
            onSubmit()
            {
                console.log('model', this.model)
                console.log('orange', this.orange)
            }
        },
        
        mounted()
        {
            
        }
    }
</script>