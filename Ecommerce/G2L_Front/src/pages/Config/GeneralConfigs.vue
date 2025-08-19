<template>
    <div v-if="!showPage">
        <LoandingPage
            @show-page="showPage = $event"
            :text="'Carregando configurações gerais ...'"

        />

    </div>
    <div class="ml-16 text-2xl" v-if="showPage">
        <h1>Configurações gerais</h1>

        <div class="bg-white p-4 mb-4 rounded shadow-sm w-[99%]">
            <q-btn 
                :style="`background-color: ${showConfigs.showColorsConfig ? 'green' : buttonColor}; color: ${textColor}`" 
                label="Cores"
                @click="manageShowConfig('color')"
                class="mr-4"

            />

            <q-btn 
                :style="`background-color: ${showConfigs.showIssuanceConfig ? 'green' : buttonColor}; color: ${textColor}`" 
                label="Emissão"
                @click="manageShowConfig('issuance')"
                class="mr-4"

            />

            <q-btn 
                :style="`background-color: ${showConfigs.showCommunicationConfig ? 'green' : buttonColor}; color: ${textColor}`" 
                label="Gerais"
                @click="manageShowConfig('stock')"
                class="mr-4"
                
            />
        </div>
        
        <div v-if="showConfigs.showColorsConfig" class="w-[99%] flex gap-4 p-4 bg-white">
            <div class="border border-black p-3 rounded-lg">
                <h3>Cor dos botões</h3>
                
                <q-color    
                    v-model="colorOptions.buttonColor" 
                    :default-value="colorOptions.buttonColor"
                    class="my-picker" 
                    style="max-width: 250px;"
                />

                <div class="mt-4">
                    <span>Cor usada: {{ colorOptions.buttonColor }}</span>
                    <br>
                    <span>
                        Exemplo: 
                        <q-btn 
                            :style="`background-color: ${colorOptions.buttonColor}; color: ${colorOptions.buttonColor === '#ffffff' ? '#000' : '#ffffff'}`"
                            label="Finalizar venda" 
                            
                        /> 
                    
                    </span>

                </div>
            </div>
            
            <div class="border border-black p-3 rounded-lg bg-white">
                <h3>Cor dos painéis</h3>
                <q-color    
                    v-model="colorOptions.painelColor" 
                    :default-value="colorOptions.painelColor"
                    class="my-picker" 
                    style="max-width: 250px;"
                />

                <div class="mt-4">
                    <span>Cor usada: {{ colorOptions.painelColor }}</span>
                    <br>
                    <span class="flex">
                        Exemplo: 
                        
                        <div
                            :style="`background-color: ${colorOptions.painelColor}; color: ${colorOptions.painelColor === '#ffffff' ? '#000' : '#ffffff'}`"
                            class="rounded-md ml-2 w-36 h-8 mt-auto mb-auto"
                        >
                            
                        </div>
                    
                    </span>

                </div>
            </div>
            <div class="mt-4">
                <q-btn 
                    color="primary" 
                    icon="check" 
                    class="mr-4"
                    label="Salvar cor" 
                    @click="saveMyColor()" 
                />

                <q-btn 
                    color="primary"
                    label="Exportar cores"
                    @click="exportColors()" 
                />

            </div> 
        </div>       

        <div v-if="showConfigs.showCommunicationConfig" class="w-[99%] flex gap-4 p-4 bg-white">
            <div class="p-3 rounded-lg">
               <h2 class="border-b">Configurações</h2>

               <div class="mt-4 p-3 border rounded">
                    <div class="flex">
                        <h3>E-mail</h3>
                        <svg 
                            @click="showInformationsOfMail = !showInformationsOfMail"
                            xmlns="http://www.w3.org/2000/svg" 
                            fill="none" 
                            viewBox="0 0 24 24" 
                            stroke-width="1.5" 
                            stroke="currentColor" 
                            class="size-6 mb-auto mt-auto ml-1 cursor-pointer"
                        >
                            <path stroke-linecap="round" stroke-linejoin="round" d="m11.25 11.25.041-.02a.75.75 0 0 1 1.063.852l-.708 2.836a.75.75 0 0 0 1.063.853l.041-.021M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Zm-9-3.75h.008v.008H12V8.25Z" />
                        </svg>
                    </div>
                    
                    <DialogMoreInformation
                        :show-informations-of-mail="showInformationsOfMail"
                        @close="showInformationsOfMail = !$event"
                    />

                    <div class="box_ flex gap-3">
                        <q-input 
                            v-model="emailData.host"
                            type="text"
                            label="SMTP" 
                            @update:model-value="fixLowerCase"
                            :rules="[
                                val => !!val || 'Esse campo é obrigatório'
                            ]"

                        />

                        <q-input 
                            v-model="emailData.port"
                            type="text"
                            label="Porta"
                            maxlength="5"
                            :rules="[
                                val => !isNaN(Number(val)) || 'Esse campo precisa ser um número'
                            ]"

                        />
                        
                        <q-input 
                            v-model="emailData.userName"
                            type="text"
                            label="E-mail" 
                            :rules="[
                                val => !!val || 'Esse campo é obrigatório'
                            ]"

                        />
                        
                        <q-input 
                            v-model="emailData.password"
                            type="password"
                            label="Senha de app" 
                            :rules="[
                                val => !!val || 'Esse campo é obrigatório'
                            ]"

                        />

                        <q-select 
                            v-model="emailData.useTLS" 
                            :options="['no']" 
                            label="usar TLS"
                            class="w-32"
                            filled 
                            :rules="[
                                val => !!val || 'Esse campo é obrigatório'
                            ]"

                        />

                        <q-select 
                            v-model="emailData.useSSL" 
                            :options="['no']" 
                            label="usar SSL"
                            class="w-32"
                            filled 
                            :rules="[
                                val => !!val || 'Esse campo é obrigatório'
                            ]"

                        />
                    </div>

                    <div class="mt-4">
                        <div class="flex">
                            <div 
                                class="w-max mt-auto mb-auto ml-2  text-white rounded-lg p-1 cursor-pointer" 
                                :class="{
                                    'bg-green-400': blockSendMailTest,
                                    'bg-gray-400': !blockSendMailTest || emailData.host === '',
                                }"
                                title="Enviar e-mail teste" 
                                @click.prevent="blockSendMailTest && emailData.host !== '' && sendEmailTest()" 
                            >
                                <svg
                                    xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor" class="size-6">
                                    <path d="M8.75 2.75a.75.75 0 0 0-1.5 0v3.69l-.72-.72a.75.75 0 0 0-1.06 1.06l2 2a.75.75 0 0 0 1.06 0l2-2a.75.75 0 1 0-1.06-1.06l-.72.72V2.75Z" />
                                    <path d="M4.784 4.5a.75.75 0 0 0-.701.483L2.553 9h2.412a1 1 0 0 1 .832.445l.406.61a1 1 0 0 0 .832.445h1.93a1 1 0 0 0 .832-.445l.406-.61A1 1 0 0 1 11.035 9h2.412l-1.53-4.017a.75.75 0 0 0-.7-.483h-.467a.75.75 0 0 1 0-1.5h.466c.934 0 1.77.577 2.103 1.449l1.534 4.026c.097.256.147.527.147.801v1.474A2.25 2.25 0 0 1 12.75 13h-9.5A2.25 2.25 0 0 1 1 10.75V9.276c0-.274.05-.545.147-.801l1.534-4.026A2.25 2.25 0 0 1 4.784 3h.466a.75.75 0 0 1 0 1.5h-.466Z" />
                                </svg>
                            </div>

                            <div class="w-max mt-auto mb-auto ml-2 bg-blue-400 text-white rounded-lg p-1 cursor-pointer" @click="showMoreConfigEmail = !showMoreConfigEmail">
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M6.75 12a.75.75 0 1 1-1.5 0 .75.75 0 0 1 1.5 0ZM12.75 12a.75.75 0 1 1-1.5 0 .75.75 0 0 1 1.5 0ZM18.75 12a.75.75 0 1 1-1.5 0 .75.75 0 0 1 1.5 0Z" />
                                </svg>

                            </div>
                        </div>

                        <q-btn 
                            label="Salvar configurações" 
                            class="mt-4"
                            :style="`background-color: ${buttonColor}; color: ${textColor}`"
                            @click="saveEmailData()"

                        />
                        
                        <MoreConfigEmail
                            v-if="showMoreConfigEmail"
                            @close="showMoreConfigEmail = !$event"
                        />
                    </div>
               </div>

               <div class="mt-4 p-3 border rounded">
                    <h3>WhatsApp</h3>

                    <div v-if="isConnected" class="box_ flex gap-4 text-sm">
                        <span class="flex">
                            Número conectado: <span class="text-gray-700 border-b">{{ '+55 49 99948-2859' }}</span>

                            <div class="send mt-auto mb-auto ml-2 bg-green-400 text-white rounded-lg p-1 cursor-pointer" title="Enviar mensagem teste" >
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-5">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M6 12 3.269 3.125A59.769 59.769 0 0 1 21.485 12 59.768 59.768 0 0 1 3.27 20.875L5.999 12Zm0 0h7.5" />
                                </svg>
                            </div>

                            <div class="send mt-auto mb-auto ml-2 bg-red-400 text-white rounded-lg p-1 cursor-pointer" title="Sair">
                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor" class="size-5">
                                    <path d="M4.75 2A2.75 2.75 0 0 0 2 4.75v6.5A2.75 2.75 0 0 0 4.75 14h3a2.75 2.75 0 0 0 2.75-2.75v-.5a.75.75 0 0 0-1.5 0v.5c0 .69-.56 1.25-1.25 1.25h-3c-.69 0-1.25-.56-1.25-1.25v-6.5c0-.69.56-1.25 1.25-1.25h3C8.44 3.5 9 4.06 9 4.75v.5a.75.75 0 0 0 1.5 0v-.5A2.75 2.75 0 0 0 7.75 2h-3Z" />
                                    <path d="M8.03 6.28a.75.75 0 0 0-1.06-1.06L4.72 7.47a.75.75 0 0 0 0 1.06l2.25 2.25a.75.75 0 1 0 1.06-1.06l-.97-.97h7.19a.75.75 0 0 0 0-1.5H7.06l.97-.97Z" />
                                </svg>
                            </div>
                        </span>
                        
                    </div>

                    <div v-if="!isConnected">
                        <q-btn 
                            label="Conectar ao Whats" 
                            class="mt-4"
                            :style="`background-color: ${buttonColor}; color: ${textColor}`"
                            @click="connectWhats()"
    
                        />

                    </div>
               </div>
            </div>        
        </div>
    </div>

    <ImportFiles
        v-if="showImportFiles"
        :operation="'importColor'"
    />
</template>

<script setup lang="ts">
    import { useQuasar, LocalStorage } from 'quasar';
    import { api, apiEmail} from 'src/boot/axios';
    import { ref, onMounted } from 'vue';
    import ImportFiles from 'src/components/Files/ImportFiles.vue';
    import LoandingPage from 'src/components/Loanding/LoandingPage.vue';
    import MoreConfigEmail from 'src/components/Email/MoreConfigEmail.vue';
    import DialogMoreInformation from 'src/components/Email/DialogMoreInformation.vue';
    import camelcaseKeys from 'camelcase-keys';

    type TShowConfigs = {
        showColorsConfig: boolean,
        showIssuanceConfig: boolean,
        showCommunicationConfig: boolean,

    }

    interface IEmail {
        host: string,
        port: number|any,
        userName: string,
        password: string,
        useTLS: string,
        useSSL: string
    }
    
    const $q = useQuasar();

    const colorOptions = ref<TColorOptions>({
        buttonColor: '',
        painelColor: '',
        textColor: ''

    });

    const issuerID = ref<number>(LocalStorage.getItem("issuer_id"));
    const buttonColor = ref<string>(LocalStorage.getItem("buttonColor"));
    const textColor = ref<string>(LocalStorage.getItem("textColor"));

    const emailData = ref<IEmail>({
        host: '',
        port: null,
        userName: '',
        password: '',
        useTLS: 'no',
        useSSL: 'no'

    });

    const showConfigs = ref<TShowConfigs>({
        showColorsConfig: false,
        showIssuanceConfig: false,
        showCommunicationConfig: false,

    });

    let showPage = ref<boolean>(false);
    let showImportFiles = ref<boolean>(false);
    let isConnected = ref<boolean>(false);
    let showMoreConfigEmail = ref<boolean>(false);
    let showInformationsOfMail = ref<boolean>(false);
    let blockSendMailTest = ref<boolean>(true);

    const getConfigs = async () => 
    {
        const res = await api.get(`/configs/all-configs/${issuerID.value}`);
        console.log(res.data.data)

        if(res.data.success)
        {
            // Colors
            const colorData: TColorOptions = camelcaseKeys(res.data.data.color, { deep: true });
            colorOptions.value.buttonColor = colorData.buttonColor;
            colorOptions.value.painelColor = colorData.painelColor;
            colorOptions.value.textColor = colorData.textColor;

            //

            // Mail
            const mailData: IEmail = camelcaseKeys(res.data.data.emails, { deep: true });
            emailData.value = {
                host: mailData.host,
                port: mailData.port,
                userName: mailData.userName,
                password: mailData.password,
                useTLS: mailData.useTLS,
                useSSL: mailData.useSSL                
            };
            //
        };
    };

    const saveMyColor = async () =>
    {
        const res = await api.put(`/configs/color/update-config/${issuerID.value}`, {
            button_color: colorOptions.value.buttonColor,
            painel_color: colorOptions.value.painelColor

        });
        
        $q.notify({
            color: 'green',
            message: 'Salvando configurações!',
            timeout: 2000,
            position: 'top'

        });

        try {
            if(res.data.success)
            {
                LocalStorage.set("buttonColor", colorOptions.value.buttonColor);
                LocalStorage.set("painelColor", colorOptions.value.painelColor);
                
                $q.notify({
                    color: 'green',
                    message: 'Cores alterados com sucesso!',
                    timeout: 2000,
                    position: 'top'

                });
            };
        } catch (error) {
            $q.notify({
                color: 'red',
                message: error.response,
                timeout: 2000,
                position: 'top'

            });
        };
    };

    // E-mail
    const saveEmailData = async () =>
    {
        $q.notify({
            position: 'top',
            color: 'yellow',
            message: 'Processando dados...',
            timeout: 1200

        });
        const mail = emailData.value;
        const payLoad = {
            'host': mail.host,
            'port': mail.port,
            'userName': mail.userName,
            'password': mail.password,
            'useTLS': mail.useTLS,
            'useSSL': mail.useSSL
        
        };

        const res = await api.put(`/configs/email/update-email/${issuerID.value}`, payLoad);
        console.log(res.data);
        const data = res.data;

        if(data.success)
        {
            $q.notify({
                position: 'top',
                color: 'green',
                message: data.message,
                timeout: 1200
            });
        };
    };

    const sendEmailTest = async () =>
    {
        $q.notify({
            position: 'top',
            color: 'yellow',
            message: 'Processando dados...',
            timeout: 1200

        });

        blockSendMailTest.value = false;
        const mail = emailData.value;
        const payLoad = {
            'host': mail.host,
            'port': Number(mail.port),
            'userName': mail.userName,
            'password': mail.password,
            'from': mail.userName,
            'to': mail.userName,
            'subject': `Teste de envio`,
            'message': `Teste de envio`,
        };

        const res = await apiEmail.post('/api/v1/email/send-message', payLoad, {
            headers: {
                "Content-Type": "application/json"
            }
        });
        const data = res.data;

        console.log(data);
        if(data.success)
        {
            $q.notify({
                position: 'top',
                color: 'green',
                message: data.message,
                timeout: 1200

            });

            blockSendMailTest.value = true;
        };
    };
    //
    
    const connectWhats = async () =>
    {

    };

    const exportColors = async () =>
    {
        const res = await api.get(`/configs/color/export/${issuerID.value}`, {
            responseType: 'blob'
        });
        
        const url = window.URL.createObjectURL(new Blob([res.data], { type: 'application/json' }));

        const link = document.createElement('a');

        link.href = url;
        link.setAttribute('download', `Cores.json`);
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);

    };

    const fixLowerCase = (val: string) =>
    {
        emailData.value.host = val.toLocaleLowerCase();
    };

    const manageShowConfig = (config: string): void => 
    {
        switch (config) {
            case 'color':
                showConfigs.value.showColorsConfig = !showConfigs.value.showColorsConfig;
                showConfigs.value.showIssuanceConfig = false;
                showConfigs.value.showCommunicationConfig = false;
                break;
        
            case 'issuance':
                showConfigs.value.showIssuanceConfig = !showConfigs.value.showIssuanceConfig;
                showConfigs.value.showColorsConfig = false;
                showConfigs.value.showCommunicationConfig = false;
                break;

            case 'stock':
                showConfigs.value.showCommunicationConfig = !showConfigs.value.showCommunicationConfig;
                showConfigs.value.showIssuanceConfig = false;
                showConfigs.value.showColorsConfig = false;

                break;
            
            default:
                showConfigs.value = {
                    showColorsConfig: false,
                    showIssuanceConfig: false,
                    showCommunicationConfig: false,
                };
                break;
        };
    };

    onMounted(() => {
        getConfigs();
        
    });
</script>
