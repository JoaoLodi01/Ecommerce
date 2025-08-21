package reportPDF

import (
	"fmt"
	"log"
	"strings"

	"g2l.email/pkg/models/issuer"
	models "g2l.email/pkg/models/pdv"

	"github.com/johnfercher/maroto/pkg/color"
	"github.com/johnfercher/maroto/pkg/consts"
	"github.com/johnfercher/maroto/pkg/pdf"
	"github.com/johnfercher/maroto/pkg/props"
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
				if err := m.FileImage("../images/logo.png", props.Rect{
					Center:  false,
					Percent: 75,
				}); err != nil {
					log.Fatal("Erro ao carregar a logo:", err)

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

func buildTable(m pdf.Maroto) {
	black := color.Color{
		Red:   0,
		Blue:  0,
		Green: 0,
	}

	m.Row(10, func() {
		m.Col(12, func() {
			m.Text("Vendas", props.Text{
				Color:  black,
				Family: consts.Courier,
				Style:  consts.Bold,
			})
		})
	})

	m.SetBackgroundColor(getTealColor())
}

func buildDataTable(m pdf.Maroto, pdvsData []models.PDVRows) (total float64) {
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
	return total
}

func buildFooter(m pdf.Maroto, totalValue float64) {
	totalText := fmt.Sprintf("Total líquido de vendas: %s", formatValues(totalValue))
	m.RegisterFooter(func() {
		m.Row(10, func() {
			m.Col(10, func() {
				m.Text(totalText, props.Text{
					Color: color.NewWhite(),
				})
			})
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

func BuildPDFReport(issuerData issuer.Issuer, pdvsData []models.PDVRows) (string, error) {
	m := pdf.NewMaroto(consts.Portrait, consts.A4) // Cria um novo documento com a orientação e tamanho
	m.SetPageMargins(12, 10, 12)                   // Define algumas margens

	buildHeader(m, issuerData)
	buildTable(m)
	total := buildDataTable(m, pdvsData)
	buildFooter(m, total)

	if err := m.OutputFileAndClose("../files/pdf_teste.pdf"); err != nil {
		log.Println("Erro ao salvar arquivo PDF: ", err)
		return "", err
	}
	// Aqui apenas salva o arquivo
	// Precisa retornar o caminho do arquivo para que no sendMessage pegue e faça o Attaceh
	// Services/EmailService/internal/build/files/pdf_teste.pdf

	return "Services/EmailService/internal/build/files/pdf_teste.pdf", nil
}

/*
func main() {
	var pdvData models.PDVRows
	var pdvsData []models.PDVRows

	pdvData.PDVCode = 1
	pdvData.IsFfceNm = "nm"
	pdvData.Description = "Venda nota manual N° 1"
	pdvData.EmitDate = "01/01/2025"
	pdvData.Customer = "Cliente teste"
	pdvData.NetValue = 12.00

	pdvsData = append(pdvsData, pdvData)

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
