main()
{
    clear
    echo "1 - Migrate: php artisan migrate:fre"
    echo "2 - Seeder: php artisan db:see"
    echo "3 - Artisan: php artisan ..."
    echo "4 - Model and table: php artisan make:model 'name' -m"
<<<<<<< HEAD
    echo "5 - Route:cache: php artisan route:ca"
    echo "6 - Apagar as logs"
=======
    echo "5 - Remove route cache: php artisan route:ca"
    echo "6 - List all routes: php artisan route:li"
    echo "7 - Apagar as logs"
>>>>>>> 87b8b3b4fd60cb63d3473b26009ba719dab1948e
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
<<<<<<< HEAD
            echo "Digite seu comando: "
=======
            echo "Digite seu comando: php artisan ..."
>>>>>>> 87b8b3b4fd60cb63d3473b26009ba719dab1948e
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
            echo "Apagando o cache das rotas..."
            bash -c "php artisan route:ca"
            sleep 1
            main
            ;;

<<<<<<< HEAD

        6)
            clear
=======
        6)
            clear
            echo "Carregando rotas..."
            php artisan route:li
            echo "Voltar ..."
            read
            main
            ;;
        7)
            clear
>>>>>>> 87b8b3b4fd60cb63d3473b26009ba719dab1948e
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