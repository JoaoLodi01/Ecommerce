package main

import (
	"encoding/json"
	"log"
	"net/http"

	"g2l.email.com/cors"
)

func main() {
	mx := http.NewServeMux()

	mx.HandleFunc("/api/v1/email/home", func(w http.ResponseWriter, r *http.Request) {

		if r.Method == http.MethodGet {
			json.NewEncoder(w).Encode(map[string]any{
				"success": false,
				"status":  http.StatusMethodNotAllowed,
				"message": "método não suportado",
			})
			return
		}

		log.Println("Passou no home")
		json.NewEncoder(w).Encode(map[string]any{
			"status":  "ok",
			"success": true,
			"message": "Serviço ok",
		})
	})

	handler := cors.WithCORS(mx)

	log.Println("URL: localhost:3030/api/v1/email/")
	log.Fatal(http.ListenAndServe(":3030", handler))
}
