<template>
    <div class="fixed inset-0 z-50 flex items-center justify-center bg-opacity-40 backdrop-blur-sm">
        <div class="bg-white p-8 rounded-xl shadow-lg flex flex-col items-center gap-4">
            <h1 class="text-2xl"><b>Produto</b>: {{ props.productName }}</h1>
            <div class="flex">
                <q-btn 
                    label="R$"
                    class="h-[3.4rem] mt-auto mb-auto"
                    outline
                    flat
                    :class="{
                        'bg-black text-white': typeAddition === 'R$'

                    }"
                    @click="typeAddition = 'R$'"
                />

                <q-btn 
                    label="%"
                    class="h-[3.4rem] mt-auto mb-auto"
                    outline
                    flat
                    @click="typeAddition = '%'"
                    :class="{
                        'bg-black text-white': typeAddition === '%'
                        
                    }"
                />

                <q-input 
                    v-model.number="addition" 
                    type="text" 
                    :label="`Acréscimo ${typeAddition}`"
                    outlined
                />
                
            </div>

            <div class="flex">
                <q-btn 
                    label="R$"
                    class="h-[3.4rem] mt-auto mb-auto"
                    outline
                    flat
                    @click="typeDiscount = 'R$'"
                    :class="{
                        'bg-black text-white': typeDiscount === 'R$'
                        
                    }"
                    
                />
                <q-btn 
                    label="%"
                    class="h-[3.4rem] mt-auto mb-auto"outline
                    flat
                    @click="typeDiscount = '%'"
                    :class="{
                        'bg-black text-white': typeDiscount === '%'
                        
                    }"
                    
                />
                <q-input 
                    v-model.number="discount"
                    type="text" 
                    :label="`Desconto ${typeDiscount}`"
                    outlined
                />
            </div>

            <div>
                <q-btn 
                    :style="`background-color: ${buttonColor}; color: ${textColor === '#ffffff' ? '#000' : '#ffffff'}`"
                    label="Aplicar"
                    class='mr-5'
                    @click="apply" 
                />
                
                <q-btn 
                    color="red"
                    label="Cancelar" 
                    @click="emits('close', true)" 
                />
            </div>
        </div>
    </div>
</template>

<script setup lang="ts">
    import { LocalStorage } from 'quasar';
    import { ref } from 'vue';

    const emits = defineEmits<{
        (e: 'apply', value: TReturnValues)
        (e: 'close', value: boolean),
        
    }>();

    const props = defineProps<{
        productName: string
    }>();

    const buttonColor = LocalStorage.getItem("buttonColor");
    const textColor = LocalStorage.getItem("textColor");

    let typeAddition = ref<string>('R$');
    let typeDiscount = ref<string>('R$');
    let addition = ref<number>(0);
    let discount = ref<number>(0);

    const apply = () =>
    {
        const data: TReturnValues = {
            typeAddition: typeAddition.value,
            addition: addition.value,
            typeDiscount: typeDiscount.value,
            discount: discount.value
        };

        emits('apply', data);
    }
</script>