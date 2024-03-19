#!/bin/bash

clear
function valdatatype {
    local value="$1"
    local datatype="$2"
    local regex

    if [ -z "$value" ]; then
        echo "Value can't be empty."
        return 1
    fi

    case "$datatype" in
        int)
            regex='^[0-9]+$'
            ;;
        string)
            regex='^[a-zA-Z0-9_ ]+$'
            ;;
        *)
            echo "Invalid data type specified."
            return 1
            ;;
    esac

    if ! [[ "$value" =~ $regex ]]; then
        echo "The value does not match the expected data type $datatype."
        return 1
    fi

    return 0
}

function inserttable {
    clear
    local tablename="${tables[table_num-1]}"
    local metadata_file="${tablename}-meta"

    # Check if metadata file exists, if not, display an error message
    if [ ! -f "$metadata_file" ]; then
        echo "Error: Metadata file for table $tablename does not exist."
        return 1
    fi
    
    # Insert values into the table file
    local col_names=()
    local col_types=()
    while IFS=: read -r col_name col_type; do
        col_names+=("$col_name")
        col_types+=("$col_type")
    done < "$metadata_file"

    local num_cols=${#col_names[@]}

    echo "Enter values for the columns to make the tablefile:"

    local values=()
    local existing_values=()  # To store existing values in the first column
    if [ -f "$tablename" ]; then
        # Read existing values from the first column if table file exists
        while IFS=: read -r first_col _; do
            existing_values+=("$first_col")
        done < "$tablename"
    fi

    for ((i=0; i<num_cols; i++)); do
        while true; do
            read -p "Enter value for column ${col_names[i]} (${col_types[i]}): " value
            if [ "$i" -eq 0 ]; then
                # Check for duplicates only for the first column
                if [[ " ${existing_values[@]} " =~ " $value " ]]; then
                    echo "Duplicate value found for column ${col_names[i]}. Please enter a different value."
                    continue
                fi
            fi
            if valdatatype "$value" "${col_types[i]}"; then
                values+=("$value")
                break
            fi
        done
    done

    # Insert values into the existing table file
    local table_file="${tablename}"
    local formatted_values=$(IFS=:; echo "${values[*]}")
    echo "$formatted_values" >> "$table_file" || { echo "Error: Could not write to table file."; exit 1; }

    echo "Values inserted into table $tablename successfully"
    sleep 2
    clear
}


function main() {
    local tables=($(find . -maxdepth 1 -type f ! -name '*-meta' ! -name '*.sh' -printf '%f\n'))
    local num_tables=${#tables[@]}
    if [ "$num_tables" -eq 0 ]; then
        echo "No tables found in the directory."
        return 1
    fi

    while true; do
        echo "1. Insert into table"
        echo "2. Back"
        read -p "Enter your choice: " choice
        case $choice in
            1)
                clear
                echo "Available Tables:"
                for ((i=0; i<num_tables; i++)); do
                    echo "$((i+1)). ${tables[i]}"
                done
                read -p "Enter the number of the table you want to insert into: " table_num
                clear
                if ! [[ "$table_num" =~ ^[0-9]+$ ]] || [ "$table_num" -lt 1 ] || [ "$table_num" -gt "$num_tables" ]; then
                    echo "Invalid table number. Please select a number within the range."
                    continue
                fi
                inserttable
                ;;
            2)
                echo "Returning back..."
                sleep 2
                . ../../Scripts/DatabaseMenu.sh
                ;;
            *)
                echo "Invalid choice. Please enter a valid option."
                ;;
        esac
    done
}

main  # Call the main function to start the script
