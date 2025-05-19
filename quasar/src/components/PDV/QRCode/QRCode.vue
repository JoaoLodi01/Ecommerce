<template>
    <h5>QR-Code</h5>
    <div v-if="qrCode" class="p-10">
        <img :src=qrCode alt="qrCode - PIX">
        <p
            :data-clipboard-text="payLoad"
            @click="clipBoard"
            class="btn cursor-pointer"
            title="Copiar"
        >
            Payload: {{ payLoad }}
        </p>      

        <q-btn 
            color="primary"
            label="Finalizar" 
            @click="finaly" 
            
        />
    </div>
   
</template>

<script setup lang="ts">
    import { LocalStorage } from 'quasar';
    import { api } from 'src/boot/axios';
    import { defineProps, onMounted, ref } from 'vue'
    import generatePIX from 'src/services/generatePIX';
    import clipBoard from 'src/services/clipboard';

    type Issuer = {
        company_name: string,
        cep: string
    }

    let qrCode = ref(null)
    let payLoad = ref(null)
    let pix_key = ref(null)
    let issuer = ref<Issuer>({
        company_name: '',
        cep: ''
    })
    
    const props = defineProps<{
        total_amount?: number,
        issuer_id?: number

    }>();

    const emit = defineEmits<{
        (e: 'close', value: boolean): void

    }>();

    const getKey = async () => {
        const res_key = await api.get(`/species/find-key/${LocalStorage.getItem("issuer_id")}`);
        const issuer_data = await api.get(`/issuer/companie/${LocalStorage.getItem("issuer_id")}`);
        issuer.value = issuer_data.data.issuer
        console.log('issuer', issuer.value)

        pix_key.value = res_key.data.key
        console.log('pix_key.value: ', pix_key.value)
        if(pix_key.value && props.total_amount > 0)
        {
            getQRCode()
        }
    }
    
    const getQRCode = async () => {
        console.log('props.total_amount', props.total_amount);
        const res = await generatePIX(props.total_amount, String(pix_key.value), issuer.value);

        qrCode.value = res.base64;
        payLoad.value = res.payload;
    }

    const finaly = () => {
        emit('close', true);
    }
    
    onMounted(() => {
        getKey()
    })

</script>   