package main

import (
	"fmt"

	"go.mau.fi/whatsmeow"
)

func main() {
	ver, err := whatsmeow.GetLatestVersion()

	if err != nil {
		panic(err)
	}

	fmt.Println(ver)

}
