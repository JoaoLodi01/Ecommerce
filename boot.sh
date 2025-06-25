main() {
    frontend_path="C:/Code/ProjetoWeb/quasar"
    api_path="C:/Code/ProjetoWeb/api"

    # Tenta no C:
    if [ ! -d "$frontend_path" ]; then
        frontend_path="C:/Code/ProjetoWeb/quasar"
    fi

    if [ ! -d "$api_path" ]; then
        api_path="C:/Code/ProjetoWeb/api"
    fi

    cd "$frontend_path" || { echo "Erro ao acessar $frontend_path"; exit 1; }
    start bash -c "quasar dev"

    cd "$api_path" || { echo "Erro ao acessar $api_path"; exit 1; }
    start bash -c "php artisan serve --host=192.168.98.32"
}

main
