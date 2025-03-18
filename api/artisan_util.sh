main()
{
    clear
    echo "1 - Migrate: php artisan migrate:fre"
    echo "2 - Seeder: php artisan db:see"
    echo "3 - Artisan: php artisan ..."
    echo "4 - Model and table: php artisan make:model 'name' -m"
    echo "5 - Apagar as logs"
    echo "0 - Sair"
    read option

    case $option in
        1)
            clear
            echo "Recriando banco de dados..."
            bash -c "php artisan migrate:fre"
            main
        ;;

        2)
            clear
            echo "Preenchendo o banco de dados..."
            bash -c "php artisan db:see"
            main

        ;;

        3)
            clear
            echo "Digite seu comando: "
            read command
            echo "Rodando: php artisan $command"
            bash -c "php artisan $command"
            sleep 1
            main
            ;;

        4)
            clear
            echo "Digite o nome do model: "
            read name
            bash -c "php artisan make:model $name -m"

            sleep 1
            main
            ;;

        5)
            clear
            cd "D:/SGBR/Projeto_3_Hotel_Ecommerce/api/storage/logs" || { "Caminho não encontrado! "; exit 1;}
            echo "Apagando logs..."
            sleep 1
            rm "laravel.log"
            main
            ;;

        0)
            clear
            echo "Saindo..."
            exit 1
            ;;

        *)
            clear
            echo "Opção inválida."
            sleep 0.5
            main
            ;;
        
    esac
}

main