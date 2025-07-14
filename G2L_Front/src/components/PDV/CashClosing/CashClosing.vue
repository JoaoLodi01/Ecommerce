<template>
    <div 
        class="bg-slate-600 text-white p-10 container text-2xl rounded-lg"
        
    >
        <div 
            class=""
            v-if="options_"
        >
            <div class="">
                <span class="cursor-pointer" @click="close()">X</span>
                <h3 class="text-center">Fechamento de caixa</h3>

            </div>
    
            <div class="flex justify-center m-3">
                <q-btn label="Período" class="mr-10 text-lg" @click="open('p')" />
                <q-btn label="Dia" class="text-lg" @click="open('d')" />
    
            </div>

        </div>
        
        <div class="">
            <Period
                v-if="periodClose"
            />

            <Day
                v-if="dayClose"
            />
        </div>
    </div>
</template>

<script>
    import Day from './Day.vue';
    import Period from './Period.vue';

    export default {
        data()
        {
            return {
                options_: true,
                periodClose: false,
                dayClose: false,
                
            }
            
        },

        methods: {
            close()
            {
                this.$emit("closeCashClosing", false)
            },

            open(choose)
            {
                this.options_ = false
                if(choose === 'p')
                {
                    this.periodClose = true

                } else {
                    this.dayClose = true
                }
                
            }
        },
        emits: [
            'closeCashClosing'
        ],

        components: {
            Day,
            Period
        }
    }
</script>

<style>
    .container{ 
        position: relative;
        left: 35rem;
        top: 6rem;
    }
</style>