<template>
    <div class="nfce-container">
        <h1 class="title">Estoque:</h1>

        <!-- Adicionar produto -->
        <div class="add-product">

            <label for="name">Produto:</label>
            <input v-model="product.name" type="text" id="name" placeholder="Inserir..." />

            <label for="quantity">Quantidade:</label>
            <input v-model="product.quantity" type="number" id="quantity" placeholder="Inserir..." />

            <label for="cost">Preço de custo:</label>
            <input v-model="product.cost" type="number" id="cost" placeholder="Inserir..." />

            <label for="sale">Preço de venda:</label>
            <input v-model="product.sale" type="number" id="sale" placeholder="Inserir..." />

            <label for="profit">% de lucro:</label>
            <input v-model="product.profit" type="number" id="profit" placeholder="Inserir..." />

            <label for="ncm">NCM:</label>
            <input v-model="product.ncm" type="number" id="ncm" placeholder="Inserir..." />

            <label for="cest">CEST:</label>
            <input v-model="product.cest" type="number" id="cest" placeholder="Inserir..." />

            <label for="csosn">CSOSN:</label>
            <input v-model="product.csosn" type="number" id="csosn" placeholder="Inserir..." />

            <label for="cfop">CFOP:</label>
            <input v-model="product.cfop" type="number" id="cfop" placeholder="Inserir..." />

            <button @click="addProduct">Cadastrar Produto</button>
        </div>

        <!-- Lista de Produtos -->
         <div class="product-list">
            <h2>Produtos Adicionados:</h2>
            <table>
                <thead>
                    <tr>
                        <th>Produto</th>
                        <th>Quantidade</th>
                        <th>Preço de Venda</th>
                        <th>CFOP</th>
                        <th>CSOSN</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(product, index) in products" :key="index">
                        <td>{{ product.name }}</td>
                        <td>{{ product.quantity }}</td>
                        <td>R$ {{ product.cost.toFixed(2) }}</td>
                        <td>R$ {{ product.sale.toFixed(2) }}</td>
                        <td>R$ {{ product.cfop }}</td>
                        <td>R$ {{ product.csosn }}</td>
                        <td><button @click="removeProduct(index)">Remover</button></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</template>

<script>

import axios from 'axios';

export default {
    data(){
        return{
            product: {
                name: '',
                quantity: '',
                cost: '',
                sale: '',
                profit: '',
                ncm: '',
                cest: '',
                csosn: '',
                cfop: '',
            }
        }
    },

    methods: {
        addProduct() {
        if (!this.product.name && !this.product.quantity){
          alert("Preencha as informações!");
          return;
        }

        this.products.push({ ...this.newProduct });

        this.newProduct = { name: '', price: 0, quantity: 1, discount: 0, addition: 0, csosn: ''}
      },

      removeProduct(index) {
        this.products.splice(index, 1);
      },
    },
}

</script>