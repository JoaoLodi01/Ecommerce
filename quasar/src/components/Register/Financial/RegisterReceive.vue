<template>
  <div
    class="mr-14 mt-5 mb-5 p-6 bg-white"
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
          type="number" 
          v-model="form.document" 
          label="Nº Documento" 
          color="grey-7" 
      />

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
        v-model="user"
        label="Usuário"
        color="grey-7"
        readonly
      />

      <SpeciesSearchBar
        @selectSpecie="getSpecie($event)"
        :module_="'receive'"
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
          { label: '%', value: '%' },
          { label: 'R$', value: 'R$'}
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

      <div>
        <q-btn
          type="submit"
          label="Registrar"
          class="bg-blue-600 text-white">
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
  import { api } from "src/boot/axios"
  import {LocalStorage} from "quasar";
  import dayjs from "dayjs";
  import 'dayjs/locale/pt-br';
  import CustomerSearchBar from "src/components/Search/CustomerSearchBar.vue";
  import SpeciesSearchBar from "src/components/Search/SpeciesSearchBar.vue";

  export default {
    props: {
      widthScreen: {
        required: true,
        type: Number,
      }
    },

    data() {
      const today = dayjs();

      return {
        user: LocalStorage.getItem("user_name"),
        form: {
          issuer_id: LocalStorage.getItem("issuer_id"),
          description: "Registro Manual Receber",
          document: 1,
          customer_id: 1,
          user_id: LocalStorage.getItem("user_id"),
          especie_id: 0,
          due_date: today.add(30, 'days').format("DD-MM-YYYY"),
          installment_number: 0,
          installment_value: 0,
          type_interest: "",
          interest_value: 0,
          total_amount: 0,
          origem: "Receber (Manual)",
        },
      };
    },

    computed: {
      totalAmoutCalc() {
        const number = this.parseCurrency(this.form.installment_number);
        const value = this.parseCurrency(this.form.installment_value);
        const feesValue = this.parseCurrency(this.form.interest_value);
        const typeInterest = this.form.type_interest;

        const baseTotal = number * value;

        let total = 0;

        if (typeInterest === '%') {
          total = baseTotal + (baseTotal * (feesValue / 100));
        } else if (typeInterest === 'R$') {
          total = baseTotal + feesValue;
        } else {
          total = baseTotal;
        }

        return total.toFixed(2);

      }
    },

    methods: {
      parseCurrency(value) {
      if (!value) return 0;

      return parseFloat(
        value
          .toString()
          .replace(/\s/g, '')
          .replace('R$', '')
          .replace(/\./g, '')
          .replace(',', '.')
      ) || 0;
    },

    onReset(){
      const today = this.today;
        this.form = {
          issuer_id: LocalStorage.getItem("issuer_id"),
          description: "Registro Manual Receber",
          document: 1,
          customer_id: 1,
          user_id: LocalStorage.getItem("user_id"),
          especie_id: 0,
          due_date: today.add(30, 'days').format("DD-MM-YYYY"),
          installment_number: 1,
          installment_value: 0,
          type_interest: "",
          interest_value: 0,
          total_amount: 0,
          origem: "Receber (Manual)",
        }
    },

    close(){
      this.$emit('close', false)
    },

    getCustumer(event){
      console.log('Chamou o getCustumer')
      console.log(event)
      this.form.customer_id = event.id
    },

    getSpecie(event){
        console.log("Chamou o getSpecie");
        console.log(event);
        this.form.especie_id = event.payment_cod;
        this.form.especie = event.name;
    },

    async submitForm() {
      console.log(this.form)
        try {
          const response = await api.post(`/ecommerce/receive/create`, this.form);

          if(response.data.success){
            this.close();
            this.onReset();
          }

          console.log('Dados enviados!', response.data)
        } catch (error) {
            alert("Ocorreu um erro ao cadastrar o registro")
        }
    },
  },

  watch: {
    totalAmoutCalc(newVal){
      this.form.total_amount = newVal;
    }
  },

  components:{
    CustomerSearchBar,
    SpeciesSearchBar,
  },
  
  emits:[
    'close'
  ],
};
</script>
