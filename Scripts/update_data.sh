#!/bin/bash

shopt -s extglob

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
    echo "1- Update a table"
    echo "M- Main Menu"
    echo "E- Exit"
}

function listTables {
    clear
    local tables=($(find . -maxdepth 1 -type f ! -name '*-meta*' ! -name '*.sh' -printf '%f\n'))
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

function updateTable {
    local tableName pk colName oldValue newValue colnum

    listTables

    # Choose table by number
    while true; do
        read -p "Enter the number of the table you want to update (or 'M/m' for Main Menu, 'E/e' to Exit): " tableNum
        case "${tableNum^^}" in
            +([Mm]))
                . ../../Scripts/DatabaseMenu.sh
                return ;;
            +([Ee]))
                echo "Exiting..."
                exit 0 ;;
            *)
                if [[ ! $tableNum =~ ^[0-9]+$ ]]; then
                    echo "Error: Please enter a valid number or 'M/m' for Main Menu, 'E/e' to Exit"
                    continue
                fi
                break ;;
        esac
    done

    tableName=$(find . -maxdepth 1 -type f ! -name '*-meta*' ! -name '*.sh' -printf '%f\n' | sed -n "${tableNum}p")

    if [ ! -f "${tableName}-meta" ]; then
        echo "Error: Metadata file for table $tableName not found."
        return 1
    fi

    read -p "Enter Primary Key (PK): " pk

while ! grep -q "^${pk}:" "${tableName}"; do
    echo "Error: The PK doesn't exist."
    read -p "Enter Primary Key (PK): " pk
done

    clear
    echo "Available columns for updating:"
    awk -F: '{print NR". "$1}' "${tableName}-meta"

    while true; do
        read -p "Enter the number of the column you want to update (or 'M/m' for Main Menu, 'E/e' to Exit): " colNum
        case "${colNum^^}" in
            +([Mm]))
                . ../../Scripts/DatabaseMenu.sh
                return ;;
            +([Ee]))
                echo "Exiting..."
                exit 0 ;;
            *)
                if [[ ! $colNum =~ ^[0-9]+$ ]]; then
                    echo "Error: Please enter a valid number or 'M/m' for Main Menu, 'E/e' to Exit."
                    continue
                fi
                break ;;
        esac
    done

    if [ $colNum -lt 1 ] || [ $colNum -gt $(($(wc -l < "${tableName}-meta") + 1)) ]; then
     echo "Error: Invalid choice. Please select a number from the list."
     return 1
       fi


    colName=$(awk -F: -v num="$colNum" 'NR==num {print $1}' "${tableName}-meta")
    oldValue=$(grep "^${pk}:" "${tableName}" | cut -d ':' -f $colNum)

    read -p "Enter the new value for $colName: " newValue

    # Update the corresponding column in the table file
    awk -v pk="$pk" -v newVal="$newValue" -v colNum="$colNum" 'BEGIN {FS=":"; OFS=":"} {if ($1 == pk) {$colNum=newVal} print}' "${tableName}" > "${tableName}.tmp"
    mv "${tableName}.tmp" "${tableName}"
	echo "Column '$colName' updated successfully."
    sleep 2
    clear
    . ../../Scripts/DatabaseMenu.sh
}

# Call the function
showMainMenu
read -p "Enter your choice: " choice

case "${choice^^}" in
    1)
        updateTable ;;
    +([Mm]))
        . ../../Scripts/DatabaseMenu.sh ;;
    +([Ee]))
        echo "Exiting..."
        cd ../..
        ./main.sh 
        pwd;;
    *)
        echo "Invalid choice. Please enter a valid option."
        ;;
esac
