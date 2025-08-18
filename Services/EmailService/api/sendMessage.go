package api

import (
	"fmt"
	"log"

	"g2l.email/internal"
	gomail "gopkg.in/mail.v2"
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
	message := gomail.NewMessage()

	message.SetHeader("From", dialData.From)
	message.SetHeader("To", dialData.To)
	message.SetHeader("Subject", dialData.Subject)

	message.SetBody("text/plain", dialData.Message)

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

	message.AddAlternative("text/html", htmlBody)

	dialer := gomail.NewDialer(dialData.Host, dialData.Port, dialData.Username, dialData.Password)

	if err := dialer.DialAndSend(message); err != nil {
		log.Println("Erro:", err)
		return "", err

	} else {
		log.Println("Envio com sucesso!")
		return "Envio com sucesso!", nil
	}
}
