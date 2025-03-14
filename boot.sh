/*#!/bin/bash

DB_USER="root"
DB_NAME="boot"
DB_PASS="masterkey"

save_db()
{
	mysql -u $DB_USER -p$DB_PASS $DB_NAME -e \
	"INSERT INTO bootIP (ip, ambient, front_path, back_path) VALUES ('$1', '$2, '$3', '$4')"

	echo "Dados salvos com sucesso!"
}

change_ambient()
{
	clear
	if [[ -n $2 ]]; then
		echo "O caminho está incorreto ou não existe!"
		mysql -u $DB_USER -p$DB_PASS $DB_NAME -e \ "SELECT * FROM bootIP WHERE id = $1"
		echo "Campo a ser alterado"
		echo "1 - IP"
		echo "2 - front_path"
		echo "3 - back_path"	
		echo "0 - Voltar"	
		read field

		case $field in
			1)
				echo "Digite seu novo IP com pontos e traços: "
				read newIP
				if [[ -n $newIP ]]; then
					newAmbient=$(mysql -u $DB_USER -p$DB_PASS $DB_NAME -se \ "UPDATE bootIP SET ip = '$newIP' WHERE id = $1")
					echo "Dados alterados com sucesso"
					echo "Novo ambiente: "
					mysql -u $DB_USER -p$DB_PASS $DB_NAME -e \ "SELECT * FROM bootIP WHERE id = $1"
				fi
				;;
				
			2)
				echo "Digite seu novo caminho do FrontEnd com / "
				read newPath
				if [[ -n $newPath ]]; then
					cd $newPath || { "Caminho não encontrado!"; }
					erro=1
					change_ambient $1 $erro
				fi

				if [[ -n $newPath ]]; then
					newAmbient=$(mysql -u $DB_USER -p$DB_PASS $DB_NAME -se \ "UPDATE bootIP SET front_path = '$newPath' WHERE id = $1")
					echo "Dados alterados com sucesso"
					echo "Novo ambiente: "
					mysql -u $DB_USER -p$DB_PASS $DB_NAME -e \ "SELECT * FROM bootIP WHERE id = $1"
				fi
				;;

			3)
				echo "Digite seu novo caminho do BackEnd com / "
				read newPath
				if [[ -n $newPath ]]; then
					cd $newPath || { "Caminho não encontrado!"; }
					erro=1
					change_ambient $1 $erro

				fi	

				if [[ -n $newPath ]]; then
					newAmbient=$(mysql -u $DB_USER -p$DB_PASS $DB_NAME -se \ "UPDATE bootIP SET back_path = '$newPath' WHERE id = $1")
					echo "Dados alterados com sucesso"
					echo "Novo ambiente: "
					mysql -u $DB_USER -p$DB_PASS $DB_NAME -e \ "SELECT * FROM bootIP WHERE id = $1"
				fi
				;;

			0)
				main
				;;

			*)
				echo "Opcão inválida!"
				main
				;;
		esac
	fi

	mysql -u $DB_USER -p$DB_PASS $DB_NAME -e \ "SELECT * FROM bootIP WHERE id = $1"
		echo "Campo a ser alterado"
		echo "1 - IP"
		echo "2 - front_path"
		echo "3 - back_path"	
		echo "0 - Voltar"	
		read field

		case $field in
			1)
				echo "Digite seu novo IP com pontos e traços: "
				read newIP
				if [[ -n $newIP ]]; then
					newAmbient=$(mysql -u $DB_USER -p$DB_PASS $DB_NAME -se \ "UPDATE bootIP SET ip = '$newIP' WHERE id = $1")
					echo "Dados alterados com sucesso"
					echo "Novo ambiente: "
					mysql -u $DB_USER -p$DB_PASS $DB_NAME -e \ "SELECT * FROM bootIP WHERE id = $1"
				fi
				;;
			2)
				echo "Digite seu novo caminho do FrontEnd com / "
				read newPath
				cd $newPath || { "Caminho não encontrado!"; change_ambient $1 '1';}

				if [[ -n $newPath ]]; then
					newAmbient=$(mysql -u $DB_USER -p$DB_PASS $DB_NAME -se \ "UPDATE bootIP SET front_path = '$newPath' WHERE id = $1")
					echo "Dados alterados com sucesso"
					echo "Novo ambiente: "
					mysql -u $DB_USER -p$DB_PASS $DB_NAME -e \ "SELECT * FROM bootIP WHERE id = $1"
				fi
				;;

			3)
				echo "Digite seu novo caminho do BackEnd com / "
				read newPath
				cd $newPath || { "Caminho não encontrado!"; change_ambient $1 '1';}

				if [[ -n $newPath ]]; then
					newAmbient=$(mysql -u $DB_USER -p$DB_PASS $DB_NAME -se \ "UPDATE bootIP SET back_path = '$newPath' WHERE id = $1")
					echo "Dados alterados com sucesso"
					echo "Novo ambiente: "
					mysql -u $DB_USER -p$DB_PASS $DB_NAME -e \ "SELECT * FROM bootIP WHERE id = $1"
				fi
				;;

			0)
				main
				;;

			*)
				echo "Opcão inválida!"
				main
				;;
		esac
	
}

all_ambients()
{
	clear
	mysql -u $DB_USER -p$DB_PASS $DB_NAME -e \ "SELECT * FROM bootIP"
	ambients=$(mysql -u $DB_USER -p$DB_PASS $DB_NAME -e \ "SELECT * FROM bootIP")
	
	echo "Digite o ID do ambiente a ser alterado"
	echo "0 - Voltar"
	read id
	if [[ $id -eq 0 ]]; then
		main

	else
		change_ambient $id

	fi
	
}

main()
{
	clear
	echo "Selecione o ambiente"
	echo "1 - Casa"
	echo "2 - Empresa"
	echo "3 - Alterar ambiente"
	echo "0 - Sair"

	read ambiente

	case $ambiente in
	 	1)
			clear
	 		frontPath="D:\SGBR\Projeto_3_Hotel_Ecommerce\front"
	 		backPath="D:\SGBR\Projeto_3_Hotel_Ecommerce\api"

	 		cd $frontPath
	 		start bash -c "npm run s"

	 		cd $backPath 
	 		start bash -c "php artisan serve --host=192.168.1.104"
	 		;;
	 	2)
			clear
	 		frontPath="C:\Code\ProjetoWeb\front"
	 		backPath="C:\Code\ProjetoWeb\api"
	 		cd $frontPath
	 		start bash -c "npm run s"

	 		cd $backPath 
	 		start bash -c "php artisan serve --host=192.168.98.32"
			;;

		3)
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