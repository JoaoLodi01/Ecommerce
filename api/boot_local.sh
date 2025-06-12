main() {
    frontend_path="C:/Gabriel/Projetos/SGBR/1_Hotel_Ecommerce/quasar"
    api_path="C:/Gabriel/Projetos/SGBR/1_Hotel_Ecommerce/api"

    # Tenta no C:
    if [ ! -d "$frontend_path" ]; then
        frontend_path="D:/Gabriel/Projetos/SGBR/1_Hotel_Ecommerce/quasar"
    fi

<<<<<<< HEAD
    if [ ! -d "$api_path" ]; then
        api_path="D:/Gabriel/Projetos/SGBR/1_Hotel_Ecommerce/api"
    fi
=======
	start bash -c "php artisan serve --host=192.168.98.18"
>>>>>>> ae52f3c8638b5633cc334edc7b542844072697e4

    cd "$frontend_path" || { echo "Erro ao acessar $frontend_path"; exit 1; }
    start bash -c "quasar dev"

    cd "$api_path" || { echo "Erro ao acessar $api_path"; exit 1; }
    start bash -c "php artisan serve --host=192.168.1.11"
}

main
