main() {
    frontend_path="C:\Users\GUSTTA\Desktop\Apps\Ecommerce\quasar"
    api_path="C:\Users\GUSTTA\Desktop\Apps\Ecommerce\api"

    # Tenta no C:
    if [ ! -d "$frontend_path" ]; then
        frontend_path="C:\Users\GUSTTA\Desktop\Apps\Ecommerce\quasar"
    fi

    if [ ! -d "$api_path" ]; then
        api_path="C:\Users\GUSTTA\Desktop\Apps\Ecommerce\api"
    fi

    cd "$frontend_path" || { echo "Erro ao acessar $frontend_path"; exit 1; }
    start bash -c "quasar dev"

    cd "$api_path" || { echo "Erro ao acessar $api_path"; exit 1; }
<<<<<<< HEAD
    start bash -c "php artisan serve --host=192.168.1.101"
=======
 
    start bash -c "php artisan serve --host=192.168.0.9"
>>>>>>> d259d50a2423962291df923a68e5dd4b6b12a002
    
    
    }

main
