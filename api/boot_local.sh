main()
{
	frontend_path="C:/Code/ProjetoWeb/quasar"
	api_path="C:/Code/ProjetoWeb/api"
	
	cd $frontend_path
	start bash -c "quasar dev"

	cd $api_path

<<<<<<< HEAD
	start bash -c "php artisan serve --host=192.168.199.217"
=======
	start bash -c "php artisan serve --host=192.168.98.32"
>>>>>>> 72a099b8ce6464e23f4b0e3d5c023b08bd8c7ffe

	bash -c "sh artisan_util.sh"

}

main
