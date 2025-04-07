<template>
    <q-dialog v-model="showDialog">
      <q-card class="q-pa-md" style="min-width: 500px;">
        <q-card-section>
          <div class="text-h6">Parcelamento</div>
        </q-card-section>
  
        <q-separator />
  
        <q-card-section v-if="!generatedInstallments">
            <q-input
                v-model.number="installmentCount"
                label="Número de parcelas"
                type="number"
                outlined
                dense
            />
            <q-input
                v-model="firstDueDate"
                label="Data de Vencimento da primeira parcela"
                type="date"
                outlined
                dense
                class="q-mt-sm"
            />
            <q-btn 
                label="Gerar Parcelas"
                color="primary"
                class="q-mt-md"
                @click="generateInstallments"
            />
        </q-card-section>
  
        <q-card-section v-else>
          <q-banner class="q-mb-md bg-blue-1 text-black">
            Parcelas geradas em base no valor total: R$ {{ totalAmount.toFixed(2) }}
          </q-banner>
  
          <div v-for="(installment, i) in installments" :key="i" class="q-mb-sm">
            <q-input
                v-model.number="installment.amount"
                label="Total"
                type="number"
                outlined
                dense
            />
            <q-input
                v-model="installment.dueDate"
                label="Data de vencimento"
                type="date"
                outlined
                dense
                class="q-mt-xs"
            />
          </div>
        </q-card-section>
  
        <q-card-actions align="right">
            <q-btn
                flat
                label="Cancelar"
                color="negative"
                v-close-popup
            />
            <q-btn
                label="Finalizar"
                color="primary"
                @click="saveInstallments"
                v-if="generatedInstallments"
            />
        </q-card-actions>
      </q-card>
    </q-dialog>
  </template>
  
  <script>
  export default {
    props: {
      show: Boolean,
      totalAmount: Number
    },
    emits: ['update:show', 'installmentsGenerated'],
    data() {
      return {
        showDialog: this.show,
        installmentCount: 1,
        firstDueDate: '',
        installments: [],
        generatedInstallments: false
      }
    },
    watch: {
      show(val) {
        this.showDialog = val;
      },
      showDialog(val) {
        this.$emit('update:show', val);
      }
    },
    methods: {
      generateInstallments() {
        if (!this.installmentCount || !this.firstDueDate) return;
        const baseAmount = (this.totalAmount / this.installmentCount).toFixed(2);
  
        this.installments = Array.from({ length: this.installmentCount }, (_, i) => {
          const dueDate = new Date(this.firstDueDate);
          dueDate.setMonth(dueDate.getMonth() + i);
          return {
            amount: parseFloat(baseAmount),
            dueDate: dueDate.toISOString().split('T')[0]
          };
        });
  
        this.generatedInstallments = true;
      },
      saveInstallments() {
        this.$emit('installments-saved', this.installments);
        this.$emit('update:show', false);
      }
    }
  }
  </script>