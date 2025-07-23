main() {
    frontend_path="C:/Gabriel/Projetos/SGBR/1_G2L_DevHouse/G2L_Front"
    api_path="C:/Gabriel/Projetos/SGBR/1_G2L_DevHouse/G2L_BackEnd"

    # Tenta no C:
    if [ ! -d "$frontend_path" ]; then
        frontend_path="D:/Gabriel/Projetos/SGBR/1_G2L_DevHouse/G2L_Front"
    fi

    if [ ! -d "$api_path" ]; then
        api_path="D:/Gabriel/Projetos/SGBR/1_G2L_DevHouse/G2L_BackEnd"
    fi

    cd "$frontend_path" || { echo "Erro ao acessar $frontend_path"; exit 1; }
    start bash -c "quasar dev"

    cd "$api_path" || { echo "Erro ao acessar $api_path"; exit 1; }
    start bash -c "php artisan serve --host=192.168.1.106"
}

main