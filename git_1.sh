/#!/bin/bash
/#!/usr/bin/env bash

fun_loanding() 
{ 
    echo "Carregando ... "
    sleep 0.5 
}

fun_git_commit()
{
    echo "Digite seu commit: "
    read commit 
    git commit -m "$commit"
    git push -u
}

fun_git_push_actual()
{
    echo "git add . na branch: $1"
    fun_git_add
}

fun_git_add()
{
    git add .
    fun_git_commit

}

main()
{   
    actualBranch=$(bash -c "git rev-parse --abbrev-ref HEAD")
    clear
    echo "Branch atual: $actualBranch"
    echo "1 - git push ( branch: $actualBranch )"
    echo "2 - git merge"
    echo "0 - Sair"
    read option

    case $option in
        1)
            clear
            fun_loanding
            fun_git_push_actual $actualBranch
            ;;

        2)
            clear
            fun_loanding
                     
            ;;
        0)
            echo "Saindo ... "
            sleep 0.5
            exit 1
            ;;

    esac
}

main