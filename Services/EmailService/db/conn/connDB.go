package conn

import (
	"database/sql"
	"fmt"
	"log"
	"os"

	"github.com/joho/godotenv"
)

func ConnDB() *sql.DB {
	err := godotenv.Load()
	if err != nil {
		log.Println("Erro ao carregar o .env", err)
		return nil
	}

	dbConfig := fmt.Sprintf(
		// username:password@tcp(host:port)/dbname?charset=utf8mb4&parseTime=True&loc=Local
		"%s:%s@tcp(%s:%s)/%s?charset=utf8mb4&parseTime=True&loc=Local",
		os.Getenv("DB_USERNAME"), os.Getenv("DB_PASSWORD"), os.Getenv("DB_HOST"), os.Getenv("DB_PORT"), os.Getenv("DB_DATABASE"),
	)

	db, err := sql.Open("mysql", dbConfig)

	if err != nil {
		log.Fatal("Erro ao conectaro ao banco de dados")
		return nil
	}

	return db
}
