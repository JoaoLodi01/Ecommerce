<template>
    <div class="flex justify-center ml-14 mt-10 p-5">
        <q-form
            @submit="completeIssuer()"
            
        >
            <h1 
                v-if="!_completed" 
                class="ml-5 text-2xl"
            >
                Complete o cadastro da sua empresa!
            </h1>
            
            <div class="bg-white p-5 rounded-lg mb-5">
                <h3 class="border-b mb-3">Dados da empresa</h3>
                <div class="flex">
                    <q-input 
                        class="w-max"
                        label="CNPJ/CPF"
                        v-if="form.cnpj"
                        v-model="form.cnpj" 
                        type="text" 
                        disable
                        
                    />
                    
                    <q-input 
                        class="w-max"
                        label="CNPJ/CPF"
                        v-else
                        v-model="form.cpf" 
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
                        v-model="cep"
                        v-on:update:model-value="getCEPData()"
                        filled        
                        label="CEP *" 
                        class="mb-4"
                        color="grey"
                        v-bind:mask="'#####-###'"
                        maxlength="9"
                        :rules="[ val => !!val || 'Preencha o CEP' ]"
    
                    />   
                    
                    <q-input 
                        v-model="form.uf"
                        filled        
                        type="text"
                        label="UF *" 
                        class="mb-4 ml-2 mr-2"
                        color="grey"
                        maxlength="2"
                        aria-required="true"
                        :rules="[ val => !!val || 'Preencha a UF' ]"

                    />   
    
                    <q-input 
                        filled        
                        label="Endereço *" 
                        v-model="form.address"                        
                        class="mb-4 ml-2 mr-2"
                        color="grey"
                        maxlength="100"
                        :rules="[ val => !!val || 'Preencha o endereço' ]"
    
                    />        
                        
                    <q-input 
                        filled        
                        label="Número *" 
                        v-model="form.number"
                        :rules="[ val => !!val || 'Preencha o número' ]"
                        class="mb-4"
                        color="grey"
                        maxlength="10"
    
                    />

                </div>
            </div>
                
            <div class="bg-white p-5 rounded-lg mb-5">
                <h3 class="border-b mb-5">Dados fiscáis</h3>
                <q-select
                    :options="crtOptions"
                    v-model="form.crt"
                    label="CRT ( Cód. Regime tributário ) *"
                    class="mb-4"
                    color="grey" 
                    filled 
                    :rules="[ val => !!val || 'Preencha o seu CRT' ]"
                />

                <q-input 
                    filled        
                    label="Cód. CNAE *" 
                    v-model="form.cod_cnae"
                    :rules="[ val => !!val || 'Preencha o Cód. CNAE' ]"
                    class="mb-4"
                    color="grey"
                    maxlength="10"

                />  

                <q-input 
                    filled        
                    label="CNAE *" 
                    v-model="form.cnae"
                    :rules="[ val => !!val || 'Preencha o CNAE' ]"
                    class="mb-4"
                    color="grey"
                    maxlength="160"

                />  
                
                <q-input 
                    filled        
                    label="IE *" 
                    v-model="form.ie"
                    class="mb-4"
                    color="grey"
                    maxlength="14"
                    :rules="[ val => !!val || 'Preencha a IE']"

                />  

                <q-input 
                    filled        
                    label="IM" 
                    v-model="form.im"
                    class="mb-4"
                    color="grey"
                    maxlength="12"
                    v-if="form.cnpj"

                />  
            </div>
            
            <div>
                <q-btn 
                    label="Salvar" 
                    type="submit" 
                    class="ml-2 submit-btn"
                    :class="`bg-[${color}] text-white`"
                />
                
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
                _completed: LocalStorage.getItem("_completed"),
                timer: null,
                cep: '',
                color: '#E75A7C',
                form: {
                    company_name: '',
                    trade_name: '',
                    date_of_foundation: null,
                    cnpj: '',
                    cpf: '',
                    uf: '',
                    address: '',
                    number: '',
                    cod_crt: '',
                    crt: '',
                    cod_cnae: '',
                    cnae: '',
                    ie: '',
                    im: ''
                    
                },
            }
        },

        methods: {
            showLoading (msg) {
                this.$q.loading.show({
                    message: 'Cadastrando sua empresa ...'

                })

            },

            hideLoading() {
                this.$q.loading.hide()
            },

            async getIssuer()
            {
                const response = await api.get(`/issuer/companie/${LocalStorage.getItem("issuer_id")}`)
                this.form = {
                    company_name: response.data.issuer.company_name,
                    trade_name: response.data.issuer.trade_name,
                    date_of_foundation: response.data.issuer.date_of_foundation,
                    cnpj: response.data.issuer.cnpj ? response.data.issuer.cnpj.replace(/(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})/, '$1.$2.$3/$4-$5') : null,
                    cpf: response.data.issuer.cpf ? response.data.issuer.cpf.replace(/(\d{3})(\d{3})(\d{3})(\d{2})/, '$1.$2.$3-$4') : null,
                    address: response.data.issuer.address,
                    number: response.data.issuer.number,
                    cod_crt: response.data.issuer.cod_crt,
                    crt: response.data.issuer.crt,
                    cod_cnae: response.data.issuer.cod_cnae,
                    cnae: response.data.issuer.cnae,
                    ie: response.data.issuer.ie,
                    im: response.data.issuer.im,
                    
                }
                this.cep = response.data.issuer.cep ? response.data.issuer.cep.replace(/(\d{5})(\d{3})/, '$1-$2') : null,
                
                console.log(response)
            },

            async completeIssuer()
            {
                try {
                    this.showLoading()
                    const i = this.crtOptions.indexOf(this.form.crt) + 1
                    this.form.cod_crt = i
                    this.form.crt = this.crtOptions[i - 1]                
        
                    const response = await api.put(`issuer/complete-register/${LocalStorage.getItem("issuer_id")}`, {
                        company_name: this.form.company_name,
                        trade_name: this.form.trade_name,
                        date_of_foundation: this.form.date_of_foundation,
                        cep: this.cep.replace(/\D/g, ''),
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

                    console.log(response)
                    if(response.data.success)
                    {
                        this.hideLoading();
                        LocalStorage.setItem("_completed", true)
                        this.$router.push(`/${this.form.company_name.split(" ")[0]}/home`)
                    } 
                } catch (error) {
                    console.error('Erro ao completar o cadastro: ', error)
                    
                } finally {
                    this.hideLoading();

                }
            },

            async getCEPData()
            {
                console.log('Chamou ')
                if(this.cep)
                {
                    const cep = this.cep.replace(/\D/, '')
                    if(cep.length === 8)
                    {
                        const data = await axios.get(`${process.env.API_CEP}/${cep}/json`)
                        this.form.uf = data.data.uf
                        this.form.address = data.data.logradouro

                    }
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
