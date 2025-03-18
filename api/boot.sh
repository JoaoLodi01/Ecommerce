/*#!/bin/bash

DB_USER="root"
DB_NAME="ambiente_config"
DB_PASS="masterkey"

save_db()
{
	mysql -u $DB_USER -p$DB_PASS $DB_NAME -e \
	"INSERT INTO ambientes (ip, frontend_path, backend_path, local) VALUES ('$1')"

	echo "Dados salvos com sucesso!"
}

start_server()
{
	clear
	echo "Iniciando servidores..."
	cd $1
	start bash -c "npm run s"

	cd $2 
	start bash -c "php artisan serve --host=192.168.$3"
	clear
}

all_ambients()
{
	clear
	echo "Todos os ambientes: "
	mysql -u $DB_USER -p$DB_PASS $DB_NAME -e "SELECT * FROM ambientes"
	read 
	main
}

change_ambient()
{
	echo "Todos os ambientes: "
	echo "Selecione o ambiente desejado pelo ID "
	mysql -u $DB_USER -p$DB_PASS $DB_NAME -e "SELECT * FROM ambientes"	
	read id

	ip=$(mysql -u $DB_USER -p$DB_PASS $DB_NAME -se "SELECT ip FROM ambientes WHERE id = $id")
	frontPath=$(mysql -u $DB_USER -p$DB_PASS $DB_NAME -se "SELECT frontend_path FROM ambientes WHERE id = $id")
	backPath=$(mysql -u $DB_USER -p$DB_PASS $DB_NAME -se "SELECT backend_path FROM ambientes WHERE id = $id")

	start_server $frontPath $backPath $ip 
}

main()
{
	clear
	echo "Selecione o ambiente"
	echo "1 - Selecionar ambiente"
	echo "2 - Todos os IPs"
	echo "0 - Sair"

	read ambiente

	case $ambiente in
	 	1)
			clear
			change_ambient
			;;

		2)
			clear		
			all_ambients
			;;

		0)
			echo "Saindo..."
			sleep 0.5
			clear
			exit 1;
			
			;;
	esac
}

main