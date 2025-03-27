<template>
    <div class="mr-20 text-center">
        <input
            type="text"
            class="border-none outline-none ml-2 mt-1 mb-1 w-96"
            v-model="productData.name"
            placeholder="Buscar.."
        />
    </div>
</template>

<script>
    export default {
        data()
        {
            return {
                produtcData:{
                    id:'',
                    name: ''
                },

            }
            
        },
        
        methods: {
            getProdutc
        }
    }

</script>