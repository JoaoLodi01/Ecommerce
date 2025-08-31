package pkg

import (
	"errors"
	"fmt"
	"log"
	"os"
)

func validateDir(p string) bool {
	info, err := os.Stat(p)

	return err == nil && info.IsDir()
}

func setDir(mainPath, fallback string) (string, error) {
	switch {
	case validateDir(mainPath):
		_, err := os.Stat(mainPath)

		if err != nil {
			log.Printf("Erro ao acessar o caminho: %s | erro: %s", mainPath, err)
			return "", err
		}

		return mainPath, err

	case validateDir(fallback):
		_, err := os.Stat(fallback)

		if err != nil {
			log.Printf("Erro ao acessar o caminho: %s | erro: %s", mainPath, err)
			return "", err
		}

		return fallback, err

	default:
		err := fmt.Sprintf("erro ao acessar os caminhos: '%s' e '%s'", mainPath, fallback)
		return "", errors.New(err)

	}
}

func Start(
	mainPath,
	fallback string,
) (string, error) {
	dir, err := setDir(
		mainPath,
		fallback,
	)

	if err != nil {
		log.Println("Erro ao acessar os caminhos:", err)
		return "", err
	}

	log.Println("Caminho usado:", dir)
	return dir, nil
}
