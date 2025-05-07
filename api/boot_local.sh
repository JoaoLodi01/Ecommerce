main()
{
	frontend_path="D:/ProjetoWeb/quasar"
	api_path="D:/ProjetoWeb/api"
	
	cd $frontend_path
	start bash -c "quasar dev"

	cd $api_path

	start bash -c "php artisan serve --host=192.168.1.106"

	bash -c "sh artisan_util.sh"

}

main
