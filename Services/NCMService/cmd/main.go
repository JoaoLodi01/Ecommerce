package main

import (
	"log"
	"net/http"

	"g2l.ncm/cors"
)

func main() {
	mx := http.NewServeMux()

	handler := cors.WithCORS(mx)

	if err := http.ListenAndServe(":3300", handler); err != nil {
		log.Println("Erro ao iniciar o servidor:", err)
	}

	log.Println("Serviço do NCM rodando em localhost:3300")
}
