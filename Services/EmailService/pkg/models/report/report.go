package models

type ReportSale struct {
	To         string `json:"to"`
	From       string `json:"from"`
	TypeReport string `json:"typeReport"`
}
