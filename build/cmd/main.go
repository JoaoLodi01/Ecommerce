package main

import (
	"log"

	"g2l.boot/internal"
	"g2l.boot/pkg"
)

func main() {
	ip := internal.GetLocalIP()
	log.Println("Rodando no IP: ", ip)

	go func() {
		pkg.Start(
			"C:/Gabriel/Projetos/G2L_DevHouse/Ecommerce/G2L_Front",
			"D:/Gabriel/Projetos/G2L_DevHouse/Ecommerce/G2L_Front",
		)
		log.Println("Vai tentar entrar na pasta: G2L_Front")
	}()

	go func() {
		pkg.Start(
			"C:/Gabriel/Projetos/G2L_DevHouse/Ecommerce/G2L_BackEnd",
			"D:/Gabriel/Projetos/G2L_DevHouse/Ecommerce/G2L_BackEnd",
		)
		log.Println("Vai tentar entrar na pasta: G2L_BackEnd")
	}()

}
