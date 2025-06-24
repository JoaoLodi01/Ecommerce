main()
{
	frontend_path="c:/Code/ProjetoWeb/quasar"
	api_path="c:/Code/ProjetoWeb/api"
	
	cd $frontend_path
	start bash -c "quasar dev"

    cd $api_path

	start bash -c "php artisan serve --host=192.168.98.32"
}

main
