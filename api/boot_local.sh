main()
{
	#frontend_path="C:/Gabriel/Projetos/SGBR/1_Hotel_Ecommerce/quasar"	
	#api_path="C:/Gabriel/Projetos/SGBR/1_Hotel_Ecommerce/api" 
	frontend_path="D:/Gabriel/Projetos/SGBR/1_Hotel_Ecommerce/quasar"
	api_path="D:/Gabriel/Projetos/SGBR/1_Hotel_Ecommerce/api" 

	cd $frontend_path
	start bash -c "quasar dev"
	cd $api_path
<<<<<<< HEAD
	start bash -c "php artisan serve --host=192.168.1.103"
=======
	start bash -c "php artisan serve --host=192.168.48.204"
>>>>>>> 7379b8a8295023b2ae5f593467c261a05f769442
	bash -c "sh artisan_util.sh"

}

main