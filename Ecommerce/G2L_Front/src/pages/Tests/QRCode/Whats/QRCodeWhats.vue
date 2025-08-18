<template>
    <div v-if="errorMsg" class="text-red-500">
        {{ errorMsg }}
    </div>

    <div v-else>
        <pre>{{ qr }}</pre>
        <img :src="qrImage" alt="erro image">

        <q-input 
            v-model="msg" 
            type="text" 
            label="Mensagem para envio"
        />
        
        <q-input 
            v-model="tel" 
            type="tel" 
            label="Destino" 
        />

        <q-btn 
            color="primary" 
            icon="check" 
            label="OK" 
            @click="sendMessage()" 

        />
    </div>

</template>

<script setup lang="ts">
    import { onMounted, ref } from 'vue'
    import { useQuasar } from 'quasar'
    import QRCode from 'qrcode'
    import axios from 'axios';

    const $q = useQuasar();
    const url = ref<string>("http://localhost:3000/api/v1");
    let qr = ref<string>('');
    let qrImage = ref<string>('');

    let msg = ref<string>('');
    let tel = ref<string>('');
    let errorMsg = ref<string>('');

    const sendMessage = async () => {
        if (msg.value === '' || tel.value === '')
        {
            alert('Dados ausentes')    
        } else {
            try {   
                const send = await axios.post(`${url.value}/whats/send-message`, {
                    msg: msg.value,
                    to: tel.value
                    
                }, {
                    headers: {
                        Accept: "application/json"
                    }
                });

                const data = send.data.status;
                if(data === 'enviado') {
                    $q.notify({
                        color: 'green',
                        position: 'top',
                        message: 'Mensagem enviada com sucesso!',
                        timeout: 2000
                    });
                };

                console.log(send.data);
                
            } catch (error) {
                console.error('Erro ao enviar msg: ', error)
                errorMsg.value = error;  
            };
        }; 
    };  

    onMounted(async () => {
        //http://localhost:3000/qr-code
        try {
            const res = await axios.get<{ qr: string }>(`${url.value}/whats/qr-code`, {
                headers: { Accept: 'application/json' },
            
            })
            console.log(res.data)
            qr.value = res.data.qr;

            if(qr.value)
            {                
                qrImage.value = await QRCode.toDataURL(qr.value, {
                    width: 256,
                    margin: 2,
                    errorCorrectionLevel: 'M',
                });
            } else {
                qrImage.value = ''

            };

        } catch (error) {
            console.error('Erro : ', error)
            errorMsg.value = error   
        };
    });

</script>