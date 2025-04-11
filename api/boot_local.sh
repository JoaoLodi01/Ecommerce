main()
{
	frontend_path="C:/Gabriel/Projetos/SGBR/1_Hotel_Ecommerce/quasar"
	api_path="C:/Gabriel/Projetos/SGBR/1_Hotel_Ecommerce/api"

	cd $frontend_path
	start bash -c "quasar dev"

	cd $api_path

	start bash -c "php artisan serve --host=192.168.1.103"

	bash -c "sh artisan_util.sh"

}

main
