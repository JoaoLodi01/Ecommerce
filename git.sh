#!/bin/bash

fun_git_add()
{
    bash -c "git add ."
    fun_git_commit

}

fun_git_commit()
{
    echo "Digite seu commit: "
    read commit
    bash -c "git commit -m '$commit'" 
    fun_git_push
}

fun_git_push()
{
    echo "Qual branch: "
    echo "1 - Main"
    echo "2 - Dev"
    echo "3 - Kochem"
    echo "4 - Lodi"
    read branch
    case $branch in
        1)
            echo "Carregando ... "
            bash -c "git push -u Main"
            ;;
        2)
            echo "Carregando ... "
            bash -c "git push -u Dev"
            ;;

        3)
            echo "Carregando ... "
            bash -c "git push -u Kochem"
            ;;
        4)
            echo "Carregando ... "
            bash -c "git push -u Lodi"
            ;;
    esac
    echo "Finalizado!"
    
    main
}

fun_git_checkout()
{
    echo "Executando git add . ..."
    bash -c "git add ."

    echo "Digite seu commit: "
    read commit
    bash -c "git commit -m '$commit'" 

    echo "Digite a sua branch: "
    read myBranch

    echo "Branch para checkout: "
    echo "1 - Main"
    echo "2 - Dev"
    echo "3 - Kochem"
    echo "4 - Lodi"
    read branch

    branchName=""
    case $branch in
        1)
            echo "Carregando ... "
            bash -c "git checkout Main"
            branchName="Main"
            ;;
        2)
            echo "Carregando ... "
            bash -c "git checkout Dev"
            branchName="Dev"
            ;;

        3)
            echo "Carregando ... "
            bash -c "git checkout Kochem"
            branchName="Kochem"
            ;;
        4)
            echo "Carregando ... "
            bash -c "git checkout Lodi"
            branchName="Lodi"
            ;;
    esac
    fun_git_merge $branchName
}

fun_git_merge()
{
    echo "git push -u $1"
    bash -c "git merge $1"
    sleep 0.5

    echo "Merge feito!"
    echo "1 - Deseja efetuar o git push?"
    echo "0 - Sair"
    read push

    case $push in
        1) 
            bash -c "git push -u $1"
            ;;

        0)  
            echo "Saindo ..."
            sleep 0.5
            exit 1
            ;;
    esac


}

main()
{   
    clear
    echo "1 - git push completo"
    echo "2 - git merge"
    echo "0 - Sair"
    read option

    case $option in
        1)
            clear
            fun_git_add
            ;;

        2)
            clear
            fun_git_checkout
            ;;
        0)
            exit 1
            ;;

    esac
}

main