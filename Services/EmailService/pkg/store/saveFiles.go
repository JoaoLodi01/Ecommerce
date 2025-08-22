package store

import (
	"fmt"
	"log"
	"os"
	"path/filepath"
	"strconv"
)

/*func checkExistsPath(upOne, reportType string, issuerID int) (exists bool) {
	path := fmt.Sprintf("%s/files/%d/%s-reports", upOne, issuerID, reportType)
	log.Printf("Vai checar se o caminho: %s já existe - checkExistsPath -", path)
	_, err := os.Stat(path)

	if err == nil {
		exists = true // Existe

	}

	if errors.Is(err, os.ErrNotExist) {
		exists = false // Não existe
	}

	return exists
}*/ // Usar se necessário

func SaveFiles(currentDir, currentFile, reportType string, issuerID int) (filePath string, err error) {
	log.Println("Salvando arquivos - SaveFiles - line 9")

	log.Println("currentFile - line 11:", currentFile)

	upOne := filepath.Dir(filepath.Dir(currentFile))

	if err := os.MkdirAll(fmt.Sprintf("%s/files/%d/%s-reports", upOne, issuerID, reportType), 0755); err != nil {
		log.Println("Erro ao criar novo caminho - line 19:", err)
		return "", err

	}

	log.Printf("Novo caminho do emitente - line 22: %s/files/%d/%s-reports", upOne, issuerID, reportType)

	reportTypePath := fmt.Sprintf("%s-reports", reportType)
	finalPath := filepath.Join(upOne, "files", strconv.Itoa(issuerID), reportTypePath, "relatório_de_vendas.pdf")

	filePath = finalPath

	return filePath, nil
}

func DeleteAfterSend(reportPath string, issuerID int) error {
	log.Println("Exclusão de:", reportPath)

	return os.RemoveAll(reportPath)
}
