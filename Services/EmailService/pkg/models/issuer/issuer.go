package models

type Issuer struct {
	Id            int
	Name          string
	CnpjCpf       string
	Address       string
	AddressNumber string
	City          string
	Cep           string
}
