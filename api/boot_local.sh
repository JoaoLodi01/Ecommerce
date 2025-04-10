main()
{
	#frontend_path="C:/Gabriel/Projetos/SGBR/1_Hotel_Ecommerce/quasar"	
	#api_path="C:/Gabriel/Projetos/SGBR/1_Hotel_Ecommerce/api" 
	frontend_path="D:/Gabriel/Projetos/SGBR/1_Hotel_Ecommerce/quasar"
	api_path="D:/Gabriel/Projetos/SGBR/1_Hotel_Ecommerce/api" 

	cd $frontend_path
	start bash -c "quasar dev"

	cd $api_path

	#start bash -c "php artisan serve --host=192.168.1.100"
<<<<<<< HEAD
<<<<<<< HEAD
	start bash -c "php artisan serve --host=192.168.1.103"
	#start bash -c "php artisan serve --host=192.168.98.18"
=======
	#start bash -c "php artisan serve --host=192.168.1.103"
	start bash -c "php artisan serve --host=192.168.98.18"
>>>>>>> d9cb33f6d7f47ba6745020407e2be0730cecd7ea
=======
	start bash -c "php artisan serve --host=192.168.1.103"
	#start bash -c "php artisan serve --host=192.168.98.18"
>>>>>>> 8f45fde0b7ad3d49172618c1aecdd624a8847789
	#start bash -c "php artisan serve --host=192.168.48.204"

	bash -c "sh artisan_util.sh"

}

main