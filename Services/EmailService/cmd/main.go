package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"

	"g2l.email/api"
	"g2l.email/internal/cors"
	models "g2l.email/pkg/models/dial"
)

func main() {
	mux := http.NewServeMux() // Novo servidor para uso do cors

	// Rota principal, apenas verificar se está ok o "servidor"
	mux.HandleFunc("/api/v1/email/home", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json; charset=utf-8")
		log.Println("Passou pelo /api/v1/email/home")

		if r.Method != http.MethodGet {
			w.WriteHeader(http.StatusInternalServerError)

			json.NewEncoder(w).Encode(map[string]any{
				"success": false,
				"status":  http.StatusMethodNotAllowed,
				"message": "Método não suportado",
			})
			return

		}

		json.NewEncoder(w).Encode(map[string]any{
			"success": true,
			"status":  http.StatusOK,
			"message": "Serviço em operação",
		})
	})

	//Rota para o envio do e-mail, esperando o type dialType

	mux.HandleFunc("/api/v1/email/send-message", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json; charset=utf-8")
		log.Println("Passou pelo /api/v1/email/send-message")

		if r.Method != http.MethodPost {
			w.WriteHeader(http.StatusInternalServerError)

			json.NewEncoder(w).Encode(map[string]any{
				"success": false,
				"status":  http.StatusMethodNotAllowed,
				"message": "Método não suportado",
			})
			return
		}

		var dial models.Dial

		if err := json.NewDecoder(r.Body).Decode(&dial); err != nil {
			w.WriteHeader(http.StatusInternalServerError)
			log.Println("JSON Inválido")
			json.NewEncoder(w).Encode(map[string]any{
				"success": false,
				"status":  http.StatusBadRequest,
				"error":   err,
				"message": "JSON Inválido",
			})
			return
		}

		msg, err := api.SendMessage(dial)

		if err != nil {
			w.WriteHeader(http.StatusInternalServerError)
			log.Println("Erro no envio do e-mail")
			json.NewEncoder(w).Encode(map[string]any{
				"success": false,
				"status":  http.StatusBadRequest,
				"error":   err,
				"message": err,
			})
			return
		}

		json.NewEncoder(w).Encode(map[string]any{
			"success": true,
			"status":  http.StatusOK,
			"message": msg,
		})
	})

	mux.HandleFunc("/api/v1/email/send-message/test", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json; charset=utf-8")
		log.Println("Passou pelo /api/v1/email/send-message")

		if r.Method != http.MethodPost {
			w.WriteHeader(http.StatusInternalServerError)

			json.NewEncoder(w).Encode(map[string]any{
				"success": false,
				"status":  http.StatusMethodNotAllowed,
				"message": "Método não suportado",
			})
			return
		}

		var dial models.Dial

		if err := json.NewDecoder(r.Body).Decode(&dial); err != nil {
			w.WriteHeader(http.StatusInternalServerError)
			log.Println("JSON Inválido")
			json.NewEncoder(w).Encode(map[string]any{
				"success": false,
				"status":  http.StatusBadRequest,
				"error":   err,
				"message": "JSON Inválido",
			})
			return
		}

		msg, err := api.SendMessageHTML(dial)

		if err != nil {
			w.WriteHeader(http.StatusInternalServerError)
			log.Println("Erro no envio do e-mail")
			json.NewEncoder(w).Encode(map[string]any{
				"success": false,
				"status":  http.StatusBadRequest,
				"error":   err,
				"message": err,
			})
			return
		}

		json.NewEncoder(w).Encode(map[string]any{
			"success": true,
			"status":  http.StatusOK,
			"message": msg,
		})
	})

	handler := cors.WithCORS(mux)
	addr := ":3031"

	log.Println("Servidor rodando em: localhost:3030")
	log.Println("Rota home: localhost:3030/api/v1/email/home")

	fmt.Println(api.SendReportMessage())

	log.Fatal(http.ListenAndServe(addr, handler))
}
