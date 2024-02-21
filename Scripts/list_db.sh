#!/bin/bash

clear
echo "List of databases:"
echo "------------------"
for dir in $(pwd)/HNDBMS/*; do
    if [ -d "$dir" ]; then
        echo "$(basename $dir)"
    fi
done

while true; do
    select option in "Back to Main Menu"; do
        case $option in
            "Back to Main Menu")
                ./main.sh
                exit 0
                break
                ;;
        esac
    done
done
