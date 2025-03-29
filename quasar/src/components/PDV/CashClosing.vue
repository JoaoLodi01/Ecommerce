<template>
    <div>
       <h1>Fechamento de caixa</h1> 

       <button @click="close">Fechar</button>
    </div>
</template>

<script>
    export default {
        methods: {
            close()
            {
                this.$emit("closeCashClosing", false)
           
            },

            
        },
        emits: [
            'closeCashClosing'
        ]
    }
</script>