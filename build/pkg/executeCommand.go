package pkg

import (
	"log"
	"net"
	"os"
	"os/exec"
)

func ExecuteCommand(path, local string, ip net.IP) error {
	log.Println("Path a ser executado: ", path)
	switch local {
	case "ecoG2LFront":
		cmd := exec.Command("npm", "run", "dev")
		cmd.Dir = path
		cmd.Stdout = os.Stdout
		cmd.Stderr = os.Stderr

		if err := cmd.Run(); err != nil {
			log.Println("Erro ao executaro o comando:", err)
			return err
		}

		return nil

	case "ecoG2LBack":
		
	}

	return nil
}
