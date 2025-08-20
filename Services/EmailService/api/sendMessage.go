package api

import (
	"context"
	"errors"
	"fmt"
	"log"
	"os"
	"path/filepath"
	"runtime"

	"g2l.email/internal"
	gomail "gopkg.in/mail.v2"

	"database/sql"

	_ "github.com/go-sql-driver/mysql"

	"github.com/joho/godotenv"
)

func SendMessage(dialData internal.Dial) (string, error) {
	log.Println("Vai fazer o envio...")
	message := gomail.NewMessage()

	message.SetHeader("From", dialData.From)
	message.SetHeader("To", dialData.To)
	message.SetHeader("Subject", dialData.Subject)

	message.SetBody("text/plain", dialData.Message)

	dialer := gomail.NewDialer(dialData.Host, dialData.Port, dialData.Username, dialData.Password)

	if err := dialer.DialAndSend(message); err != nil {
		log.Println("Erro:", err)
		return "", err

	} else {
		log.Println("Envio com sucesso!")
		return "Envio com sucesso!", nil
	}
}

func SendMessageHTML(dialData internal.Dial) (string, error) {
	log.Println("Vai fazer o envio em HTML...")
	m := gomail.NewMessage()

	m.SetHeader("From", dialData.From)
	m.SetHeader("To", dialData.To)
	m.SetHeader("Subject", dialData.Subject)

	m.SetBody("text/plain", "Teste")

	htmlBody := fmt.Sprintln(`
		<html>
			<body>
				<div class="container">
					<h1>Teste de envio de e-mail</h1>

					<section class="content">
						<p>Esse é um envio de e-mail de teste da G2L DevHouse, se você não cadastrou seu e-mail em nossos serviços ou não permite o uso desse e-mail para uso de envio de mensagens, por favor entre em contato no e-mail: g2ldevhouse@gmail.com</p>
					</section>
				</div>
			</body>

			<style>
				* {
					margin: 0;
					padding: 0;
					
				}

				html {
					font-size: 40px;
					font-family: Arial, Helvetica, sans-serif;

				}

				.container { 
					border: solid #000;      
				}

				.container h1 {
					border-bottom: solid 1px#000;
					margin-bottom: 1rem;
					text-align: center;

				}

				.container .userNameEmail {
					text-decoration: none;
					color: #000;
				}

				.container .content {
					display: flex;
					justify-content: center;
					padding: 5px;
					margin-bottom: 1rem;
				}
			</style>
		</html>
	`)

	_, thisFile, _, ok := runtime.Caller(0)

	if !ok {
		return "", errors.New("erro ao encontrar o caminho atual")
	}

	thisDir := filepath.Dir(thisFile)

	log.Println("Buscando arquivos em thisFile ...", thisFile)
	log.Println("Buscando arquivos em ...", thisDir)

	attachPath := filepath.Join(thisDir, "files", "teste.xls")

	log.Println("Caminho do arquivo final: ", attachPath)

	if _, err := os.Stat(attachPath); err != nil {
		return "", errors.New("arquivo não encontrado")

	}

	m.Attach(attachPath)

	m.AddAlternative("text/html", htmlBody)

	dialer := gomail.NewDialer(dialData.Host, dialData.Port, dialData.Username, dialData.Password)

	if err := dialer.DialAndSend(m); err != nil {
		log.Println("Erro:", err)
		return "", err

	} else {
		log.Println("Envio com sucesso!")
		return "Envio com sucesso!", nil
	}
}

// dialData internal.Dial
func SendReportMessage() (string, error) {
	err := godotenv.Load()
	if err != nil {
		log.Fatal("Erro ao carregar .env")

	}

	dbConfig := fmt.Sprintf(
		// username:password@tcp(host:port)/dbname?charset=utf8mb4&parseTime=True&loc=Local
		"%s:%s@tcp(%s:%s)/%s?charset=utf8mb4&parseTime=True&loc=Local",
		os.Getenv("DB_USERNAME"), os.Getenv("DB_PASSWORD"), os.Getenv("DB_HOST"), os.Getenv("DB_PORT"), os.Getenv("DB_DATABASE"),
	)

	db, _ := sql.Open("mysql", dbConfig)

	stringQuery, _ := os.ReadFile("Services/EmailService/db/queryReportSales/query.sql")

	defer db.Close()

	query := string(stringQuery)

	ctx := context.Background()

	rows, _ := db.QueryContext(ctx, query)

	defer rows.Close()

	for rows.Next() {
		var n_note int
		var sale string
		var description string
		var net_value float32

		if err := rows.Scan(&n_note, &sale, &description, &net_value); err != nil {
			fmt.Println(n_note, sale, description, net_value)
		}
	}

	return "Envio bem sucedido!", nil
}
