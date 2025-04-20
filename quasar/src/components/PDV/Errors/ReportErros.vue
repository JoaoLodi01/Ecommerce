<template>
    <div class="mt-4">
        <q-btn 
            color="primary" 
            icon="close"
            @click="close()" 
        />
        <h1>Relatório de erros</h1>
    </div>
    
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