package api

import (
	"errors"
	"fmt"
	"log"
	"os"
	"path/filepath"
	"runtime"

	models "g2l.email/pkg/models/dial"
	reportModel "g2l.email/pkg/models/report"
	removeFile "g2l.email/pkg/store"
	gomail "gopkg.in/mail.v2"
)

func SendMessage(dialData models.Dial) (string, error) {
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

func SendMessageHTML(dialData models.Dial) (string, error) {
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

// dialData models.Dial
func SendReportMessage(r reportModel.ReportSale) (string, error) {
	reportPath, err := BuildReport(r.TypeReport, r.IssuerID)
	m := gomail.NewMessage()

	if err != nil {
		log.Println("Erro ao gerar o relatório: ", err)
		return "", err

	}

	log.Println("Caminho do arquivo in SendReportMessage: ", reportPath)

	dial := gomail.NewDialer("smtp.gmail.com", 587, "gabikochem55@gmail.com", "cslz hbjx plgi tjcm")

	m.SetHeader("From", "gabikochem55@gmail.com")
	m.SetHeader("To", "gabikochem55@gmail.com")
	m.SetHeader("Subject", "Relatório de vendas")
	m.Attach(reportPath)

	if err := dial.DialAndSend(m); err != nil {
		log.Println("Erro ao enviar no e-mail: ", err)
		return "", err

	} else {
		log.Println("Envio bem sucedido! - Vai chamar o método para excluir")

		if err := removeFile.DeleteAfterSend(reportPath, r.IssuerID); err != nil {
			log.Println("Erro no DeleteAfterSend: ", err)
			return "", err

		}

		log.Println("Arquivo enviado e excluído do path")
	}

	return "Enviando relatório", nil
}
