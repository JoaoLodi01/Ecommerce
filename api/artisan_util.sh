main()
{
    clear
    echo "1 - Migrate: php artisan migrate:fre"
    echo "2 - Seeder: php artisan db:see"
    echo "3 - Artisan: php artisan ..."
    echo "4 - Model and table: php artisan make:model 'name' -m"
    echo "5 - Route:cache: php artisan route:ca"
    echo "6 - Route:list: php artisan route:li"
    echo "7 - Apagar as logs"
    echo "8 - Migrate (table): php artisan migrate"
    echo "9 - Subir servidores novamente"
    echo "R - Reiniciar"
    echo "E - Sair"
    read -p "Selecione uma opção: " option

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
            echo "Apagando o cache das rotas..."
            bash -c "php artisan route:ca"
            sleep 1
            main
            ;;

        6)
            clear
            echo "Listando rotas ..."
            bash -c "php artisan route:li"
            read a
            main
            ;;

        7)
            clear
            echo "1 - C:/Gabriel/Projetos/SGBR/1_Hotel_Ecommerce/api/storage/logs"
            echo "2 - D:/Gabriel/Projetos/SGBR/1_Hotel_Ecommerce/api/storage/logs"
            read local
            case $local in
                1 ) 
                    cd "C:/Gabriel/Projetos/SGBR/1_Hotel_Ecommerce/api/storage/logs" || { "Caminho não encontrado! ";}
                    ;;

                2 ) 
                    cd "D:/Gabriel/Projetos/SGBR/1_Hotel_Ecommerce/api/storage/logs" || { "Caminho não encontrado! ";}
                    ;;
                *)
                    echo "Opção inválida!"
                    main
                    ;;
            esac

            echo "Apagando logs..."
            sleep 1
            rm "laravel.log"
            main
            ;;

        8)
            clear
            echo "Carregando banco de dados..."
            bash -c "php artisan migrate"
            main
            ;;

        9)
            bash -c "sh boot_local.sh"
            ;;

        'R' | 'r')
            echo "Reiniciando..."
            sleep 1
            exec bash "$0"
            
            ;; 

        'E' | 'e')
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