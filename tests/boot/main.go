package main

import (
	"fmt"
	"log"
	"net"
	"os"
	"os/exec"
)

func GetLocalIP() net.IP {
	conn, err := net.Dial("udp", "8.8.8.8:80")

	if err != nil {
		log.Fatal(err)
	}

	defer conn.Close()

	localAddress := conn.LocalAddr().(*net.UDPAddr)

	return localAddress.IP

}

func StartServers(myIP net.IP) {
	arg := fmt.Sprintf("--host=%s", myIP.String())
	bash := exec.Command("php", "artisan", "serve", arg)

	bash.Dir = "C:/Gabriel/Projetos/G2L_DevHouse/Ecommerce/G2L_BackEnd"

	bash.Stdout = os.Stdout
	bash.Stderr = os.Stderr

	if err := bash.Start(); err != nil {
		log.Fatal(err)
	}
}

func main() {
	ip := GetLocalIP()
	fmt.Println("Rodando no IP:", ip)

	StartServers(ip)
}
