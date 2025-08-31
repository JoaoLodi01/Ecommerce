package main

import (
	"encoding/json"
	"log"
	"net"
	"net/http"

	"g2l.email/api"
	"g2l.email/internal/cors"
	dialModel "g2l.email/pkg/models/dial"
	reportModel "g2l.email/pkg/models/report"
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

		var dial dialModel.Dial

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

		var dial dialModel.Dial

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
				"error":   err.Error(),
				"message": "Erro no envio do e-mail teste",
			})
			return
		}

		json.NewEncoder(w).Encode(map[string]any{
			"success": true,
			"status":  http.StatusOK,
			"message": msg,
		})
	})

	mux.HandleFunc("/api/v1/email/send-report/pdv", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json; charset=utf-8")
		log.Println("Passou pelo /api/v1/email/send-report/pdv")

		if r.Method != http.MethodPost {
			w.WriteHeader(http.StatusInternalServerError)

			json.NewEncoder(w).Encode(map[string]any{
				"success": false,
				"status":  http.StatusMethodNotAllowed,
				"message": "Método não suportado",
			})
			return
		}

		var report reportModel.ReportSale

		if err := json.NewDecoder(r.Body).Decode(&report); err != nil {
			w.WriteHeader(http.StatusInternalServerError)
			log.Println("Dados do relatório inválido")
			json.NewEncoder(w).Encode(map[string]any{
				"success": false,
				"status":  http.StatusBadRequest,
				"message": "Dados do relatório inválido",
			})
			return
		}

		if err := api.SendReportMessage(report); err != nil {
			log.Println("Erro - line 172 - main: ", err)
			w.WriteHeader(http.StatusInternalServerError)
			json.NewEncoder(w).Encode(map[string]any{
				"success": false,
				"status":  http.StatusBadRequest,
				"error":   err.Error(),
				"message": "Erro no envio do e-mail",
			})
			return
		}

		json.NewEncoder(w).Encode(map[string]any{
			"success": true,
			"status":  http.StatusOK,
			"message": "Mensagem enviada com sucesso!",
		})
	})

	handler := cors.WithCORS(mux)
	addr := ":3030"

	conn, err := net.Dial("udp", "8.8.8.8:80")
	if err != nil {
		log.Fatal(err)
	}

	defer conn.Close()

	localAddress := conn.LocalAddr().(*net.UDPAddr)

	log.Printf("Servidor rodando em: %d:3030", localAddress.IP)
	log.Println("Rota home: localhost:3030/api/v1/email/home")

	log.Fatal(http.ListenAndServe(addr, handler))
}
