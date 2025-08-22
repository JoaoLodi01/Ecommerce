package models

type ReportSale struct {
	IssuerID   int    `json:"issuerID"`
	To         string `json:"to"`
	From       string `json:"from"`
	TypeReport string `json:"typeReport"`
}
