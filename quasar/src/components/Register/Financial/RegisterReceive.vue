<template>
  <div
    class="mr-14 mt-5 mb-5 p-6 bg-white"
        :class="{
        'relative top-12 left-12': widthScreen <=1080,
        'ml-14': widthScreen > 1080
        }"
    >

    <h2 class="border-b border-black text-xl font-semibold mb-4 w-max">Cadastrar recebimentos</h2>

        <form
            @submit.prevent="submitForm"
            @reset="onReset"
            class="grid gap-4 mx-auto"
            style="max-width: 1000px;"
            :class="{
                'grid-cols-1 lg:grid-cols-2': widthScreen > 1080,
                'grid-cols-1': widthScreen <= 1080
            }"
        >

            <div class="border border-gray-300 rounded-md p-3 h-auto max-h-[230px] w-auto overflow-auto">
                <div class="flex flex-wrap gap-4">
                    <q-input
                        class="w-[100px]"
                        type="number"
                        v-model="form.document"
                        label="Nº Doc"
                        color="grey-7"
                    />

                    <q-input
                        class="w-[200px]"
                        type="text"
                        v-model="form.description"
                        label="Descrição"
                        color="grey-7"
                    />

                    <q-input
                        class="w-[150px]"
                        type="date"
                        v-model="form.due_date"
                        label="1º Vencimento"
                        color="grey-7"
                    />

                    <q-input
                        class="w-[100px]"
                        type="number"
                        v-model="form.installment_number"
                        label="Nº Parcelas"
                        color="grey-7"
                    />

                    <q-input
                        class="w-[150px]"
                        type="number"
                        v-model="form.installment_value"
                        label="Valor Parcela"
                        color="grey-7"
                    />

                    <CustomerSearchBar @updated:selectCustomer="getCustumer($event)" />
                </div>
            </div>

            <div class="border border-gray-300 rounded-md p-3 h-auto max-h-[230px] w-auto overflow-auto">
                <div class="flex flex-wrap gap-4">
                    <q-select
                        class="w-[80px]"
                        v-model="form.type_interest"
                        label="Tipo"
                        emit-value
                        map-options
                        :options="[
                            { label: '%', value: '%' },
                            { label: 'R$', value: 'R$' }
                        ]"
                    />

                    <q-input
                        class="w-[100px]"
                        type="number"
                        v-model="form.interest_value"
                        label="Juros"
                        color="grey-7"
                    />

                    <q-input
                        class="w-[100px]"
                        type="number"
                        v-model="form.addition"
                        label="Acréscimo"
                        color="grey-7"
                    />

                    <q-input
                        class="w-[100px]"
                        type="number"
                        v-model="form.discount"
                        label="Desconto"
                        color="grey-7"
                    />

                    <q-input
                        class="w-[130px]"
                        type="number"
                        v-model="form.value_entry"
                        label="Juros a pagar"
                        color="grey-7"
                        readonly
                    />

                    <SpeciesSearchBar @selectSpecie="getSpecie($event)" :module_="'receive'" />
                </div>
            </div>

            <div class="lg:col-span-2 flex justify-end">
                <q-btn
                    label="Gerar Parcelas"
                    color="primary"
                    class="mb-2"
                    @click="gerarParcelas"
                />
            </div>

            <div
                class="lg:col-span-2 overflow-y-auto border border-gray-400 rounded-md shadow-sm"
                style="height: 230px;"
            >
                <table class="min-w-full border-collapse bg-white text-sm">
                    <thead class="sticky top-0 z-10 bg-blue-600 text-white">
                        <tr>
                            <th class="px-2 py-1">Parcela</th>
                            <th class="px-2 py-1">Nº Parcela</th>
                            <th class="px-2 py-1">Data Vencimento</th>
                            <th class="px-2 py-1">Valor à pagar</th>
                            <th class="px-2 py-1">Valor Original</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr :key="id" class="text-center border-t border-gray-300">
                            <td class="py-1"></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                    </tbody>
                </table>
                </div>

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
          installment_number: 1,
          installment_value: 0,
          type_interest: "",
          interest_value: 0,
          addition: 0,
          discount: 0,
          value_entry: 0,
          value_paid: 0,
          value_original: 0,
          origem: "Receber (Manual)",
        },
      };
    },

    computed: {
      totalAmoutCalc() {
        const number = this.parseCurrency(this.form.installment_number);
        const value = this.parseCurrency(this.form.installment_value);
        const total = number * value;

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
          addition: 0,
          discount: 0,
          value_entry: 0,
          value_paid: 0,
          value_original: 0,
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
