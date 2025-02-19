<template>
    <div class="" v-if="showForm">
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

            <button>Enviar</button>
        </form> 
    </div>

    <Config
        v-if="show"
        :show="this.show"
    />

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

                },
                api_hotel: process.env.VUE_APP_API_URL_HOTEL,
                api_viaCEP: process.env.VUE_APP_VIACEP,
                api_CNPJ: process.env.VUE_APP_CNPJA,
                
                showForm: true,                
                show: false

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

                    const response = await axios.post(`${this.api_hotel}/hotel/create`, form)
                    
                    if (response.data.success === true) {
                        console.log(response)
                        //this.$router.push('/hotel')
                        this.showForm = false
                        this.show = true
                        
                    }

                    if (response.data.success !== true)
                    {
                        switch (response.data.code) {
                            case '23000':
                                alert('Esse CNPJ já foi cadastro na base de dados!');
                                this.form.cnpj = ''
                                break;
                            
                        
                            default:
                                alert('Esse CNPJ já foi cadastro na base de dados! 2');
                                break;
                        }

                    }
                    
                } catch (error) {
                    console.error('Erro ao criar o Hotel', error.response)
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
                        console.log(`${this.api_viaCEP}/${this.form.cep}/json/`)
                        
                        const response = await axios.get(`${this.api_viaCEP}/${this.form.cep}/json/`)
                        this.form.address = response.data.logradouro
                        console.log(response.data);
                        console.log(this.form.address);
                    }
                    
                } catch (error) {
                    console.error('Erro ao consultar o CEP', error)

                }
            },

            async getCNPJData(){
                try {
                    console.log(this.form.cnpj)
                    console.log(this.api_CNPJ)
                    if(this.form.cnpj.length === 14)
                    {
                        const response = await axios.get(`${this.api_CNPJ}/${this.form.cnpj}`);
                        this.form.name = response.data.company.name	
                        this.form.cep = response.data.address.zip
                        this.form.address = response.data.address.street
                        this.form.number = response.data.address.number
                        this.form.email = response.data.emails[0].address
                        console.log(response.data)

                    }
                } catch (error) {
                    console.error('Erro ao consultar o CNPJ', error.response)
                    console.error(`${this.api_CNPJ}/${this.form.cnpj}`)

                }
            }
        },

        components: {
            Config

        },
        mounted(){
            console.log(this.$route.name)
        }
    }
</script>