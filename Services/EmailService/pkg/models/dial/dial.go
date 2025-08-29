package models

type Dial struct {
	Host     string `json:"host"`
	Port     int    `json:"port"`
	Username string `json:"userName"`
	Password string `json:"password"`
}
