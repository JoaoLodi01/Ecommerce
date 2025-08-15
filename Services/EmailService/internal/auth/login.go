package auth

import (
	"fmt"
	"log"

	"g2l.email.com/internal/types"
	"github.com/wneessen/go-mail"
)

//joaolodi01@gmail.com
//teervrxwyllqoyyc
//smtp.gmail.com

func Auth() {
	var clint types.Auth

	clint.Mail = "teste"

	c, err := mail.NewClient(clint.Mail)

	if err != nil {
		log.Fatal("Erro ao encontrar o host")

	}

	fmt.Println(c)
}
