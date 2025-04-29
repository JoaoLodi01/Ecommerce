<template>
    <div class="ml-14 mt-10 p-5">
        <q-form
            @submit="completeIssuer()"
            
        >
            <div class="bg-white p-5 rounded-lg mb-5">
                <h3 class="border-b mb-3">Dados da empresa</h3>
                <div class="flex">
                    <q-input 
                        class="w-max"
                        label="CNPJ"
                        v-model="form.cnpj" 
                        type="text" 
                        disable
                        
                    />

                    <q-input  
                        class="w-max text-base ml-5"
                        label="Razão social:"
                        v-model="form.company_name"
                    />

                    <q-input  
                        class="w-max text-base ml-5"
                        label="Nome fantasia:"
                        v-model="form.trade_name"
                    />

                    <q-input 
                        class="w-max ml-5"
                        label="Fundação"
                        v-model="form.date_of_foundation" 
                        type="date" 
                               
                    />
                    
                </div>
            </div>
            
            <div class="mr-5 bg-white p-5 rounded-lg mb-5">
                <h3 class="border-b mb-5">Endereço</h3>
                <div class="flex">
                    <q-input 
                        v-model="form.cep"
                        @vue:updated="getCEPData()"
                        filled        
                        label="CEP" 
                        class="mb-4"
                        color="grey"
                        v-bind:mask="'#####-###'"
                        maxlength="9"
    
                    />   
                    
                    <q-input 
                        v-model="form.uf"
                        filled        
                        label="UF" 
                        class="mb-4 ml-2 mr-2"
                        color="grey"
                        maxlength="2"
    
                    />   
    
                    <q-input 
                        filled        
                        label="Endereço" 
                        v-model="form.address"                        
                        class="mb-4 ml-2 mr-2"
                        color="grey"
                        maxlength="100"
    
                    />        
                        
                    <q-input 
                        filled        
                        label="Número" 
                        v-model="form.number"
                        
                        class="mb-4"
                        color="grey"
                        maxlength="10"
    
                    />

                </div>
            </div>
                
            <div class="bg-white p-5 rounded-lg mb-5">
                <h3 class="border-b mb-5">Dados fiscáis</h3>
                <q-input 
                    filled        
                    label="Cód. CNAE" 
                    v-model="form.cod_cnae"
                    
                    class="mb-4"
                    color="grey"
                    maxlength="10"

                />  

                <q-input 
                    filled        
                    label="CNAE" 
                    v-model="form.cnae"
                    
                    class="mb-4"
                    color="grey"
                    maxlength="10"

                />  
                
                <q-input 
                    filled        
                    label="IE" 
                    v-model="form.ie"
                    
                    class="mb-4"
                    color="grey"
                    maxlength="14"

                />  

                <q-input 
                    filled        
                    label="IM" 
                    v-model="form.im"
                    class="mb-4"
                    color="grey"
                    maxlength="12"

                />  


                <q-select
                    :options="crtOptions"
                    v-model="form.crt"
                    label="CRT ( Cód. Regime tributário )"
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
    import { api } from 'src/boot/axios';
    import { LocalStorage } from 'quasar';
    import axios from 'axios';

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
                    company_name: '',
                    trade_name: '',
                    date_of_foundation: null,
                    cnpj: '',
                    cep: '',
                    uf: '',
                    address: '',
                    number: '',
                    cod_crt: '',
                    crt: '',
                    cod_cnae: '',
                    cnae: '',
                    ie: '',
                    im: ''
                    
                }
            }
        },

        methods: {
            async getIssuer()
            {
                const response = await api.get(`/issuer/companie/${LocalStorage.getItem("issuer_id")}`)
                this.form = {
                    company_name: response.data.issuer.company_name,
                    trade_name: response.data.issuer.trade_name,
                    date_of_foundation: response.data.issuer.date_of_foundation,
                    cnpj: response.data.issuer.cnpj.replace(/(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})/, '$1.$2.$3/$4-$5'),
                    cep: response.data.issuer.cep ? response.data.issuer.cep.replace(/(\d{5})(\d{3})/, '$1-$2') : '',
                    address: response.data.issuer.address,
                    number: response.data.issuer.number,
                    cod_crt: response.data.issuer.cod_crt,
                    crt: response.data.issuer.crt,
                    cod_cnae: response.data.issuer.cod_cnae,
                    cnae: response.data.issuer.cnae,
                    ie: response.data.issuer.ie,
                    im: response.data.issuer.im,
                    
                }
                console.log(this.form)
            },

            async completeIssuer()
            {
                const i = this.crtOptions.indexOf(this.form.crt) + 1
                this.form.cod_crt = i
                this.form.crt = this.crtOptions[i - 1]
                console.log('Form: ', this.form)
    
                const response = await api.put(`issuer/complete-register/${LocalStorage.getItem("issuer_id")}`, {
                    company_name: this.form.company_name,
                    trade_name: this.form.trade_name,
                    date_of_foundation: this.form.trade_name,
                    cep: this.form.cep.replace(/\D/g, ''),
                    uf: this.form.uf,
                    address: this.form.address,
                    number: this.form.number,
                    cod_cnae: this.form.cod_cnae,
                    cnae: this.form.cnae,
                    cod_crt: this.form.cod_crt,
                    crt: this.form.crt,
                    ie: this.form.ie,
                    im: this.form.im,

                })
                
                if(response.data.success)
                {
                    this.$router.push(`/${this.form.company_name}/home`)
                }
            },

            async getCEPData()
            {
                const cep = this.form.cep.replace(/\D/g, '')
                if(cep.length === 8)
                {
                    const data = await axios.get(`${process.env.API_CEP}/${cep}/json`)
                    this.form.uf = data.data.uf
                    this.form.address = data.data.logradouro

                }
            }
        },

        mounted()
        {
            this.company_name = this.$route.params.name
            this.getIssuer()
        }
    }

</script>