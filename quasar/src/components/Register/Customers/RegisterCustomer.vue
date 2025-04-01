<template>
  <div class="mt-10 p-6 bg-white shadow-md rounded">
    <h2 class="text-xl font-semibold mb-4">Cadastro de Cliente</h2>
    
    <q-form
        @submit="submitForm()"
        @reset="onReset"
        class="q-gutter-md"
    >
        <q-input 
            v-model="form.name" 
            type="text" 
            label="Nome" 
        />

        <q-input 
            v-model="form.cpf" 
            type="text" 
            label="CPF" 
        />

        <q-input 
            v-model="form.cnpj" 
            type="text" 
            label="CNPJ" 
        />

        <q-input 
            v-model="form.cep" 
            type="text" 
            label="CEP" 
        />

        <q-input 
            v-model="form.address" 
            type="text" 
            label="Label" 
        />

        <q-input 
            v-model="form.number" 
            type="text" 
            label="Número" 
        />
        
        <q-input 
            v-model="form.email" 
            type="email" 
            label="E-mail" 
        />
        
        <q-input 
            v-model="form.password" 
            type="text" 
            label="Senha" 
        />
        
        <q-input 
            v-model="form.password_" 
            type="text" 
            label="Confirme sua senha" 
        />
        
        <div>
            <q-btn type="submit" class="mr-5">
                <button>Criar</button>
            </q-btn>
            
            <q-btn label="Limpar">
                
            </q-btn>
        </div>
    </q-form>
  </div>
</template>

<script>
    import { api } from 'src/boot/axios';

    export default {
    data() {
        return {
            form: {
                name: '',
                cpf: '',
                cnpj: '',
                cep: '',
                address: '',
                number: '',
                email: '',
                password: '',
                password_: '',
                phone: '',
            },
            
        };
    },
    methods: {
        async submitForm() {
            try {
                const response = await api.post(`/customers/create`, this.form);
                console.log(response)
                //replace(/(\d{3})(\d{3})(\d{3})(\d{2})/, '$1.$2.$3-$4')
            } catch (error) {
                    alert("Ocorreu um erro ao cadastrar o cliente.");
                    console.error('Erro', error)
                }
            },
        },
    };
</script>