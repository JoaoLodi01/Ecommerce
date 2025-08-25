package store

import (
	"fmt"
	"log"
	"os"
	"path/filepath"
	"strconv"
)

func SaveFiles(currentDir, currentFile, reportType string, issuerID int) (filePath string, err error) {
	log.Printf("Salvando arquivos do issuerID: %d - SaveFiles - line 12", issuerID)

	log.Println("currentFile - line 14:", currentFile)

	upOne := filepath.Dir(filepath.Dir(currentFile))

	if err := os.MkdirAll(fmt.Sprintf("%s/files/%d/%s-reports", upOne, issuerID, reportType), 0755); err != nil {
		log.Println("Erro ao criar novo caminho - line 19:", err)
		return "", err

	}

	log.Printf("Novo caminho do emitente - line 24: %s/files/%d/%s-reports", upOne, issuerID, reportType)

	reportTypePath := fmt.Sprintf("%s-reports", reportType)
	finalPath := filepath.Join(upOne, "files", strconv.Itoa(issuerID), reportTypePath, "relatório_de_vendas.pdf")

	filePath = finalPath

	return filePath, nil
}

func DeleteAfterSend(reportPath string, issuerID int) error {
	log.Println("Exclusão de:", reportPath)

	return os.RemoveAll(reportPath)
}
