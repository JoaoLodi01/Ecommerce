// package pdf
package main

import (
	"fmt"
	"log"

	"g2l.email/pkg/models/issuer"
	models "g2l.email/pkg/models/pdv"

	_ "github.com/divrhino/fruitful-pdf/data"
	"github.com/johnfercher/maroto/pkg/color"
	"github.com/johnfercher/maroto/pkg/consts"
	"github.com/johnfercher/maroto/pkg/pdf"
	"github.com/johnfercher/maroto/pkg/props"
)

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

	m.Row(10, func() {
		m.Col(12, func() {
			m.Text("Vendas", props.Text{
				Top:    2,
				Size:   12,
				Color:  color.NewWhite(),
				Family: consts.Courier,
				Style:  consts.Bold,
				Align:  consts.Center,
			})
		})
	})

	m.SetBackgroundColor(getTealColor())
}

func buildDataTable(m pdf.Maroto, pdvsData []models.PDVRows) {
	m.Row(10, func() {
		m.Col(2, func() {
			m.Text("Cód venda", props.Text{
				Style: consts.Bold,
			})
		})

		m.Col(2, func() {
			m.Text("Tipo", props.Text{
				Style: consts.Bold,
			})
		})

		m.Col(2, func() {
			m.Text("Descrição", props.Text{
				Style: consts.Bold,
			})
		})

		m.Col(2, func() {
			m.Text("Valor líquido", props.Text{
				Style: consts.Bold,
				Align: consts.Right,
			})
		})
	})

	for _, v := range pdvsData {
		val := fmt.Sprintf("R$ %.2f", v.NetValue)

		m.Row(9, func() {
			m.Col(2, func() {
				m.Text(fmt.Sprintf("%d", v.PDVCode), props.Text{})
			})

			m.Col(2, func() {
				m.Text(v.IsFfceNm, props.Text{})
			})

			m.Col(2, func() {
				m.Text(v.Description, props.Text{})
			})

			m.Col(2, func() {
				m.Text(val, props.Text{
					Align: consts.Right,
				})
			})
		})

	}
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

func BuildPDF(issuerData issuer.Issuer, pdvsData []models.PDVRows) {
	m := pdf.NewMaroto(consts.Portrait, consts.A4) // Cria um novo documento com a orientação e tamanho
	m.SetPageMargins(20, 10, 20)                   // Define algumas margens

	buildHeader(m, issuerData)
	buildTable(m)
	buildDataTable(m, pdvsData)

	if err := m.OutputFileAndClose("../files/pdf_teste.pdf"); err != nil {
		log.Println("Erro ao salvar arquivo PDF: ", err)
	}

}

func main() {
	var pdvData models.PDVRows
	var pdvsData []models.PDVRows

	pdvData.PDVCode = 1
	pdvData.IsFfceNm = "nm"
	pdvData.Description = "Venda nota manual N° 1"
	pdvData.NetValue = 12.00

	pdvsData = append(pdvsData, pdvData)

	BuildPDF(issuer.Issuer{
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
