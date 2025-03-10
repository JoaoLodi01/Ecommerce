/*#!/bin/bash

echo "Selecione o ambiente"
echo "1 - Casa"
echo "2 - Empresa"

read ambiente

case $ambiente in
	1)
		frontPath="D:\SGBR\Projeto_3_Hotel_Ecommerce\front"
		backPath="D:\SGBR\Projeto_3_Hotel_Ecommerce\api"

		cd $frontPath
		start bash -c "npm run s"

		cd $backPath 
		start bash -c "php artisan serve --host=192.168.1.104"
		;;
	2)
		frontPath="C:\Gabriel\Codes\Projeto_3_Hotel_Ecommerce\front"
		backPath="C:\Gabriel\Codes\Projeto_3_Hotel_Ecommerce\api"
		cd $frontPath
		start bash -c "npm run s"

		cd $backPath 
		start bash -c "php artisan serve --host=192.168.98.51"
		;;

esac
