main()
{
	frontend_path="C:\Code\ProjetoWeb\quasar"
	api_path="C:\Code\ProjetoWeb\api"

	cd $frontend_path
	start bash -c "quasar dev"

	cd $api_path

	start bash -c "php artisan serve --host=192.168.98.32"

	bash -c "sh artisan_util.sh"

}

main
