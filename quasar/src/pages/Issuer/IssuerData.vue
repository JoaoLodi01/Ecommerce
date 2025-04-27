<template>
    <q-form
        @submit="onSubmit"
        @reset="onReset"
        class="q-gutter-md"
    >    
        <q-input 
            v-model="form.cep"
            filled        
            label="CEP" 
            stack-label
            class="mb-4"
            color="grey"
            v-bind:mask="'#####-###'"
            maxlength="9"

        />   
            
        <q-input 
            filled        
            label="Endereço" 
            v-model="form.address"
            stack-label
            class="mb-4"
            color="grey"
            maxlength="100"

        />        
            
        <q-input 
            filled        
            label="Número" 
            v-model="form.number"
            stack-label
            class="mb-4"
            color="grey"
            maxlength="10"

        />   
        <q-input 
            filled        
            label="Cód. CNAE" 
            v-model="form.cod_cnae"
            stack-label
            class="mb-4"
            color="grey"
            maxlength="10"

        />  

        <q-input 
            filled        
            label="CNAE" 
            v-model="form.cnae"
            stack-label
            class="mb-4"
            color="grey"
            maxlength="10"

        />  

        <q-select
            v-model="form.cod_crt" 
            :options="crtOptions" 
            label="Regime"
            stack-label
            class="mb-4"
            color="grey" 
            filled 
        />


        
        <div>
            <q-btn label="Submit" type="submit" color="primary"/>
            <q-btn label="Reset" type="reset" color="primary" flat class="q-ml-sm" />
        </div>
    </q-form>
    
</template>

<script>
    import { LocalStorage } from 'quasar';

    export default {
        setup()
        {
            return {
                crtOptions: [
                    'Simples Nacional',
                    'Lucro real',
                    'Lucro presumido',
                    'Simples - excesso de receita',
                    'MEI'
          
                ]   
            }
        },

        data()
        {
            return {
                form: {
                    address: '',
                    number: '',
                    cep: '',
                    email: '',
                    phone: '',
                    cod_crt: '',
                    cod_cnae: '',
                    cnae: ''
                    
                }
            }
        },

        methods: {
            async completeIssuer()
            {
                const i = this.crtOptions.indexOf(this.form.cod_crt) + 1
                this.form.cod_crt = i
            }
        }
    }

</script>