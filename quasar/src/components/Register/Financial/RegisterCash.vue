<template>
    <div 
        class="mr-14 border border-black mt-5 mb-5 p-6 bg-white shadow-md rounded"
        :class="{
            'relative top-12 left-12': widthScreen <=1080,
            'ml-14': widthScreen > 1080
        }">

        <h2 class="border-b border-black text-xl font-semibold mb-4 w-max">Registro Financeiro</h2>
        
        <form  
            @submit.prevent="submitForm"
            @reset="onReset"
            class="p-1"
                :class="{
                    'grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6': widthScreen > 1080
                }">
    
            <q-input
            type="text"
            v-model="form.description"
            label="Descrição"
            color="grey-7"
            />

            <CustomerSearchBar
                @updated:selectCustomer="getCustumer($event)"
            />

            <q-input
            type="text"
            v-model="form.user"
            label="Usuário"
            color="grey-7"
            readonly
            />
        
            <q-input
            type="text"
            v-model="form.especie"
            label="Espécie"
            color="grey-7"
            />

            <q-input 
            type="number" 
            v-model="form.total_amount" 
            label="Total"
            color="grey-7"
            />
    
            <div>
                <q-btn
                    type="submit"
                    label="Registrar"
                    class="bg-slate-600 text-white">
                </q-btn>

                <q-btn
                    @click="onReset()"
                    label="Limpar"
                    class="ml-5 bg-slate-600 text-white">
                </q-btn>

                <q-btn
                    @click="close()"
                    label="Voltar"
                    class="ml-5 bg-slate-600 text-white">
                </q-btn>
            </div>
        </form>
    </div>
</template>
    
<script>
    import { api } from "boot/axios"
    import {LocalStorage} from "quasar";
    import CustomerSearchBar from "src/components/Search/CustomerSearchBar.vue";

    export default {
        props: {
            widthScreen: {
                required: true,
                type: Number,
            }
        },

        data() {
            return {
                form: {
                    description: "",
                    name: "",
                    user: LocalStorage.getItem("user_name"),
                    especie: "",
                    total_amount: ""
                },
            };
        },

        methods: {
            onReset(){
                this.form = {
                    description: "",
                    name: "",
                    user: LocalStorage.getItem("user_name"),
                    especie: "",
                    total_amount: ""
                }
            },
            
            close(){
                this.$emit('close', false)
            },

            getCustumer(event){
                console.log('Chamou o getCustumer')
                console.log(event)
                this.form.name = event.name
            },

            async submitForm() {
                try {
                    const response = await api.post(`${this.api}`, this.form); // Lembrar de criar rota e inserir aqui
                    this.resetform();
                    console.log('Dados enviados!', response.data)
                } catch (error) {
                    alert("Ocorreu um erro ao cadastrar o registro")
                }
            },
        },

        components:{
            CustomerSearchBar
        },

        emits:[
            'close'
        ],
    };
</script>