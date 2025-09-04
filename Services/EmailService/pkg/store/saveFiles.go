package store

import (
	"fmt"
	"log"
	"os"
	"os/exec"
	"path/filepath"
	"strconv"
)

const flags = log.Ldate | log.Lshortfile

var errorLogger = log.New(os.Stdout, "ERROR:", flags)

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

func SaveLogFiles(local, currentDir, contextLog string) error {
	logName := fmt.Sprintf("%s.log", local)

	f, err := os.OpenFile(logName, os.O_CREATE|os.O_APPEND|os.O_WRONLY, 0666)
	if err != nil {
		errorLogger.Println("Erro ao salvar a log:", err)
		return err
	}
	defer f.Close()

	newLine := fmt.Sprintf("[%s] - %s\n", local, contextLog)

	if _, err := f.WriteString(newLine); err != nil {
		errorLogger.Println("Erro ao escrever no arquivo:", err)
		return err
	}

	if err := f.Sync(); err != nil {
		errorLogger.Println("Erro ao sincronizar a escrita:", err)
	}

	upOne := filepath.Dir(currentDir)
	fileName := fmt.Sprintf("%s/*.log", upOne)

	newPath := "D:\\Gabriel\\Projetos\\G2L_DevHouse\\Services\\EmailService\\logs"

	cmd := exec.Command("mv", fileName, newPath)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr

	if err := cmd.Start(); err != nil {
		errorLogger.Println("Erro ao executar o move:", err)
	}

	return nil
}
