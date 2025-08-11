package main

import (
	"fmt"
	"log"
	"net"
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

func OpenServers(ip net.IP) {
	bash := exec.Command("npm", "run", "dev")
	bash.Dir = `C:/Gabriel/Projetos/G2L_DevHouse/Ecommerce/G2L_Front`

	stdout, err := bash.CombinedOutput()

	if err != nil {
		log.Fatal(err)
	}

	log.Println(string(stdout))
}

func main() {
	fmt.Println(GetLocalIP())
	OpenServers(GetLocalIP())
}
