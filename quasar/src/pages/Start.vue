<template>
    <div 
        class="text-xl mr-5 ml-16 mt-10"
        v-if="showStart"
    >
        <div class="rounded-lg p-2 flex items-center gap-4 text-3xl">
            <div class="font-semibold">
                <h2>Bem Vindo!</h2>
            </div>

            <div class="text-gray-400">
                <h4>{{ !ignore ? 'Primeiros passos para o uso do site!' : 'DashBoard' }}</h4>
            </div>
        </div>

        <div class="w-full max-w-3xl" v-if="!ignore">
            <div class="flex bg-white rounded-lg gap-4 mb-6 p-3 shadow-md">
                <CompleteOrNo :label="completeIssuer" class="mt-0.5"/>
                <router-link :to="`/${issuerName}/companie-data`">
                    <span class="text-blue-500 font-semibold">
                        Passo 1:
                    </span>    
                    Completar cadastro do emitente
                </router-link>
            </div>

            <div class="flex bg-white rounded-lg gap-4 mb-6 p-3 shadow-md">
                <CompleteOrNo :label="completeConfigProducts" class="mt-0.5"/>
                <router-link :to="`/${issuerName}/products`">
                    <span class="text-blue-500 font-semibold">
                        Passo 2:
                    </span> 
                    Cadastre seu primeiro produto
                </router-link>
            </div>

            <div class="flex bg-white rounded-lg gap-4 mb-6 p-3 shadow-md">
                <CompleteOrNo :label="completeConfigCustomer" class="mt-0.5"/>
                <router-link :to="`/${issuerName}/customers`">
                    <span class="text-blue-500 font-semibold">
                        Passo 3:
                    </span> 
                    Cadastre seu primeiro cliente
                </router-link>
            </div>

            <div class="flex bg-white rounded-lg gap-4 mb-6 p-3 shadow-md">
                <CompleteOrNo :label="completeConfigPDV" class="mt-0.5"/>
                <router-link :to="`/${issuerName}/`">
                    <span class="text-blue-500 font-semibold">
                        Passo 4:
                    </span>
                    Configure seu PDV
                </router-link>
            </div>
            <div class="flex justify-end">
                <q-checkbox 
                    right-label 
                    v-model="ignore" 
                    label="Ignorar primeiros passos" 
                    class="mb-3"
                    color="grey"
                    @update:model-value="ignoreFirstSteps()"
                />

            </div>
            
        </div>
    </div>
</template>

<script setup lang="ts">
    import { LocalStorage } from 'quasar';
    import { api } from 'src/boot/axios';
    import { ref, onMounted } from 'vue';
    import { useRoute } from 'vue-router';
    import CompleteOrNo from 'src/components/Start/CompleteOrNo.vue';

    const route = useRoute();

    let ignore = ref<boolean>(false);
    let showStart = ref<boolean>(true);
    let completeIssuer = ref<boolean>(false);
    let completeConfigPDV = ref<boolean>(false);
    let completeConfigCustomer = ref<boolean>(false);
    let completeConfigProducts = ref<boolean>(false);
    let issuerName = ref<string>('');

    const returnValue = (value: number): boolean => { return value === 1 ? true : false; };

    const completed = async () =>
    {
        const response = await api.get(`/first-steps/${LocalStorage.getItem("issuer_id")}`);
        const data = response.data.data;
        console.log(data);
        
        ignore.value = returnValue(data.ignore_first_steps);
        completeIssuer.value = returnValue(data.complete_issuer);
        completeConfigPDV.value = returnValue(data.complete_pdv);
        completeConfigCustomer.value = returnValue(data.complete_customers);
        completeConfigProducts.value = returnValue(data.complete_products);

        LocalStorage.set("ignore", ignore.value);
        
    };

    const ignoreFirstSteps = async () =>
    {
        const res = await api.put(`/first-steps/${LocalStorage.getItem("issuer_id")}`)
        const data = res.data.data;
        console.log(data);

        if(data.success && data.ignore)
        {
            ignore = data.ignore;
        };
    };
        
    onMounted(async () => 
    {
        issuerName.value = route.params.name as string;
        await completed();

    });
</script>