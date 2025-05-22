main()
{
	frontend_path="c:/Gabriel/Projetos/SGBR/1_Hotel_Ecommerce/quasar"
	api_path="c:/Gabriel/Projetos/SGBR/1_Hotel_Ecommerce/api"
	
	cd $frontend_path
	start bash -c "quasar dev"

	cd $api_path

	start bash -c "php artisan serve --host=192.168.199.243"

	bash -c "sh artisan_util.sh"

}

main
