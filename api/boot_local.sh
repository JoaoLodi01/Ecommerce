main()
{
<<<<<<< HEAD
	frontend_path="c:/Code/ProjetoWeb/quasar"
	api_path="c:/Code/ProjetoWeb/api"
=======
	frontend_path="C:/Gabriel/Projetos/SGBR/1_Hotel_Ecommerce/quasar"
	api_path="C:/Gabriel/Projetos/SGBR/1_Hotel_Ecommerce/api"
>>>>>>> d0b9d1aa235572fbf8b07bae0134894007f42c80
	
	cd $frontend_path
	start bash -c "quasar dev"

	cd $api_path

<<<<<<< HEAD
	start bash -c "php artisan serve --host=192.168.98.32"
=======
	start bash -c "php artisan serve --host=192.168.98.18"
>>>>>>> d0b9d1aa235572fbf8b07bae0134894007f42c80

	bash -c "sh artisan_util.sh"

}

main
