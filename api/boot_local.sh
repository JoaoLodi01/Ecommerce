main()
{
<<<<<<< HEAD
	frontend_path="C:/Gabriel/Projetos/SGBR/1_Hotel_Ecommerce/quasar"
	api_path="C:/Gabriel/Projetos/SGBR/1_Hotel_Ecommerce/api"
=======
	frontend_path="c:/Code/ProjetoWeb/quasar"
	api_path="c:/Code/ProjetoWeb/api"
>>>>>>> cf65b2bde1cc3383e9353c3752b9c6645d3220c5
	
	cd $frontend_path
	start bash -c "quasar dev"

	cd $api_path

<<<<<<< HEAD
	start bash -c "php artisan serve --host=192.168.98.18"
=======
	start bash -c "php artisan serve --host=192.168.98.32"
>>>>>>> cf65b2bde1cc3383e9353c3752b9c6645d3220c5

	bash -c "sh artisan_util.sh"

}

main
