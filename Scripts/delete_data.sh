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

function deleteRecord {
    local tableName pk
    
    # Check if there are tables available
    local tables=($(find . -maxdepth 1 -type f ! -name '*-meta*' ! -name '*-sh*' ! -name '*.sh' -printf '%f\n'))
    if [ ${#tables[@]} -eq 0 ]; then
        echo "No tables to remove. The database is empty."
        return
    fi
    
    # List all tables with numbers
    echo "Tables available for deletion:"
    local i=1
    local tableNumbers=()
    for table in "${tables[@]}"
    do
        echo "$i. ${table}"
        tableNumbers+=("$table")
        ((i++))
    done
    
    # Choose table by number
    local choice
    while true; do
        read -p "Enter the number of the table you want to delete from: " choice
        if [[ ! $choice =~ ^[0-9]+$ ]]; then
            echo "Error: Please enter a valid number."
        elif [ $choice -lt 1 ] || [ $choice -gt ${#tableNumbers[@]} ]; then
            echo "Error: Invalid choice. Please select a number from the list."
        else
            tableName="${tableNumbers[$((choice-1))]}"
            break
        fi
    done

    # Check if the provided table name corresponds to an existing file
    if [ ! -f "$tableName" ]; then
        echo "Table $tableName does not exist."
        return
    fi

    # List primary keys (PKs) of the selected table
    echo "Primary Keys (PKs) available for table $tableName:"
    awk -F: '{print $1}' "$tableName"

    # Choose PK to delete
    read -p "Enter the primary key (PK) of the record you want to delete: " pk
    if ! grep -q "^${pk}:" "$tableName"; then
        echo "The record with PK = ${pk} doesn't exist."
        return
    fi

    # Delete the record
    sed -i "/^${pk}:/d" "$tableName"
    echo "The record with PK = ${pk} has been successfully deleted from table $tableName."
    sleep 2
    . ../../Scripts/DatabaseMenu.sh
}

deleteRecord
