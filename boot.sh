main() {
    frontend_path_1="D:/Gabriel/Projetos/G2L_DevHouse/Ecommerce/G2L_Front"
    api_path_1="D:/Gabriel/Projetos/G2L_DevHouse/Ecommerce/G2L_BackEnd"

    frontend_path_2="D:/Gabriel/Projetos/G2L_DevHouse/Core/G2L_Access_FrontEnd"
    api_path_2="D:/Gabriel/Projetos/G2L_DevHouse/Core/G2L_Access_BackEnd"

    whatsService="D:/Gabriel/Projetos/G2L_DevHouse/Core/Services/WhatsAppGo/cmd"

    # Tenta no C:
    # Ecommerce
    if [ ! -d "$frontend_path_1" ]; then
        frontend_path_1="C:/Gabriel/Projetos/G2L_DevHouse/Ecommerce/G2L_Front"
    fi

    if [ ! -d "$api_path_1" ]; then
        api_path_1="C:/Gabriel/Projetos/G2L_DevHouse/Ecommerce/G2L_BackEnd"
    fi
    #-----------------------------------------------------------------
    # Core
    if [ ! -d "$frontend_path_2" ]; then
        frontend_path_2="C:/Gabriel/Projetos/G2L_DevHouse/Core/G2L_Access_FrontEnd"
    fi

    if [ ! -d "$api_path_2" ]; then
        api_path_2="C:/Gabriel/Projetos/G2L_DevHouse/Core/G2L_Access_BackEnd"
    fi
    #-----------------------------------------------------------------
    # Core/Whats
    if [ ! -d "$whatsService" ]; then
        whatsService="C:/Gabriel/Projetos/G2L_DevHouse/Core/Services/WhatsAppGo/cmd"

    fi 

    cd "$frontend_path_1" || { echo "Erro ao acessar $frontend_path_1"; exit 1; }
    start bash -c "quasar dev"

    cd "$api_path_1" || { echo "Erro ao acessar $api_path_1"; exit 1; }
    start bash -c "php artisan serve --host=192.168.98.18"

    cd "$frontend_path_2" || { echo "Erro ao acessar $frontend_path_2"; exit 1; }
    start bash -c "quasar dev -p 9090"

    cd "$api_path_2" || { echo "Erro ao acessar $api_path_2"; exit 1; }
    start bash -c "php artisan serve --host=192.168.98.18 --port=8080"

    cd "$whatsService" || { echo "Erro ao acessar $whatsService"; exit 1; }
    start bash -c "go run main.go"
}

main