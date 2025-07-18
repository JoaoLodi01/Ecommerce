main() {
    frontend_path="D:/Code/G2L_DevHouse/quasar"
    api_path="D:/Code/G2L_DevHouse/api"

    # Tenta no C:
    if [ ! -d "$frontend_path" ]; then
        frontend_path="D:/Code/G2L_DevHouse/quasar"
    fi

    if [ ! -d "$api_path" ]; then
        api_path="D:/Code/G2L_DevHouse/api"
    fi

    cd "$frontend_path" || { echo "Erro ao acessar $frontend_path"; exit 1; }
    start bash -c "quasar dev"

    cd "$api_path" || { echo "Erro ao acessar $api_path"; exit 1; }
    start bash -c "php artisan serve --host=192.168.1.100"
}

main