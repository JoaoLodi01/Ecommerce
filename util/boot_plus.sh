/*#!/bin/bash

DB_USER="root"
DB_PASS="masterkey"
DB_NAME="ambiente_config"

save_db()
{
	mysql -u $DB_USER -p$DB_PASS $DB_NAME -e\
	"
		INSERT INTO ambientes (ambient_name, frontend_path, backend_path, frontend_stack, backend_stack) 
		VALUES ('$1', '$2', '$3', '$4', '$5')
	"
	echo "Dados gravados com sucesso!"
}

main()
{
	echo "1 - Inicialização rápida"
	echo "2 - Inicialização personalizada"
	read init

	if [[ $init -eq 1 ]]; then
		ech "A"
	fi

	if [[ $init -eq 2 ]]; then
		scop
	fi
}

count_ambients()
{
	count=$(mysql -u $DB_USER -p$DB_PASS $DB_NAME -se "SELECT count(*) FROM ambientes")
	echo $count
}

consult_db()
{
	if [ $option -eq 1 ]; then
		mysql -u $DB_USER -p$DB_PASS $DB_NAME -e \
		"SELECT * FROM ambientes"

	fi

	echo "Digite o ID do ambiente usado: "

	read id
	use_ambient $id
}

use_ambient()
{
	ambient_name=$(mysql -u $DB_USER -p$DB_PASS $DB_NAME -se "SELECT ambient_name FROM ambientes WHERE id = $id")
	frontend_path=$(mysql -u $DB_USER -p$DB_PASS $DB_NAME -se "SELECT frontend_path FROM ambientes WHERE id = $id")
	backend_path=$(mysql -u $DB_USER -p$DB_PASS $DB_NAME -se "SELECT backend_path FROM ambientes WHERE id = $id")
	frontend_stack=$(mysql -u $DB_USER -p$DB_PASS $DB_NAME -se "SELECT frontend_stack FROM ambientes WHERE id = $id")
	backend_stack==$(mysql -u $DB_USER -p$DB_PASS $DB_NAME -se "SELECT backend_stack FROM ambientes WHERE id = $id")

	if [[ $ambient_name ]]; then
		echo "Ambiente escolhido: $ambient_name"
		start_server $frontend_path $backend_path $frontend_stack $backend_stack

	else
		echo "Ambiente não encontrado"
		read 
		main

	fi
	
}

start_server()
{
	echo "1 - Local"
	echo "2 - Rede"
	read local

	if [ $local -eq 1 ]; then
		echo "Iniciando servidores locais: "
		echo "3: $3"
		if [ $3  -eq "Vue" ]; then
			echo "Qual o iniciador localizado no packge.json?"
			read initialize

			cd $1
			start bash -c "npm run $initialize"

			case $4 in
				"Node")
					cd $2
					start bash -c "node server"	
					;;

				"PHP")
					cd $2
					start bash -c "php artisan serve"
					;;
				"Ruby")
					cd $2
					start bash -c "rails s"
					;;

				*)
					echo "BackEnd não encontrado $4"
					return 0
			esac	
		fi
	fi
}

scop()
{	
	count=$(count_ambients)
	clear
	if [ $count -gt 0 ]; then
		echo "1 - Meus ambientes"
		echo "2 - Cadastrar ambiente"
		read option

		case $option in
			1)	
				consult_db $option
				;;	

			2)
				options
				;;

			*)
				echo "Opção inválida"
				return 1
				;;

		esac

	else
		echo "1 - Cadastrar ambiente"
		options

	fi	
}

options()
{
	echo "Digite o caminho do front end, exemplo C:/Projeto/frontend"
	read frontendPath
	cd $frontendPath || { "O caminho não foi encontrado!"; exit 1; }

	echo "Digite o caminho do front end, exemplo C:/Projeto/backend"
	read  backendPath
	cd $backendPath || { "O caminho não foi encontrado!"; exit 1; }

	if [ -n $frontendPath ] && [ -n $backendPath ]; then
		choice_stack $frontendPath, $backendPath

	fi
}

choice_stack()
{
	echo "Qual nome do ambiente"
	read ambientName

	echo "Selecione a stack usada para o frontend"
	echo "1 - Vue"
	echo "2 - Angular" 
	echo "3 - React"
	read stackFront

	case $stackFront in
		1)
			stackName="Vue"
			;;

		2)
			stackName="Angular"
			;;

		3)
			stackName="React"
			;;

		*)
			echo "Opção inválida"
			echo "Retornar para a tela inicial"
			read 
			main	
			;;
	
	esac

	echo "Selecione a stack usada para o backend"
	echo "1 - Node"
	echo "2 - Laravle(PHP)" 
	echo "3 - Rails(Ruby)"
	read stackFront

	case $stackFront in
		1)
			stackNameBack="Node"
			;;
			
		2)
			stackNameBack="Angular"
			;;

		3)
			stackNameBack="React"
			;;

		*)
			echo "Opção inválida"
			echo "Retornar para a tela inicial"
			read 
			main
			
			;;
	
	esac

	save_db $ambientName $frontendPath $backendPath $stackName $stackNameBack
}

main