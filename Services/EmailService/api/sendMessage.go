package api

import (
	"errors"
	"fmt"
	"log"
	"os"
	"path/filepath"
	"runtime"

	"g2l.email/db/conn"
	dialModel "g2l.email/pkg/models/dial"
	reportModel "g2l.email/pkg/models/report"
	removeFile "g2l.email/pkg/store"
	gomail "gopkg.in/mail.v2"
)

func SendMessage(dialData dialModel.Dial) (string, error) {
	log.Println("Vai fazer o envio...")
	m := gomail.NewMessage()

	m.SetHeader("From", dialData.Username)
	m.SetHeader("To", dialData.Username)
	m.SetHeader("Subject", "Teste de envio")

	m.SetBody("text/plain", "Teste de envio")

	dialer := gomail.NewDialer(dialData.Host, int(dialData.Port), dialData.Username, dialData.Password)

	if err := dialer.DialAndSend(m); err != nil {
		log.Println("Erro:", err)
		return "", err

	} else {
		log.Println("Envio com sucesso!")
		return "Envio com sucesso!", nil
	}
}

func SendMessageHTML(dialData dialModel.Dial) (string, error) {
	log.Println("Vai fazer o envio em HTML...")
	m := gomail.NewMessage()

	m.SetHeader("From", dialData.Username)
	m.SetHeader("To", dialData.Username)
	m.SetHeader("Subject", "Teste de envio")

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

	dialer := gomail.NewDialer(dialData.Host, int(dialData.Port), dialData.Username, dialData.Password)

	if err := dialer.DialAndSend(m); err != nil {
		log.Println("Erro:", err)
		return "", err

	} else {
		log.Println("Envio com sucesso!")
		return "Envio com sucesso!", nil

	}
}

// dialData models.Dial
func SendReportMessage(r reportModel.ReportSale) error {
	d, err := buildDial(r.IssuerID)
	if err != nil {
		log.Println("Erro buildDial:", err)
		return err
	}

	reportPath, err := BuildReport(r)

	if err != nil {
		log.Println("Erro buildReport:", err)
		return err
	}

	m := gomail.NewMessage()

	log.Println("Caminho do arquivo in SendReportMessage: ", reportPath)
	log.Println("Dados dial: ", d)

	dial := gomail.NewDialer(d.Host, int(d.Port), d.Username, d.Password)

	m.SetHeader("From", r.From)
	m.SetHeader("To", r.To)
	m.SetHeader("Subject", "Relatório de vendas")
	m.Attach(reportPath)

	if err := dial.DialAndSend(m); err != nil {
		log.Println("Erro ao enviar o e-mail - line 166: ", err)
		return err

	} else {
		log.Println("Envio bem sucedido! - Vai chamar a função para excluir")

		if err := removeFile.DeleteAfterSend(reportPath, r.IssuerID); err != nil {
			log.Println("Erro no DeleteAfterSend: ", err)
			return err

		}

		log.Println("Arquivo enviado e excluído do path")
	}

	return nil
}

func buildDial(issuerID int) (dialModel.Dial, error) {
	log.Println(issuerID)

	var d dialModel.Dial

	db := conn.ConnDB()
	defer db.Close()
	_, thisFile, _, _ := runtime.Caller(0)

	upOne := filepath.Dir(filepath.Dir(thisFile))

	sqlByte := filepath.Join(upOne, "db", "querys", "dial", "dial.sql")
	sqlStr, err := os.ReadFile(sqlByte)

	if err != nil {
		log.Println("Erro ao ler o arquivo dial.sql:", err)
		return dialModel.Dial{}, err
	}

	rows, err := db.Query(string(sqlStr), issuerID)

	if err != nil {
		log.Println("Erro ao executar o dial.sql - line 206 buildDial")
		return dialModel.Dial{}, err
	}

	defer rows.Close()

	for rows.Next() {
		if err := rows.Scan(
			&d.Host,
			&d.Username,
			&d.Password,
			&d.Port,
		); err != nil {
			log.Println("Erro ao ler os dados do dial - line 215 buildDial: ", err)
			return dialModel.Dial{}, err

		}
	}

	if d.Host == "" || d.Password == "" {
		log.Println(d)
		return dialModel.Dial{}, errors.New("e-mail não configurado, por favor confirme seus dados nas configurações")

	}

	return d, nil
}
