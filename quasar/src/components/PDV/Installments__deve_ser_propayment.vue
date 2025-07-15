<template>
     <q-card class="w-[40rem] text-center">
        <q-card-section>
            <q-input 
                v-model.number="receiveAmount" 
                type="text" 
                label="Quantia de parcelas"
                
            />

            <q-input 
                v-model="firstPay" 
                type="date" 
                label="Data do primeiro vencimento" 
            />

        </q-card-section>
     </q-card>
    
</template>
  
<script setup lang="ts">
    import { ref, defineProps, defineEmits, onMounted } from 'vue';
    import dayjs from 'dayjs';
    import isBetween from 'dayjs/plugin/isBetween';
    
    dayjs.extend(isBetween);

    const today = dayjs().format('YYYY-MM-DD');

    let receiveAmount = ref<number>(1);
    let firstPay = ref<any>(null);

    const props = defineProps<{
        total_amount: number

    }>();

    const emits = defineEmits<{
        (e: 'installments-generated', value: object[]);

    }>();


    const generateReceive = () =>
    {

    };

    onMounted(() => {
        firstPay.value = today;
        alert('taaq')
    });

</script>