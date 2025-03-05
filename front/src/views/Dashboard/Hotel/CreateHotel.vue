<template>
    <div class="">
        <form @submit.prevent="createHotel">
            <input
                type="text"
                placeholder="Nome do Hotel"
                v-model="form.name"

            >

            <input
                type="text"
                maxlength="14"
                placeholder="CNPJ do Hotel"
                v-model="form.cnpj"
                @input="getCNPJData"
            >

            <input
                type="email"
                placeholder="E-mail do Hotel"
                v-model="form.email"
                
            >

            <input
                type="text"
                maxlength="8"
                placeholder="CEP do Hotel"
                v-model="form.cep"
                @input="getAddress"
            >

            <input
                type="text"
                placeholder="Endereço do Hotel"
                v-model="form.address"
                
            >

            <input
                type="text"
                placeholder="Número do endereço"
                v-model="form.number"
                
            >

            <input
                type="text"
                placeholder="Número do quartos"
                v-model="form.number_of_rooms"
                
            >

            <input
                type="text"
                placeholder="Número de funcionário"
                v-model="form.number_of_employees"
                
            >

            <select 
                id=""
                v-model="form.cod_crt"
            >
                <option value="1">Simples Nacional</option>
                <option value="2">Lucro Presumido</option>
                <option value="3">Lucro Real</option>
                <option value="4">Simples - excesso de receita</option>
                <option value="5">Simples - MEI</option>
            </select>

            <select 
                id=""
                v-model="form.cod_cnae"
            >
                <option value="5510801">Hotéis</option>
                
            </select>

            <button>Enviar</button>
        </form> 
    </div>

    <div v-if="message">
        Aviso: {{ $t(message) }}
    </div>

</template>

<script>
    import Config from '@/views/components/Config.vue';
    import axios from 'axios';

    export default {
        data(){
            return {
                form: {
                    name: '',
                    cnpj: '',
                    email: '',
                    cep: '',
                    address: '',
                    number: '',
                    number_of_rooms: '',
                    number_of_employees: '',
                    cod_cnae: '',
                    cnae: '',
                    cod_crt: '',
                    crt: ''

                },
                message: '',
                api: process.env.VUE_APP_API_URL,
                api_viaCEP: process.env.VUE_APP_VIACEP,
                api_CNPJ: process.env.VUE_APP_CNPJA,
                
            }
        },

        methods: {
            async createHotel()
            {
                try {
                    const form = new FormData();
                    form.append("name", this.form.name);
                    form.append("cnpj", this.form.cnpj);
                    form.append("email", this.form.email);
                    form.append("cep", this.form.cep);
                    form.append("address", this.form.address);
                    form.append("number", this.form.number);
                    form.append("number_of_rooms", this.form.number_of_rooms);
                    form.append("number_of_employees", this.form.number_of_employees);
                    form.append("cod_cnae", this.form.cod_cnae);
                    form.append("cnae", this.form.cnae);
                    form.append("cod_crt", this.form.cod_crt);
                    
                    switch (this.form.cod_crt) {
                        case '1':
                            this.form.crt = 'Simples Nacional'
                            form.append("crt", this.form.crt);
                            break;
                        
                        case '2':
                            this.form.crt = 'Lucro Presumido'
                            form.append("crt", this.form.crt);
                            break;

                        case '3':
                            this.form.crt = 'Lucro Real'
                            form.append("crt", this.form.crt);
                            break;

                        case '4':
                            this.form.crt = 'Simples - excesso de receita'
                            form.append("crt", this.form.crt);
                            break;

                        case '5':
                            this.form.crt = 'Simples - MEI'
                            form.append("crt", this.form.crt);
                            break;

                        default:
                            alert('Insira um valor válido')
                            break;
                    }

                    switch (this.form.cod_cnae) {
                        case '5510801':
                            this.form.cnae = 'Hotéis'
                            form.append("cnae", this.form.cnae);
                            break;
                    
                        default:
                            break;
                    }

                    const response = await axios.post(`${this.api}/hotel/create`, this.form)
                    
                    if (response.data.success === true) {
                        this.$router.push('/hotel')
                        
                    }

                    if (response.data.success !== true)
                    {
                        switch (response.data.code) {
                            case '23000':
                                alert('Esse CNPJ já foi cadastro na base de dados!');
                                break;

                            default:
                                alert('Algo deu errado: ', response.data.message);
                                break;
                        }

                    }
                    
                } catch (error) {
                    console.error('Erro ao criar o Hotel', error)
                    if(error.response)
                    {
                        alert(error.response.data.message ? error.response.data.message : "Erro detecado")
                        
                    }
                }
            },
            async getAddress(){
                try {                
                    console.log(this.form.cep)
                    if(this.form.cep.length === 8)
                    {
                        const response = await axios.get(`${this.api_viaCEP}/${this.form.cep}/json/`)
                        this.form.address = response.data.logradouro
                        
                    }
                    
                } catch (error) {
                    console.error('Erro ao consultar o CEP', error)

                }
            },

            async getCNPJData(){
                if(this.form.cnpj.length === 14)
                {
                    try {
                        const response = await axios.get(`${this.api_CNPJ}/${this.form.cnpj}`);
                        if(response.status === 200)
                        {
                            this.form = {
                                name: response.data.company.name,
                                cep: response.data.address.zip,
                                address: response.data.address.street,
                                number: response.data.address.number,
                                email: response.data.emails[0].address,
                                cnpj: response.data.taxId
                            }

                        } 
                        
                    } catch (error) {
                        console.error('Erro', error)
                        this.message = 'message.constraints'; // Definir a chave da mensagem de erro
                        //this.message = error.response.data.constraints[0]
                        
                    }
                }
            }
        },

        components: {
            Config

        },
        mounted(){
            
        }
    }
</script>