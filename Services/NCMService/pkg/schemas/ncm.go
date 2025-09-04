package schemas

import "time"

type NCM struct {
	Ncm                string
	Description        string
	Nacional_federal   float64
	Importados_federal float64
	Estadual           float64
	Municipal          float64
	Inicio             time.Time
	Fim                time.Time
	Chave              string
	Versao             string
}
