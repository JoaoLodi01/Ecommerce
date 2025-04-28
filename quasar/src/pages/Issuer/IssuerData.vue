<template>
    <div class="ml-14">
        <h1>Empresa: {{ company_name }}</h1>
        <q-form
            @submit="completeIssuer"
            class="w-96"
        >    
            <div class="">
                <h3>Endereço</h3>
                <q-input 
                    v-model="form.cep"
                    @vue:updated="getCEPData()"
                    filled        
                    label="CEP" 
                    stack-label
                    class="mb-4"
                    color="grey"
                    v-bind:mask="'#####-###'"
                    maxlength="9"

                />   
                
                <q-input 
                    v-model="form.uf"
                    filled        
                    label="UF" 
                    stack-label
                    class="mb-4"
                    color="grey"
                    maxlength="2"

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
                
            </div>
                
            <div class="">
                <h3>Dados fiscáis</h3>
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
                    label="Regime tributário"
                    stack-label
                    class="mb-4"
                    color="grey" 
                    filled 
                />
            </div>
            
            <div>
                <q-btn label="Salvar" type="submit" color="grey"/>
                
            </div>
        </q-form>
        
    </div>
    
</template>

<script>
    import axios from 'axios';
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
                company_name: '',
                form: {
                    uf: '',
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
            async getIssuer()
            {

            },

            async completeIssuer()
            {
                const i = this.crtOptions.indexOf(this.form.cod_crt) + 1
                this.form.cod_crt = i

                const response = await api.put('issuer/complete-register', {
                    cep: this.form.cep.replace(/\D/g, ''),
                    uf: this.form.uf,
                    address: this.form.address,
                    number: this.form.number,
                    cod_cnae: this.form.cod_cnae,
                    cod_crt: this.form.cod_crt
                })
            },

            async getCEPData()
            {
                const cep = this.form.cep.replace(/\D/g, '')
                if(cep.length === 8)
                {
                    console.log('API_CEP:', process.env.API_CEP)
                    console.log(`${process.env.API_CEP}${cep}/json`)
                    const data = await axios.get(`${process.env.API_CEP}${cep}/json`)
                    console.log('Data:', data.data)
                    this.form.uf = data.data.uf
                    this.form.address = data.data.logradouro

                }
            }
        },

        mounted()
        {
            this.company_name = this.$route.params.name
        }
    }

</script>