<template>
    <q-dialog v-model="props.showInformationsOfMail" persistent>
        <q-card>
            <q-card-section class="row items-center">
                <span class="q-ml-sm mb-4">Para a utilização do E-mail no sistema, sugerimos que faça a utilização do <span class="text-blue-500">G-mail</span>, sendo necessário para esse as <span class="text-blue-500 hover:border-b border-black"><a target="_blank" href="https://support.google.com/accounts/answer/185833?hl=pt-BR">senha de app</a></span>.</span>
                
                <span class="q-ml-sm">Caso seja necessário fazer a configuaração de outro provedor, confira todos os detalhes com os mesmos antes! Caso necessário, entre em contato pelos meios de comunicação:</span>
                <span class="q-ml-sm border p-2 mt-2 rounded shadow-sm">
                    <span class="flex">E-mail: aaa</span>
                    <span class="flex">Telefone 1: +55 49 99948-2859</span>
                    <span class="flex">Telefone 2: +55 49 98915-3821</span>
                    <span class="flex">Telefone 3: +55 86 98177-8690</span>
                </span>
            </q-card-section>
            <q-card-actions align="right">
                <q-btn flat label="Fechar" color="primary" @click="close()"/>
            </q-card-actions>
        </q-card>
    </q-dialog>
</template>

<script setup lang="ts">
import { ref } from 'vue';

    const props = defineProps<{
        showInformationsOfMail: boolean
    }>();

    const emits = defineEmits<{
        (e: 'close', value: boolean)
    }>();

    let show = ref<boolean>(true);

    const close = () => {
        show.value = false;
        emits('close', true);
    };

    document.addEventListener('keydown', (event: KeyboardEvent) => {
        const keyName = event.key;

        if(keyName === 'Escape')
        {
            close();  
        };
    });
</script>