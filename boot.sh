main() {
    frontend_path="C:/Ferramentas/Luiz/Ecommerce/quasar"
    api_path="C:/Ferramentas/Luiz/Ecommerce/api"

    # Tenta no C:
    if [ ! -d "$frontend_path" ]; then
        frontend_path="C:/Ferramentas/Luiz/Ecommerce/quasar"
    fi

    if [ ! -d "$api_path" ]; then
        api_path="C:/Ferramentas/Luiz/Ecommerce/api"
    fi

    cd "$frontend_path" || { echo "Erro ao acessar $frontend_path"; exit 1; }
    start bash -c "quasar dev"

    cd "$api_path" || { echo "Erro ao acessar $api_path"; exit 1; }
    start bash -c "php artisan serve --host=192.168.1.103"
}

main
