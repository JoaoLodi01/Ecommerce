package pkg

import (
	"fmt"
	"log"
	"net"
	"os"
	"os/exec"
)

func ExecuteCommand(path, local string, ip net.IP) error {
	switch local {
	case "ecommerceFront":
		cmd := exec.Command("npm", "run", "dev")
		cmd.Dir = path
		cmd.Stdout = os.Stdout
		cmd.Stderr = os.Stderr

		if err := cmd.Start(); err != nil {
			log.Println("Erro ao executaro o comando:", err)
			return err

		}

		return nil

	case "ecommerceBack":
		sIP := fmt.Sprintf("--host=%s", ip.String())

		log.Println("Log sIP:", sIP)

		cmd := exec.Command("php", "artisan", "serve", sIP)
		cmd.Dir = path
		cmd.Stdout = os.Stdout
		cmd.Stderr = os.Stderr

		if err := cmd.Start(); err != nil {
			log.Println("Erro ao executaro o comando:", err)
			return err

		}

		log.Println("Vai executar o ecommerceBack")
		return nil

	case "coreFront":
		port := fmt.Sprintln("-p 9090")
		cmd := exec.Command("npm", "run", "dev", port)

		cmd.Dir = path
		cmd.Stdout = os.Stdout
		cmd.Stderr = os.Stderr

		if err := cmd.Start(); err != nil {
			log.Println("Erro ao executaro o comando:", err)
			return err

		}

		log.Println("Vai executar o ecommerceBack")
		return nil

	}

	return nil
}
