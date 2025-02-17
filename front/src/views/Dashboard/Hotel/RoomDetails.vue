<template>
    <header class="">
        <h2>Todos os quartos</h2>

    </header>
    <div>
        <button @click="showPayMent">Reservar</button>
    </div>

    <PaymentsForm
        v-if="show"
        :show="this.show"
    />
</template>

<script>
import PaymentsForm from '@/views/components/PaymentsForm.vue';

    export default {
        data(){
            return {
                show: false
            }
        },
        components: {
            PaymentsForm
        },
        methods: {
            showPayMent(){
                this.show = !this.show

            }
        }
        
    }
</script>