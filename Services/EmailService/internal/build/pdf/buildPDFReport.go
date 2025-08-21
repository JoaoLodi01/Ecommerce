// package pdf
package main

import (
	"log"

	"github.com/johnfercher/maroto/pkg/color"
	"github.com/johnfercher/maroto/pkg/consts"
	"github.com/johnfercher/maroto/pkg/pdf"
	"github.com/johnfercher/maroto/pkg/props"
)

func buidlHeader(m pdf.Maroto) {
	m.RegisterHeader(func() {
		m.Row(50, func() {
			m.Col(12, func() {
				err := m.FileImage("../images/logo.png", props.Rect{
					Center:  false,
					Percent: 75,
				})

				if err != nil {
					log.Fatal("Erro ao carregar a logo:", err)
				}
			})
		})
	})

	m.Row(10, func() {
		m.Col(12, func() {
			m.Text("Relatório de vendas no período", props.Text{
				Top:   3,
				Style: consts.Bold,
				Align: consts.Left,
				Color: getDarkPurpleColor(),
			})
		})
	})
}

func getDarkPurpleColor() color.Color {
	return color.Color{
		Red:   88,
		Green: 80,
		Blue:  99,
	}
}

func BuildPDF() {
	m := pdf.NewMaroto(consts.Portrait, consts.A4) // Cria um novo documento com a orientação e tamanho
	m.SetPageMargins(20, 10, 20)                   // Define algumas margens

	buidlHeader(m)

	if err := m.OutputFileAndClose("../files/pdf_teste.pdf"); err != nil {
		log.Println("Erro ao salvar arquivo PDF: ", err)
	}

}

func main() {
	BuildPDF()
}
