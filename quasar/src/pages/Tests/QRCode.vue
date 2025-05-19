<template>
    <h5>QR-Code</h5>
    <div v-if="!showQRCode" class="p-10">
        <img :src=qrCode alt="qrCode - PIX">
        <p>Payload: {{ payLoad }}</p>
        
    </div>
    <div v-else>
        deu erro
    </div>
    <button @click="getKey()">Gerar</button>
</template>

<script setup lang="ts">
    import { LocalStorage } from 'quasar';
    import { api } from 'src/boot/axios';
    import generatePIX from 'src/services/generatePIX';
    import { defineProps, onMounted, ref } from 'vue'

    let showQRCode = ref(false)
    let qrCode = ref(null)
    let payLoad = ref(null)
    let msg = ref('')
    let total = ref(0)
    let pix_key = ref(null)
    let total_amount = ref(10)

    const emit = defineEmits<{
        (e: 'close', value: boolean): void

    }>();

    const getKey = async () => {
        const res = await api.get(`/species/find-key/${LocalStorage.getItem("issuer_id")}`);
        pix_key.value = res.data.key
        console.log('pix_key.value: ', String(pix_key.value).replace(/\D/, ''))
        if(pix_key.value && total_amount.value > 0)
        {
            getQRCode()
        }
    }
    
    const getQRCode = async () => {
        console.log('total_amount.value', total_amount.value);
        const res = await generatePIX(total_amount.value, String(pix_key.value).replace(/\D/, ''));

        qrCode.value = res.base64;
        payLoad.value = res.payload;
    }
    
</script>   