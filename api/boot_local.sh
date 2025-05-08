main()
{
	frontend_path="C:/Gabriel/Projetos/SGBR/1_Hotel_Ecommerce/quasar"
	api_path="C:/Gabriel/Projetos/SGBR/1_Hotel_Ecommerce/api"
	
	cd $frontend_path
	start bash -c "quasar dev"

	cd $api_path

<<<<<<< HEAD
	start bash -c "php artisan serve --host=192.168.199.127"
=======
	start bash -c "php artisan serve --host=192.168.98.18"
>>>>>>> 61c2dc3221dc9713ad0ee6a60e9e27b719e2f9c0

	bash -c "sh artisan_util.sh"

}

main
