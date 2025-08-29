package models

type Dial struct {
	Host     string `json:"host"`
	Username string `json:"userName"`
	Password string `json:"password"`
	Port     uint8  `json:"port"`
}
