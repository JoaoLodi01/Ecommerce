<template>
    <div>
      <h1>Conectar ao WhatsApp</h1>
      <div v-if="qrCode">
        <p>Escaneie o QR Code para autenticação:</p>
        <img :src="qrCode" alt="QR Code" />
      </div>
      <div v-else>
        <p>Aguardando autenticação...</p>
      </div>
    </div>
  </template>
  
  <script>
  import { connectToWhatsApp } from "../../services/whats/index"
  
  export default {
    data() {
      return {
        qrCode: null, // Armazenar o QR Code retornado pela API
      }
    }, 
    methods: {
      async fetchQRCode() {
        try {
          const response = await connectToWhatsApp();
          if (response.status === "Aguardando autenticação") {
            this.qrCode = response.qr; // Recebe o QR Code da API
          }
        } catch (error) {
          console.error('Erro ao conectar ao WhatsApp:', error);
        }
      },
    },
  
    mounted() {
      this.fetchQRCode(); // Chama o método para buscar o QR Code assim que o componente é montado
    },
  };
  </script>
  