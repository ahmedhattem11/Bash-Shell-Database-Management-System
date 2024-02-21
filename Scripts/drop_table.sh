#!/bin/bash

clear
function validateParamName {
    local name="$1"
    
    if [ -z "$name" ]; then
        echo "Error: You have entered an empty field. Input is required."
        return 1
    elif [[ "$name" =~ ^[0-9] ]]; then
        echo "Error: Name must not begin with a number."
        return 1
    elif [[ "$name" =~ [^a-zA-Z0-9_] ]]; then
        echo "Error: Name must not have special characters."
        return 1
    elif [[ "$name" = *" "* ]]; then
        echo "Error: Name must not have spaces."
        return 1
    fi
    
    return 0
}

function showMainMenu {
    echo "1- Drop a table"
    echo "M- Main Menu"
    echo "E- Exit"
}

function listTables {
    local tables=($(find . -maxdepth 1 -type f ! -name '*.sh' ! -name '*-meta*' -printf '%f\n'))
    local num_tables=${#tables[@]}
    if [ "$num_tables" -eq 0 ]; then
        echo "No tables found in the directory."
        return 1
    fi

    echo "Available Tables:"
    for ((i=0; i<num_tables; i++)); do
        echo "$((i+1)). ${tables[i]}"
    done
}

function dropTable {
    while true; do
        listTables
        read -p "Enter the number of the table you want to drop (or 'M' for Main Menu, 'E' to Exit): " tableNum
        case "${tableNum^^}" in
            M)
                cd ../..
                pwd
                ./Scripts/DatabaseMenu.sh
                return ;;
            E)
                echo "Exiting..."
                exit 0 ;;
            *)
                if [[ ! $tableNum =~ ^[0-9]+$ ]]; then
                    echo "Error: Please enter a valid number or 'M' for Main Menu, 'E' to Exit."
                    continue
                fi
                
                local tableName
                tableName=$(find . -maxdepth 1 -type f ! -name '*-meta*' ! -name '*.sh' -printf '%f\n' | sed -n "${tableNum}p")

                if [ -z "$tableName" ]; then
                    echo "Error: Table not found."
                    continue
                fi

                if [ ! -f "${tableName}-meta" ]; then
                    echo "Error: Metadata file for table $tableName not found."
                    continue
                fi

                # Perform the actual deletion
                rm -rf "$tableName"
                rm -rf "${tableName}-meta"

                echo "Table '$tableName' dropped successfully."
                sleep 2
                . ../../Scripts/DatabaseMenu.sh
                break ;;
        esac
    done
}

function dropTableInteractive {
    showMainMenu

    while true; do
        read -p "Enter your choice: " choice
        clear
        if [ "$choice" == "1" ]; then
            echo "Listing available tables:"
            dropTable
        elif [[ "${choice^^}" == "M" ]]; then
            # Launch DatabaseMenu.sh
            
            . ../../Scripts/DatabaseMenu.sh
            return
        elif [[ "${choice^^}" == "E" ]]; then
            echo "Exiting..."
            exit 0
        else
            echo "Invalid choice. Please enter '1' to drop a table, 'M' to return to Main Menu, 'E' to exit."
        fi
    done
}

dropTableInteractive
