main() {
    frontend_path_1="D:/Gabriel/Projetos/G2L_DevHouse/Ecommerce/G2L_Front"
    api_path_1="D:/Gabriel/Projetos/G2L_DevHouse/Ecommerce/G2L_BackEnd"

    frontend_path_2="D:/Gabriel/Projetos/G2L_DevHouse/Core/G2L_Access_FrontEnd"
    api_path_2="D:/Gabriel/Projetos/G2L_DevHouse/Core/G2L_Access_BackEnd"

    # Tenta no C:
    if [ ! -d "$frontend_path_1" ]; then
        frontend_path_1="C:/Gabriel/Projetos/G2L_DevHouse/Ecommerce/G2L_Front"
    fi

    if [ ! -d "$api_path_1" ]; then
        api_path_1="C:/Gabriel/Projetos/G2L_DevHouse/Ecommerce/G2L_BackEnd"
    fi
    #-----------------------------------------------------------------

    if [ ! -d "$frontend_path_2" ]; then
        frontend_path_2="C:/Gabriel/Projetos/G2L_DevHouse/Core/G2L_Access_FrontEnd"
    fi

    if [ ! -d "$api_path_2" ]; then
        api_path_2="C:/Gabriel/Projetos/G2L_DevHouse/Core/G2L_Access_BackEnd"
    fi
    #-----------------------------------------------------------------
    
    cd "$frontend_path_1" || { echo "Erro ao acessar $frontend_path_1"; exit 1; }
    start bash -c "quasar dev"

    cd "$api_path_1" || { echo "Erro ao acessar $api_path_1"; exit 1; }
    start bash -c "php artisan serve --host=192.168.1.105"

    cd "$frontend_path_2" || { echo "Erro ao acessar $frontend_path_2"; exit 1; }
    start bash -c "quasar dev -p 9090"

    cd "$api_path_2" || { echo "Erro ao acessar $api_path_2"; exit 1; }
    start bash -c "php artisan serve --host=192.168.1.105 --port=8080"
}

main