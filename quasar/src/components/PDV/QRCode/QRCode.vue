<template>
    <q-card class="w-[40rem] text-center" v-if="qrCode">        
        <img :src=qrCode alt="qrCode - PIX" class="border border-black">
        R$: {{ props.total_amount }}
        
        <div class="-mt-5">
            <span 
                class="bg-green-500 text-white p-2 rounded-md cursor-pointer"
                v-if="successClip"
                @click="successClip = !successClip"
            >
                Chave copiada com sucesso!
            </span>
            <q-card-section>
                <q-btn
                    label="Chave cópia e cola"
                    :data-clipboard-text="payLoad"
                    @click="fnClipBoard"
                    class="btn cursor-pointer"
                    color="primary"
                    title="Copiar"
                />
                
            </q-card-section>
        </div>
            <q-card-section class="flex justify-center">
                <q-btn 
                color="primary"
                label="Finalizar venda" 
                @click="finaly" 
                
            />
        </q-card-section>
    </q-card>   
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

    let successClip: any = ref(null)
    let qrCode: any = ref(null)
    let payLoad: any = ref(null)
    let pix_key: any = ref(null)
    let issuer: any = ref<Issuer>({
        company_name: '',
        cep: ''
    })
    
    const props = defineProps<{
        total_amount?: number,
        issuer_id?: number

    }>();

    const emits = defineEmits<{
        (e: 'close', value: boolean): void,
        (e: 'discount', value: number): void

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

    const fnClipBoard = async () => 
    {
        try {
            const res = await clipBoard();
            successClip.value = res
            console.log('Res: ', res)
        } catch (error) {
            console.error('Falha')
            
        }
    }

    const finaly = () => 
    {
        emits('close', true);
        emits('discount', props.total_amount)
    }
    
    onMounted(() => {
        getKey();
    })

</script>   