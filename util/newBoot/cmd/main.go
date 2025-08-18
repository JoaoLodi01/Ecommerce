package main

import (
	"fmt"
	"log"
	"net"
	"os"
	"os/exec"
	"os/signal"
	"syscall"
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
		return "", fmt.Errorf("erro ao acessar os caminhos: '%s' e '%s'", primary, fallback)

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
	log.Printf("Subindo servidores, IP: %s ...", ip)

	ecommerceFrontPath, err := validatePath(
		`D:/Gabriel/Projetos/G2L_DevHouse/Ecommerce/G2L_Front`,
		`C:/Gabriel/Projetos/G2L_DevHouse/Ecommerce/G2L_Front`,
	)

	if err != nil {
		log.Fatal(err)
	}

	cmdFront := exec.Command("quasar", "dev")
	cmdFront.Dir = ecommerceFrontPath
	cmdFront.Stdout = os.Stdout
	cmdFront.Stderr = os.Stderr
	cmdFront.Start()

	ecommerceBackPath, err := validatePath(
		`D:/Gabriel/Projetos/G2L_DevHouse/Ecommerce/G2L_BackEnd`,
		`C:/Gabriel/Projetos/G2L_DevHouse/Ecommerce/G2L_BackEnd`,
	)

	if err != nil {
		log.Fatal(err)
	}

	host := fmt.Sprintf("--host=%s", ip)
	cmdBack := exec.Command("php", "artisan", "serve", host)
	cmdBack.Dir = ecommerceBackPath
	cmdBack.Stdout = os.Stdout
	cmdBack.Stderr = os.Stderr
	cmdBack.Start()

	coreFrontPath, err := validatePath(
		`D:/Gabriel/Projetos/G2L_DevHouse/Core/G2L_Access_FrontEnd`,
		`C:/Gabriel/Projetos/G2L_DevHouse/Core/G2L_Access_FrontEnd`,
	)

	if err != nil {
		log.Fatal(err)
	}

	//quasar dev -p 9090
	cmdCoreFront := exec.Command("quasar", "dev", "-p", "9090")
	cmdCoreFront.Dir = coreFrontPath
	cmdCoreFront.Stdout = os.Stdout
	cmdCoreFront.Stderr = os.Stderr
	cmdCoreFront.Start()
	// -------------------------- \\

	coreBackPath, err := validatePath(
		`D:/Gabriel/Projetos/G2L_DevHouse/Core/G2L_Access_BackEnd`,
		`C:/Gabriel/Projetos/G2L_DevHouse/Core/G2L_Access_BackEnd`,
	)

	if err != nil {
		log.Fatal(err)
	}

	host2 := fmt.Sprintf("--host=%s", ip)

	cmdCoreBack := exec.Command("php", "artisan", "serve", host2, "--port=8080")
	cmdCoreBack.Dir = coreBackPath
	cmdCoreBack.Stdout = os.Stdout
	cmdCoreBack.Stderr = os.Stderr
	cmdCoreBack.Start()

	whatsPath, err := validatePath(
		`D:/Gabriel/Projetos/G2L_DevHouse/Services/WhatsAppGo/cmd`,
		`C:/Gabriel/Projetos/G2L_DevHouse/Services/WhatsAppGo/cmd`,
	)

	if err != nil {
		log.Fatal(err)
	}

	cmdGoWhats := exec.Command("go", "run", "main.go")
	cmdGoWhats.Dir = whatsPath
	cmdGoWhats.Stdout = os.Stdout
	cmdGoWhats.Stderr = os.Stderr
	cmdGoWhats.Start()

	emailPath, err := validatePath(
		`D:/Gabriel/Projetos/G2L_DevHouse/Services/EmailService/cmd`,
		`C:/Gabriel/Projetos/G2L_DevHouse/Services/EmailService/cmd`,
	)

	if err != nil {
		log.Fatal(err)
	}

	cmdGoEmail := exec.Command("go", "run", "main.go")
	cmdGoEmail.Dir = emailPath
	cmdGoEmail.Stdout = os.Stdout
	cmdGoEmail.Stderr = os.Stderr
	cmdGoEmail.Start()

}

func main() {
	ip := GetLocalIP()
	StartServers(ip)

	sig := make(chan os.Signal, 1)
	signal.Notify(sig, os.Interrupt, syscall.SIGTERM)
	<-sig

}
