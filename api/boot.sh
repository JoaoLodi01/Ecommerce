/*#!/bin/bash

# ---------- Env ----------
DB_USER="note"
DB_HOST="192.168.1.104"
DB_NAME="ambiente_config"
DB_PASS="masterkey" 
# -------------------- #

save_db()
{
	echo "dados: "
	echo "1: $1"
	echo "2: $2"
	echo "3: $3"
	echo "4: $4"
	echo "5: $5"
	echo "6: $6"
	mysql -u $DB_USER -p$DB_PASS -h $DB_HOST $DB_NAME -e \
	"INSERT INTO ambientes (ip, frontend_path, backend_path, frontend_stack, backend_stack, local) VALUES ('$1', '$2', '$3', '$4', '$5', '$6')"

	echo "Dados salvos com sucesso!"
}

start_server()
{
	case $frontendStack in
		'vue')
			cd $2
			start bash -c "npm run s"

			cd $3
			start bash -c "php artisan serve --host=192.168.$1"
			bash -c "sh artisan_util.sh"
			return 0;
			;;
		'quasar')
			cd $2
			start bash -c "quasar dev"

			cd $3
			start bash -c "php artisan serve --host=192.168.$1"
			bash -c "sh artisan_util.sh"
			return 0;
			;;
			
		*)	
			echo "Erro"
			return 0;
			;;
	esac
	
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
	clear
	echo "Todos os ambientes: "
	echo "Selecione o ambiente desejado pelo ID "
	mysql -u $DB_USER -p$DB_PASS $DB_NAME -e "SELECT * FROM ambientes"	
	read id
	ip=$(mysql -u $DB_USER -p$DB_PASS $DB_NAME -se "SELECT ip FROM ambientes WHERE id = $id")
	frontendPath=$(mysql -u $DB_USER -p$DB_PASS $DB_NAME -se "SELECT frontend_path FROM ambientes WHERE id = $id")
	backendPath=$(mysql -u $DB_USER -p$DB_PASS $DB_NAME -se "SELECT backend_path FROM ambientes WHERE id = $id")
	frontendStack=$(mysql -u $DB_USER -p$DB_PASS $DB_NAME -se "SELECT frontend_stack FROM ambientes WHERE id = $id")
	backendStack=$(mysql -u $DB_USER -p$DB_PASS $DB_NAME -se "SELECT backend_stack FROM ambientes WHERE id = $id")

	start_server $ip $frontendPath $backendPath $frontendStack $backendStack
}

input_ambient()
{
	clear
	echo "Digite o caminho do back end com /"
	read backend_path

	echo "Digite o caminho do front end com /"
	read front_path
	
	echo "Digite os digitos do seu IP depois do seu 168., exe: 98.51"
	read ip

	echo "Defina um local para o ambiente ( casa, empresa, sala ... )"
	read local

	echo "Defina uma stack do frontend ( vue, angular, react )"
	read frontend_stack

	echo "Defina uma stack do backend ( laravel, node, ruby )"
	read backend_stack

	save_db $ip $front_path $backend_path $frontend_stack $backend_stack $local
	
}

main()
{
	clear
	echo "Selecione o ambiente"
	echo "1 - Selecionar ambiente"
	echo "2 - Todos os IPs"
	echo "3 - Inserir ambiente"
	echo "0 - Sair"

	read ambiente

	case $ambiente in
	 	1)
	 		change_ambient
			;;

		2)
			all_ambients
			;;

		3)
			input_ambient
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