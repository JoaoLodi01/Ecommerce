package reportPDF

//package main

import (
	"errors"
	"fmt"
	"log"
	"os"
	"path/filepath"
	"runtime"
	"strings"

	issuer "g2l.email/pkg/models/issuer"
	pdv "g2l.email/pkg/models/pdv"
	"g2l.email/pkg/store"

	"github.com/johnfercher/maroto/pkg/color"
	"github.com/johnfercher/maroto/pkg/consts"
	"github.com/johnfercher/maroto/pkg/pdf"
	"github.com/johnfercher/maroto/pkg/props"
)

const (
	flags = log.Ldate | log.Lshortfile
)

var (
	infoLogger  = log.New(os.Stdout, "INFO:", flags)
	errorLogger = log.New(os.Stdout, "ERROR:", flags)
)

func formatValues(v float64) (value string) {
	old := fmt.Sprintf("R$%.2f", v)
	value = strings.ReplaceAll(old, ".", ",")
	return value
}

func formatTypeNote(v string) (newValue string) {
	switch strings.ToLower(v) {
	case "nm":
		newValue = "Venda nota manual"

	case "nfce":
		newValue = "Venda NFC-e"

	default:
		newValue = "Venda não especificada"
	}

	return newValue
}

func buildHeader(m pdf.Maroto, issuerData issuer.Issuer) {
	nameLine := fmt.Sprintf(
		"Razão social: %s",
		issuerData.Name,
	)

	cpfCnpjLine := fmt.Sprintf(
		"CNPJ/CPF: %s",
		issuerData.CnpjCpf,
	)

	addressLine := fmt.Sprintf(
		"Endereço: %s",
		issuerData.Address,
	)

	addressNumberLine := fmt.Sprintf(
		"Número: %s",
		issuerData.AddressNumber,
	)

	cityLine := fmt.Sprintf(
		"Cidade: %s",
		issuerData.City,
	)

	cepLine := fmt.Sprintf(
		"CEP: %s",
		issuerData.Cep,
	)

	m.RegisterHeader(func() {
		m.Row(50, func() {
			m.Col(12, func() {
				_, thisFile, _, _ := runtime.Caller(0)
				thisDir := filepath.Dir(filepath.Dir(thisFile))

				imagePath := filepath.Join(thisDir, "images", "logo.png")

				if err := m.FileImage(imagePath, props.Rect{
					Center:  false,
					Percent: 75,
				}); err != nil {
					errorLogger.Println("Erro ao carregar a logo:", err)

				}

				m.Col(12, func() {
					y := 0.0
					m.Text(nameLine, props.Text{
						Top:   y,
						Style: consts.Bold,
						Align: consts.Right,
					})

					y += 5.0

					m.Text(cpfCnpjLine, props.Text{
						Top:   y,
						Style: consts.Bold,
						Align: consts.Right,
					})

					y += 4.3

					m.Text(addressLine, props.Text{
						Top:   y,
						Style: consts.Bold,
						Align: consts.Right,
					})

					y += 4.3

					m.Text(addressNumberLine, props.Text{
						Top:   y,
						Style: consts.Bold,
						Align: consts.Right,
					})

					y += 4.3

					m.Text(cityLine, props.Text{
						Top:   y,
						Style: consts.Bold,
						Align: consts.Right,
					})

					y += 4.3

					m.Text(cepLine, props.Text{
						Top:   y,
						Style: consts.Bold,
						Align: consts.Right,
					})
				})
			})
		})
	})

	m.Row(5, func() { m.Col(12, func() { m.Signature("") }) })

	m.Row(10, func() {
		m.Col(12, func() {
			m.Text("Relatório de vendas no período", props.Text{
				Top:   3,
				Style: consts.Bold,
				Align: consts.Center,
				Color: getDarkPurpleColor(),
			})
		})
	})
}

func buildDataTable(m pdf.Maroto, pdvsData []pdv.PDVRows) {
	m.SetBackgroundColor(getTealColor())

	var total float64
	m.Row(8, func() {
		m.Col(1, func() {
			m.Text("Cód", props.Text{
				Color: color.NewWhite(),
				Style: consts.Bold,
				Align: consts.Center,
			})
		})

		m.Col(3, func() {
			m.Text("Tipo", props.Text{
				Color: color.NewWhite(),
				Style: consts.Bold,
				Align: consts.Center,
			})
		})

		m.Col(3, func() {
			m.Text("Descrição", props.Text{
				Color: color.NewWhite(),
				Style: consts.Bold,
				Align: consts.Center,
			})
		})

		m.Col(2, func() {
			m.Text("Data de emissão", props.Text{
				Color: color.NewWhite(),
				Style: consts.Bold,
				Align: consts.Center,
			})
		})

		m.Col(2, func() {
			m.Text("Cliente", props.Text{
				Color: color.NewWhite(),
				Style: consts.Bold,
				Align: consts.Center,
			})
		})

		m.Col(1, func() {
			m.Text("Valor líquido", props.Text{
				Color: color.NewWhite(),
				Style: consts.Bold,
				Align: consts.Center,
			})
		})

	})

	for _, v := range pdvsData {
		total += v.NetValue

		m.Row(10, func() {
			m.Col(1, func() {
				m.Text(fmt.Sprintf("%d", v.PDVCode), props.Text{
					Color: color.NewWhite(),
					Align: consts.Center,
				})
			})

			m.Col(3, func() {
				m.Text(formatTypeNote(v.IsFfceNm), props.Text{
					Color: color.NewWhite(),
					Align: consts.Center,
				})
			})

			m.Col(3, func() {
				m.Text(v.Description, props.Text{
					Color: color.NewWhite(),
					Align: consts.Center,
				})
			})

			m.Col(2, func() {
				m.Text(v.EmitDate, props.Text{
					Color: color.NewWhite(),
					Align: consts.Center,
				})
			})

			m.Col(2, func() {
				m.Text(v.Customer, props.Text{
					Color: color.NewWhite(),
					Align: consts.Center,
				})
			})

			m.Col(1, func() {
				m.Text(formatValues(v.NetValue), props.Text{
					Color: color.NewWhite(),
					Align: consts.Center,
				})
			})
		})

	}

	m.Row(5, func() { m.Col(12, func() { m.Signature("") }) })
	buildFooter(m, total)
}

func buildFooter(m pdf.Maroto, totalValue float64) {
	// Totalizador
	totalText := fmt.Sprintf("Total líquido de vendas: %s", formatValues(totalValue))
	m.RegisterFooter(func() {
		m.Row(10, func() {
			m.Col(7, func() {}) // "Margem"

			m.Col(5, func() {
				m.Text(totalText, props.Text{
					Color: color.NewWhite(),
					Top:   2,
					Align: consts.Right,
				})
			})
			//m.Col(1, func() {})
		})
	})
}

func getTealColor() color.Color {
	return color.Color{
		Red:   3,
		Green: 166,
		Blue:  166,
	}
}

func getDarkPurpleColor() color.Color {
	return color.Color{
		Red:   88,
		Green: 80,
		Blue:  99,
	}
}

func BuildPDFReport(issuerData issuer.Issuer, pdvsData []pdv.PDVRows) (filePath string, err error) {
	if len(pdvsData) == 0 {
		errorMsg := fmt.Sprintln("Sem vendas no período")
		return "", errors.New(errorMsg)

	}

	infoLogger.Printf("Construindo dados do ISSUER: %s - %d", issuerData.Name, issuerData.Id)
	m := pdf.NewMaroto(consts.Portrait, consts.A4) // Cria um novo documento com a orientação e tamanho
	m.SetPageMargins(12, 10, 12)                   // Define algumas margens

	buildHeader(m, issuerData)
	buildDataTable(m, pdvsData)

	_, thisFile, _, _ := runtime.Caller(0) // Caminho do arquivo atual, buildPDFReport.go

	if err := store.SaveLogFiles("pdfReport", thisFile, "Chamou a função para o .pdf 2"); err != nil {
		errorLogger.Println("Erro ao salvar a log:", err)
		return "", err
	} // O store.SaveLogFiles vai criar e armazenar o arquivo da log

	filePath, err = store.SaveFiles("", thisFile, "pdf", issuerData.Id)

	if err != nil {
		errorLogger.Println("Erro no processo para salvar arquivos - line 320:", err)
		return "", err

	}

	if err := m.OutputFileAndClose(filePath); err != nil { // Salva o PDF
		errorLogger.Println("Erro ao salvar arquivo PDF: ", err)
		return "", err
	}
	// Precisa retornar o caminho do arquivo para que no sendMessage pegue e faça o Attaceh

	return filePath, nil
}

/*
func main() {
	var pdvData pdv.PDVRows
	var pdvsData []pdv.PDVRows

	for i := 1; i <= 4; i++ {
		pdvData.PDVCode = i
		pdvData.IsFfceNm = "nm"
		pdvData.Description = fmt.Sprintf("Venda nota manual N° %d", i)
		pdvData.EmitDate = "01/01/2025"
		pdvData.Customer = "Cliente teste"
		pdvData.NetValue = 12.00

		pdvsData = append(pdvsData, pdvData)
	}

	BuildPDFReport(issuer.Issuer{
		Name:          "Teste",
		CnpjCpf:       "088.051.669-01",
		Address:       "Teste",
		AddressNumber: "135",
		City:          "Teste",
		Cep:           "89711-226",
	},
		pdvsData,
	)
}
*/
