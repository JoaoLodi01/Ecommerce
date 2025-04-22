main()
{
	frontend_path="D:/Gabriel/Projetos/SGBR/1_Hotel_Ecommerce/quasar"
	api_path="D:/Gabriel/Projetos/SGBR/1_Hotel_Ecommerce/api"

	cd $frontend_path
	start bash -c "quasar dev"

	cd $api_path

<<<<<<< HEAD
	start bash -c "php artisan serve --host=192.168.1.104"
=======
	start bash -c "php artisan serve --host=192.168.48.204"
>>>>>>> 558b203c399c90915f3e924afa2a537b198cd42b

	bash -c "sh artisan_util.sh"

}

main
