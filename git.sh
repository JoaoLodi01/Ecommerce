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
    echo "Qual branch"
    echo "1 - Main"
    echo "2 - Dev"
    echo "3 - Kochem"
    echo "4 - Lodi"
    read branch
    branch -c "git push -u $branch"
    main
}

main()
{   
    echo "1 - git push completo"
    echo "2 - git merge"
    echo "0 - Sair"
    read option

    case $option in
        1)
            fun_git_add
            ;;

        0)
            exit 1
            ;;

    esac
}

main