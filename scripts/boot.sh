#!/bin/bash

frontPat="D:\SGBR\Projeto_3_Hotel_Ecommerce\front"
backPath="D:\SGBR\Projeto_3_Hotel_Ecommerce\api"

cd $frontPat
start bash -c "npm run s"

cd $backPath 
start bash -c "php artisan serve --host=192.168.1.104"

echo "Servidores iniciados!"