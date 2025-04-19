<template>
    <div>
        <h1>Relatório de erros</h1>
    </div>

    <q-btn 
        color="primary" 
        icon="close"
        @click="close()" 
    />
</template>

<script>
    export default{
        methods:{ 
            close()
            {
                this.$emit('close', false)
            }
        },

        emits: [
            'close'
            
        ]
    }
</script>