/*#!/bin/bash

DB_USER="root"
DB_NAME="ambiente_config"
DB_PASS="masterkey"

save_db()
{
	mysql -u $DB_USER -p$DB_PASS $DB_NAME -e \
	"INSERT INTO ambientes (ip, local) VALUES ('$1')"

	echo "Dados salvos com sucesso!"
}

start_server()
{

	clear

	frontPath="D:\SGBR\Projeto_3_Hotel_Ecommerce\front"
	backPath="D:\SGBR\Projeto_3_Hotel_Ecommerce\api"

	cd $frontPath
	start bash -c "npm run s"

	cd $backPath 
	start bash -c "php artisan serve --host=192.168.$ip"
	
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

	case $id in
		1)
			frontPath=$(mysql -u $DB_USER -p$DB_PASS $DB_NAME -e "SELECT frontend_path FROM ambientes WHERE id = $id")
			ip=$(mysql -u $DB_USER -p$DB_PASS $DB_NAME -e "SELECT ip FROM ambientes WHERE id = $id")
			;;

	esac

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
	 		change_ambient
			;;

		2)
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