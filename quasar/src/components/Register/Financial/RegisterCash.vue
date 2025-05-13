<template>
    <div class="mr-14 mt-5 mb-5 p-6 bg-white rounded" :class="{
        'relative top-12 left-12': widthScreen <= 1080,
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
                v-model="form.user"
                label="Usuário"
                color="grey-7"
                readonly
            />
            
            <SpeciesSearchBar
                @updated:selectSpecie="getSpecie($event)"
            />

            <q-input 
                type="date"
                v-model="form.date_register"
                label="Data Cadastro"
                color="grey-7"
            />
            <q-input
                v-if="sum"
                type="number"
                v-model="form.input_value"
                label="Valor Entrada"
                color="grey-7"
            />
            <q-input
                v-else
                type="number"
                placeholder="0,00"
                mask="##,##"
                fill-mask="0"
                v-model="form.output_value"
                label="Valor Saída"
                color="grey-7"
            />
            <q-input
                type="text"
                v-model="form.obs"
                label="Observação"
                color="grey-7"
            />
            <q-input
                type="text"
                :value="totalAmountCalc"
                v-model="form.total_amount"
                label="Valor total"
                readonly
                color="grey-7"
            />

            <div>
                <q-btn
                    type="submit"
                    label="Registrar"
                    class="bg-slate-600 text-white"
                />
                <q-btn
                    @click="sum = !sum"
                    :label="sum ? 'entrada' : 'saída'"
                    class="ml-5"
                    :class="{
                        'bg-green-500 text-white' : sum,
                        'bg-red-500 text-white' : !sum
                    }"
                    bg-slate-600
                    text-white
                />
                <q-btn
                    @click="close()"
                    label="Voltar"
                    class="ml-5
                    bg-slate-600
                    text-white"
                />
            </div>
        </form>
    </div>
</template>

<script>
import { api } from "boot/axios";
import dayjs from "dayjs";
import { LocalStorage } from "quasar";
import CustomerSearchBar from "src/components/Search/CustomerSearchBar.vue";
import SpeciesSearchBar from "src/components/Search/SpeciesSearchBar.vue";

export default {
    props: {
        widthScreen: {
            required: true,
            type: Number,
        },
    },

    data() {
        const today = dayjs();

        return {
            sum: true,
            form: {
                description: "Registro Manual",
                document: 1,
                customer_id: 1,
                user: LocalStorage.getItem("user_name"),
                especie_id: 0,
                date_register: today.format("YYYY-MM-DD"),
                input_value: 0,
                output_value: 0,
                total_amount: 0,
                obs: "",
            },
        };
    },

    computed: {
        totalAmountCalc() {
            const entrada = this.parseCurrency(this.form.input_value);
            const saida = this.parseCurrency(this.form.output_value);
            const total = entrada - saida;
            return this.form.total_amount = total
        },
    },

    methods: {
        parseCurrency(value) {
            if (!value) return 0;
            return parseFloat(
            value.replace(/[R$\s.]/g, '').replace(',', '.')
            ) || 0;
        },

        onReset() {
            const today = dayjs();
            this.form = {
                description: "Registro Manual",
                document: 1,
                customer_id: 0,
                user: LocalStorage.getItem("user_name"),
                especie: "",
                date_register: today.format("YYYY-MM-DD"),
                input_value: 0,
                output_value: 0,
                total_amount: 0,
            };
        },

        close() {
            this.$emit("close", false);
        },

        getCustumer(event) {
            console.log("Chamou o getCustumer");
            console.log(event);
            this.form.customer_id = event.id;
        },

        getSpecie(event){
            console.log("Chamou o getSpecie");
            console.log(event);
            this.form.especie_id = event.id;
            this.form.especie = event.especie;
        },

        async submitForm() {
            console.log("Dados enviados!", this.form.issuer_cod);
            try {
                const response = await api.post('/ecommerce/cash-register/create',
                    {
                    issuer_id: LocalStorage.getItem("issuer_id"),
                    description: this.form.description,
                    document: this.form.document,
                    customer_id: this.form.customer_id,
                    especie_id: this.form.especie_id,
                    date_register: this.form.date_register,
                    input_value: this.parseCurrency(this.form.input_value),
                    output_value: this.parseCurrency(this.form.output_value),
                    user_id: LocalStorage.getItem("user_id"),
                    }
                );

                this.onReset();
                console.log("Dados enviados!", response);
            } catch (error) {
                console.error(error);
                alert("Ocorreu um erro ao cadastrar o registro");
            }
        },
    },

    components: {
        CustomerSearchBar,
        SpeciesSearchBar,
    },

    emits: ["close"],
};
</script>