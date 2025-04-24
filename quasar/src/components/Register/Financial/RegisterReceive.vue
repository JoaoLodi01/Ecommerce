<template>
  <div
    class="mr-14 border border-black mt-5 mb-5 p-6 bg-white shadow-md rounded"
    :class="{
      'relative top-12 left-12': widthScreen <=1080,
      'ml-14': widthScreen > 1080
    }">

    <h2 class="border-b border-black text-xl font-semibold mb-4 w-max">Cadastrar recebimentos</h2>

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
        v-model="form.due_date"
        label="Data de Vencimento"
        mask="##/##/####">

        <template v-slot:append>
          <q-icon name="event" class="cursor-pointer">
            <q-popup-proxy>
            <q-date v-model="form.due_date" mask="DD/MM/YYYY" />
            </q-popup-proxy>
          </q-icon>
        </template>
      </q-input>

      <q-input
        type="number"
        v-model="form.installment_number"
        label="Nº Parcelas"
        color="grey-7"
      />

      <q-input
        type="number"
        v-model="form.installment_value"
        label="Valor Parcelas"
        color="grey-7"
      />

      <q-select
        v-model="form.type_interest"
        label="Tipo de Juros"
        :options="[
          { label: '%', value: 'Porcentagem' },
          { label: 'R$', value: 'Valor'}
        ]"
        emit-value
        map-options
      />

      <q-input
        type="number"
        v-model="form.interest_value"
        label="Valor juros"
        color="grey-7"
      />

      <q-input
        type="number"
        v-model="form.total_amount"
        label="Valor total"
        color="grey=7"
      />

      <q-input
        type="text"
        readonly
        label="Luiz que pediu"
        color="grey=7"
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
            cpf: "",
            especie: "",
            due_date: "",
            installment_number: "",
            installment_value: "",
            type_interest: "",
            interest_value: "",
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
                cpf: "",
                especie: "",
                due_date: "",
                installment_number: "",
                installment_value: "",
                type_interest: "",
                interest_value: "",
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
          console.log(this.form)
            try {
                const response = await api.post(`${this.api}`, this.form); // Lembrar de criar rota e inserir aqui
                this.onReset();
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
