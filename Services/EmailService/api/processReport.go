package api

import (
	"fmt"
	"log"
	"os"
	"path/filepath"

	"g2l.email/db/conn"
	"g2l.email/pkg/models/issuer"
	models "g2l.email/pkg/models/pdv"
	_ "github.com/go-sql-driver/mysql"

	reportPDF "g2l.email/internal/build/pdf"
)

func BuildReport(reportFormat string) (string, error) {
	issuer := buildIssuerData()
	pdvData, err := processReport()

	if err != nil {
		log.Fatal("erro ao processar o relatório: ", err)
		return "", err
	}

	s, err := reportPDF.BuildPDFReport(issuer, pdvData)

	if err != nil {
		log.Fatal("erro ao processar o relatório: ", err)
		return "", err
	}

	return s, nil
}

func buildIssuerData() issuer.Issuer {
	var i issuer.Issuer
	db := conn.ConnDB()
	defer db.Close()

	attachPath := filepath.Join("db", "querys", "issuer", "select.sql")
	sqlByte, err := os.ReadFile(attachPath)

	if err != nil {
		log.Fatal("erro ao ler query.sql: %w", err)
	}

	rows, err := db.Query(string(sqlByte))

	if err != nil {
		log.Fatal("Erro na consulta buildIssuerData:", err)

	}

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
			log.Fatal("Erro ao ler os dados:", err)
		}

		i = r
	}

	return i
}

func processReport() ([]models.PDVRows, error) {
	var result []models.PDVRows
	db := conn.ConnDB()

	attachPath := filepath.Join("db", "querys", "reportSale", "query.sql")

	log.Println("Caminho do arquivo final: ", attachPath)
	sqlByte, err := os.ReadFile(attachPath)

	if err != nil {
		return nil, fmt.Errorf("erro ao ler o query.sql: %w", err)
	}

	rows, err := db.Query(string(sqlByte))

	if err != nil {
		log.Println("Erro ao fazer a query", err)
		return nil, err
	}

	defer rows.Close()

	for rows.Next() {
		var r models.PDVRows

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
