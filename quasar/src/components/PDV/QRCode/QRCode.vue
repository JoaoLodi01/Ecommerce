<template>
    <h5>QR-Code</h5>
    <div v-if="qrCode" class="p-10">
        <img :src=qrCode alt="qrCode - PIX">
        <p>Payload: {{ payLoad }}</p>
        
    </div>
    <div v-else>
        deu erro
    </div>
   
</template>

<script setup lang="ts">
    import { LocalStorage } from 'quasar';
    import { api } from 'src/boot/axios';
    import generatePIX from 'src/services/generatePIX';
    import { defineProps, onMounted, ref } from 'vue'

    let qrCode = ref(null)
    let payLoad = ref(null)
    let msg = ref('')
    let total = ref(0)
    let pix_key = ref(null)


    const props = defineProps<{
        total_amount?: number,
        issuer_id?: number

    }>();

    const emit = defineEmits<{
        (e: 'close', value: boolean): void

    }>();

    const getKey = async () => {
        const res_key = await api.get(`/species/find-key/${LocalStorage.getItem("issuer_id")}`);
        
        pix_key.value = res_key.data.key
        console.log('pix_key.value: ', pix_key.value)
        if(pix_key.value && props.total_amount > 0)
        {
            getQRCode()
        }
    }
    
    const getQRCode = async () => {
        console.log('props.total_amount', props.total_amount);
        const res = await generatePIX(props.total_amount, String(pix_key.value));

        qrCode.value = res.base64;
        payLoad.value = res.payload;
    }
    
    onMounted(() => {
        getKey()
    })

</script>   