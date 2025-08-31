package main

import (
	"log"

	"g2l.boot/internal"
	"g2l.boot/pkg"
)

func main() {
	ip := internal.GetLocalIP()
	log.Println("Rodando no IP: ", ip)

	frontEcommerce, err := pkg.Start(
		"D:/Gabriel/Projetos/G2L_DevHouse/Ecommerce/G2L_Front",
		"C:/Gabriel/Projetos/G2L_DevHouse/Ecommerce/G2L_Front",
	)

	if err != nil {
		log.Println("Erro ao retornar o caminho", err)

	}

	log.Println("Caminho a ser usado:", frontEcommerce)
	pkg.ExecuteCommand(frontEcommerce, "ecommerceFront", ip)

	backEcommerce, err := pkg.Start(
		"C:/Gabriel/Projetos/G2L_DevHouse/Ecommerce/G2L_BackEnd",
		"D:/Gabriel/Projetos/G2L_DevHouse/Ecommerce/G2L_BackEnd",
	)

	if err != nil {
		log.Println("Erro ao retornar o caminho", err)

	}

	log.Println("Caminho a ser usado:", backEcommerce)
	pkg.ExecuteCommand(backEcommerce, "ecommerceBack", ip)

}
