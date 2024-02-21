#!/bin/bash

clear
echo "Select a table: "
echo "----------------"

# Store the current directory path
current_directory=$(pwd)

# Store the list of tables in the current directory in an array
tables=(*)
tables=($(for table in "${tables[@]}"; do echo $table; done | grep -v -- "-meta"))
tables=("${tables[@]}" "Back")

# Prompt the user to select a table
PS3="Select a table: "
select table in "${tables[@]}"; do
    # Check if the selected option is "Back"
    if [[ $table == "Back" ]]; then
        . ../../Scripts/DatabaseMenu.sh
        exit 0
    fi

    # Check if the selected option is a valid table
    if [[ ! -f "$table" ]]; then
        echo "Invalid option. Please select a valid table."
        continue
    fi

    # Prompt the user to confirm the reading
    read -p "Do you want to select $table? (y/n): " confirm
    case $confirm in
        [yY]*)
            # Display the contents of the file
            clear
            cat "$table"
            echo -e "\n"
            ;;
        *)
            echo "Reading canceled."
            ;;
    esac
    break
done

# Prompt the user if they want to go back
read -p "Do you want to go back? (y/n): " back_option
case $back_option in
    [yY]*)
        . ../../Scripts/DatabaseMenu.sh
        exit 0
        ;;
    *)
        echo "Exiting the script."
        exit 0
        ;;
esac
