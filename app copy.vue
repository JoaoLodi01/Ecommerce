<template>
    <button @click="add()">Add</button>
    <p>{{ sum }}</p>
</template>

<script>
    export default {
        data()
        {
            return {
                sum: 0
                
            }
            
        },
        methods: {
            add()
            {
                this.sum += 1
            }
        },
    }
</script>