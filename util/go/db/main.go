package main

import (
	"database/sql"
	"fmt"
	"log"

	_ "github.com/go-sql-driver/mysql"
)

func main() {
	db, err := sql.Open("mysql", "root:masterkey@tcp(localhost:3345)/hoteldb?charset=utf8mb4&parseTime=True&loc=Local")

	if err != nil {
		log.Println("erro ao se conectar no banco de dados:", err)
	}

	defer db.Close()

	rows, err := db.Query("SELECT product FROM products")

	if err != nil {
		log.Println("erro ao fazer a consulta:", err)
	}

	defer rows.Close()
	var products []string

	for rows.Next() {
		var product string
  
		if err := rows.Scan(&product); err != nil {
			log.Fatal("erro ao ler a query", err)
		}

		products = append(products, product)
	}
	fmt.Println(products)
}
