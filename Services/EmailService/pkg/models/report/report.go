package models

import "g2l.email/pkg/schemas"

type ReportSale struct {
	IssuerID   int                 `json:"issuerID"`
	To         string              `json:"to"`
	From       string              `json:"from"`
	TypeReport string              `json:"typeReport"`
	MoreConfig schemas.MailOptions `json:"moreConfig"` // Espera as demais configurações, se vai manda NM, NFC-e, e para outroso e-mails
}
