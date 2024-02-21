#!/bin/bash

clear
echo "Welcome to our H.N.D.B.M.S..."
echo "-----------------------------"
while true
do
    # Prompt the user to select a directory
    PS3="Enter a number from above: "
    select option in "Create Database" "Connect DataBase" "Drop DataBase" "List DataBase" "Exit"
    do
        case $option in
        "Create Database")
            ./Scripts/create_db.sh
            ;;
        "Connect DataBase")
            ./Scripts/connect_db.sh
            ;;
        "Drop DataBase")
            ./Scripts/drop_db.sh
            ;;
        "List DataBase")
            ./Scripts/list_db.sh
            ;;
        "Exit")
            break
            ;;
        "")
            echo "You did not enter an option. Please select an option from the menu."
            ;;
        *)
            echo "Invalid option. Please select an option from the menu."
            ;;
        esac
        break
    done
    break
done
