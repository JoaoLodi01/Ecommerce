package main

import (
	"fmt"
	"log"
	"net"
	"os"
	"os/exec"
)

func validateIsDir(p string) bool {
	if p == "" {
		return false
	}

	info, err := os.Stat(p)
	return err == nil && info.IsDir()
}

func validatePath(primary, fallback string) (string, error) {
	switch {
	case validateIsDir(primary):
		return primary, nil

	case validateIsDir(fallback):
		return fallback, nil

	default:
		return "", fmt.Errorf("Erro ao entrar nos caminhos: '%s' e '%s'", primary, fallback)
	}
}

func GetLocalIP() net.IP {
	conn, err := net.Dial("udp", "8.8.8.8:80")

	if err != nil {
		log.Fatal(err)
	}

	defer conn.Close()

	localAddress := conn.LocalAddr().(*net.UDPAddr)

	return localAddress.IP
}

func StartServers(ip net.IP) {
	ecommerceFrontPath, err := validatePath(
		`D:/Gabriel/Projetos/G2L_DevHouse/Ecommerce/G2L_Front`,
		`C:/Gabriel/Projetos/G2L_DevHouse/Ecommerce/G2L_Front`,
	)
	if err != nil {
		log.Fatal(err)
	}

	cmdFront := exec.Command("quasar", "dev")
	cmdFront.Dir = ecommerceFrontPath

	ecommerceBackPath, err := validatePath(
		`D:/Gabriel/Projetos/G2L_DevHouse/Ecommerce/G2L_BackEnd`,
		`C:/Gabriel/Projetos/G2L_DevHouse/Ecommerce/G2L_BackEnd`,
	)

	cmdBack := exec.Command("php", "artisan", "serve", "--host="+ip)
	cmdBack.Dir = ecommerceBackPath

	if err != nil {
		log.Fatal(err)
	}

	coreFrontPath, err := validatePath(
		D:/Gabriel/Projetos/G2L_DevHouse/Core/G2L_Access_FrontEnd,
		C:/Gabriel/Projetos/G2L_DevHouse/Core/G2L_Access_FrontEnd,
	)

	//quasar dev -p 9090
	cmdCoreFront := exec.Command("quasar", "dev", "-p", "9090")
	cmdCoreFront.Dir = coreFrontPath

	if err != nil {
		log.Fatal(err)
	}

	coreBackPath, err := validatePath(
		D:/Gabriel/Projetos/G2L_DevHouse/Core/G2L_Access_BackEnd,
		C:/Gabriel/Projetos/G2L_DevHouse/Core/G2L_Access_BackEnd,
	)

	cmdCoreBack := exec.Command("php", "artisan", "serve")
	cmdCoreBack.Dir = coreBackPath
	
	if err != nil {
		log.Fatal(err)
	}

	whatsPath, err := validatePath(
		D:/Gabriel/Projetos/G2L_DevHouse/Core/Services/WhatsAppGo/cmd,
		C:/Gabriel/Projetos/G2L_DevHouse/Core/Services/WhatsAppGo/cmd,
	)

	if err != nil {
		log.Fatal(err)
	}

}

func main() {
	ip := GetLocalIP()
	StartServers(ip)
}