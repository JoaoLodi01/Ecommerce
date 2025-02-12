<template>
    <h1>Estoque</h1>
    <table>
        <td>Nome: {{ "a" }}</td>
        <td>Nome: {{ "b" }}</td>
        <td v-if="module === 'hotelCreate'">Nome: {{ "c" }}</td>
        <td>Nome: {{ "d" }}</td>
    </table>
</template>

<script>
    export default {
        props: {
            module: {
                type: String,
                required: true
            }
        }
    }
</script>