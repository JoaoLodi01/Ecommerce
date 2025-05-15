main()
{
	frontend_path="c:/Code/ProjetoWeb/quasar"
	api_path="c:/Code/ProjetoWeb/api"
	
	cd $frontend_path
	start bash -c "quasar dev"

	cd $api_path

<<<<<<< HEAD
	start bash -c "php artisan serve --host=192.168.98.32"
=======
	start bash -c "php artisan serve --host=192.168.98.18"
>>>>>>> e82d49a9ee8eb88290ac499f2aa3ac1393af1d84

	bash -c "sh artisan_util.sh"

}

main
