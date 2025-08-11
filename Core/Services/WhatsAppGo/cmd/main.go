package main

import (
	"encoding/json"
	"log"
	"net/http"

	"g2l.whatsapp.com/core"
	"g2l.whatsapp.com/cors"
)

type qrResponse struct {
	QR string `json:"qr"`
}

func main() {
	mux := http.NewServeMux()

<<<<<<< HEAD
	mux.HandleFunc("api/v1/whats/qr-code", func(w http.ResponseWriter, r *http.Request) {
=======
	mux.HandleFunc("/qr-code", func(w http.ResponseWriter, r *http.Request) {
		log.Println("Passou pela rota /qr-code")
>>>>>>> 47a7c115d643cd30d50760daf3dc74984de1c52e
		if r.Method != http.MethodGet {
			http.Error(w, "method not allowed", http.StatusMethodNotAllowed)
			return
		}

		qr, err := core.Login()

		if err != nil {
			w.Header().Set("Content-Type", "application/json; charset=utf-8")
			w.WriteHeader(http.StatusInternalServerError)
			json.NewEncoder(w).Encode(map[string]string{"error": err.Error()})
			return
		}

		w.Header().Set("Content-Type", "application/json; charset=utf-8")
		json.NewEncoder(w).Encode(qrResponse{QR: qr})

	})

	handler := cors.WithCORS(mux)

	addr := ":3000"
	log.Println("HTTP rodando em", addr)
	log.Fatal(http.ListenAndServe(addr, handler))

}
