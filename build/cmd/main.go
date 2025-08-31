package main

import (
	"log"
	"sync"

	"g2l.boot/internal"
	"g2l.boot/pkg"
)

func main() {
	var wg sync.WaitGroup
	ip := internal.GetLocalIP()
	log.Println("Rodando no IP: ", ip)
	wg.Add(2)

	go func() {
		log.Println("=- Ecommerce/G2L_Front -=")
		path, err := pkg.Start(
			"D:/Gabriel/Projetos/G2L_DevHouse/Ecommerce/G2L_Front",
			"C:/Gabriel/Projetos/G2L_DevHouse/Ecommerce/G2L_Front",
		)

		if err != nil {
			log.Println("Erro: no /Ecommerce/G2L_Front:", err)
		}

		if err := pkg.ExecuteCommand(path, "ecoG2LFront", ip); err != nil {
			log.Println("Erro ao executar o comando:", err)

		} else {
			log.Println("Rodando /Ecommerce/G2L_Front...")
			wg.Done()

		}
	}()

	go func() {
		log.Println("=- Ecommerce/G2L_BackEnd -=")
		path, err := pkg.Start(
			"D:/Gabriel/Projetos/G2L_DevHouse/Ecommerce/G2L_BackEnd",
			"C:/Gabriel/Projetos/G2L_DevHouse/Ecommerce/G2L_BackEnd",
		)

		if err != nil {
			log.Println("Erro: no /Ecommerce/G2L_BackEnd:", err)
		}

		if err := pkg.ExecuteCommand(path, "ecoG2LBack", ip); err != nil {
			log.Println("Erro ao executar o comando:", err)

		} else {
			log.Println("Rodando /Ecommerce/G2L_BackEnd...")
			wg.Done()

		}
	}()

	wg.Wait()
}
