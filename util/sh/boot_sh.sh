#!/bin/bash

main() {
    # Exibe o(s) IP(s) da(s) interface(s)
    ipconfig | grep "Endereço IPv4" | awk -F: '{print $2}' | tr -d ' '
}

main
