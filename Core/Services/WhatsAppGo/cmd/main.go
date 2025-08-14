package main

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"time"

	"g2l.whatsapp.com/core"
	"g2l.whatsapp.com/cors"
)

type qrResponse struct {
	QR string `json:"qr"`
}

type sendMessages struct {
	Msg string `json:"msg"`
	To  string `json:"to"`
}

func main() {
	mux := http.NewServeMux()

	mux.HandleFunc("/api/v1/home", func(w http.ResponseWriter, r *http.Request) {
		fmt.Println("Whats home")

	})

	mux.HandleFunc("/api/v1/whats/qr-code", func(w http.ResponseWriter, r *http.Request) {
		log.Println("Passou pela rota /qr-code")

		if r.Method != http.MethodGet {
			http.Error(w, "method not allowed", http.StatusMethodNotAllowed)
			return
		}

		qr, err := core.Login()

		if err != nil {
			w.Header().Set("Content-Type", "application/json; charset=utf-8")
			w.WriteHeader(http.StatusInternalServerError)
			json.NewEncoder(w).Encode(map[string]string{"error": err.Error()})
			log.Println("[❌] Erro durante a execução")
			return
		}

		w.Header().Set("Content-Type", "application/json; charset=utf-8")
		json.NewEncoder(w).Encode(qrResponse{QR: qr})

	})

	mux.HandleFunc("/api/v1/whats/send-message", func(w http.ResponseWriter, r *http.Request) {
		if r.Method != http.MethodPost {
			json.NewEncoder(w).Encode(map[string]any{
				"error":  "método não suportado",
				"status": http.StatusMethodNotAllowed,
			})
			return
		}

		var req sendMessages

		if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
			//http.Error(w, "JSON inválido")
			json.NewEncoder(w).Encode(map[string]any{
				"error":  "JSON inválido",
				"status": http.StatusBadRequest,
			})
		}

		if !core.IsConnected() {
			http.Error(w, "Cliente não conectado", http.StatusServiceUnavailable)
			return
		}

		ctx, cancel := context.WithTimeout(r.Context(), 10*time.Second)
		defer cancel()

		msgID, err := core.SendText(ctx, req.To, req.Msg)
		if err != nil {
			json.NewEncoder(w).Encode(map[string]any{
				"message": "Falha no envio",
				"error":   err.Error(),
				"status":  http.StatusInternalServerError,
			})
			return

		}

		w.Header().Set("Content-Type", "application/json; charset=utf-8")
		json.NewEncoder(w).Encode(map[string]any{
			"status":     "resent",
			"to":         req.To,
			"message_id": msgID,
		})

	})

	handler := cors.WithCORS(mux)

	addr := ":3000"
	log.Println("Servidor do whats rodando em localhost:", addr)
	log.Fatal(http.ListenAndServe(addr, handler))

}
