package api

import (
	"database/sql"
	"fmt"
	"log"
	"os"
	"path/filepath"
	"runtime"
	"strings"
	"time"

	"g2l.email/db/conn"

	issuer "g2l.email/pkg/models/issuer"
	pdv "g2l.email/pkg/models/pdv"

	reportPDF "g2l.email/internal/build/pdf"
	reportModel "g2l.email/pkg/models/report"

	_ "github.com/go-sql-driver/mysql"
)

func defineTypeReport(reportType string, pdvData []pdv.PDVRows, issuer issuer.Issuer) (reportPath string, err error) {
	switch strings.ToLower(reportType) {
	case "pdf":
		rPath, err := reportPDF.BuildPDFReport(issuer, pdvData)

		if err != nil {
			log.Println("Erro ao processar o relatório: ", err)
			return "", err
		}
		reportPath = rPath
	}

	return reportPath, nil
}

func insertIntoHistoryMail(db *sql.DB, r reportModel.ReportSale) (bool, error) {
	_, thisFile, _, _ := runtime.Caller(0)
	upOne := filepath.Dir(filepath.Dir(thisFile))
	sqlPath := filepath.Join(upOne, "db", "insert", "insertIntoHistoryMail.sql")
	sqlByte, err := os.ReadFile(sqlPath)

	if err != nil {
		log.Println("Erro ao ler o arquivo do insert insertIntoHistoryMail.sql - line 44: ", err)
		return false, err

	}
	// issuer_id, mail_histories_code, mail_used, `to`, `from`, shipping_date, success
	incrementMailHistoriesCode := func(db *sql.DB, issuerID int) (newCode int, err error) {
		_, thisFile, _, _ := runtime.Caller(0)
		upOne := filepath.Dir(filepath.Dir(thisFile))
		sqlPath := filepath.Join(upOne, "db", "querys", "reportSale", "maxMailHistoriesCode.sql")
		sqlByte, err := os.ReadFile(sqlPath)

		if err != nil {
			log.Println("Erro ao ler o arquivo do select maxMailHistoriesCode.sql - line 57: ", err)
			return 0, err
		}

		row := db.QueryRow(string(sqlByte), issuerID)

		log.Println("Row retornada in incrementMailHistoriesCode - line 64:", row.Scan(&newCode))

		return newCode, nil
	}

	newCode, err := incrementMailHistoriesCode(db, r.IssuerID)

	if err != nil {
		log.Println("Erro ao executar o incrementMailHistoriesCode - line 72:", err)
		return false, nil

	}

	res, err := db.Exec(string(sqlByte), r.IssuerID, newCode+1, r.To, r.To, r.From, time.Now(), true)

	if err != nil {
		log.Println("Erro ao executar o insert - line 80:", err)
		return false, nil

	} else {
		log.Println("Query executada com sucesso!")
		log.Println("Resultado: ", res)
		return true, nil
	}
}

func BuildReport(r reportModel.ReportSale) (string, error) {
	db := conn.ConnDB()
	defer db.Close()

	issuer, err := buildIssuerData(r.IssuerID)

	if err != nil {
		log.Println("Erro ao construir os dados issuer: ", err)
		return "", err
	}

	pdvData, err := processReport(r.IssuerID)

	if err != nil {
		log.Println("Erro ao processar o relatório no processReport: ", err)
		return "", err
	}

	reportPath, err := defineTypeReport(r.TypeReport, pdvData, issuer)

	if err != nil {
		log.Println("Erro ao processar o relatório no defineTypeReport: ", err)
		return "", err
	}

	success, err := insertIntoHistoryMail(db, r)

	if !success {
		log.Println("Erro ao dar o insert in insertIntoHistoryMail - line 90:", err)
		return "", err

	}

	return reportPath, nil
}

func buildIssuerData(issuerID int) (issuer.Issuer, error) {
	db := conn.ConnDB()
	defer db.Close()

	attachPath := filepath.Join("db", "querys", "issuer", "select.sql")
	sqlByte, err := os.ReadFile(attachPath)

	if err != nil {
		log.Println("erro ao ler query.sql: %w", err)
	}

	rows, err := db.Query(string(sqlByte), issuerID)

	if err != nil {
		log.Println("Erro na consulta buildIssuerData:", err)

	}

	var i issuer.Issuer

	for rows.Next() {
		var r issuer.Issuer

		if err := rows.Scan(
			&r.Id,
			&r.Name,
			&r.CnpjCpf,
			&r.Address,
			&r.AddressNumber,
			&r.City,
			&r.Cep,
		); err != nil {
			log.Println("Erro ao ler os dados - line 157 - buildIssuerData:", err)
		}

		i = r
	}

	return i, nil
}

func processReport(issuerID int) ([]pdv.PDVRows, error) {
	var result []pdv.PDVRows
	db := conn.ConnDB()

	attachPath := filepath.Join("db", "querys", "reportSale", "query.sql")

	log.Println("Caminho do arquivo final: ", attachPath)
	sqlByte, err := os.ReadFile(attachPath)

	if err != nil {
		return nil, fmt.Errorf("erro ao ler o query.sql: %w", err)
	}

	rows, err := db.Query(string(sqlByte), issuerID)

	if err != nil {
		log.Println("Erro ao fazer a query", err)
		return nil, err
	}

	defer rows.Close()

	for rows.Next() {
		var r pdv.PDVRows

		if err := rows.Scan(&r.PDVCode, &r.IsFfceNm, &r.Customer, &r.EmitDate, &r.Description, &r.NetValue); err != nil {
			log.Println("Erro ao fazer a leitura dos dados da query:", err)
			return nil, err

		}
		result = append(result, r)

	}

	for _, v := range result {
		log.Println("Resultado:", v)

	}

	return result, nil
}
