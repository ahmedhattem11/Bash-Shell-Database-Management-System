#!/bin/bash

clear
echo "Connect to a database:"
echo "------------------"

# Store the list of directories in an array
directories=($(find HNDBMS/ -maxdepth 1 -type d | sed 's/HNDBMS\///'))
directories=("${directories[@]}" "Back")

# Prompt the user to select a directory
PS3="Select a Database: "
select directory in "${directories[@]}"; do
    # Check if the selected option is "Back"
    if [[ $directory == "Back" ]]; then

        ./main.sh
        exit 0
    fi
    
    # Check if the selected option is a directory within HNDBMS
    if [[ -d "HNDBMS/$directory" ]]; then
        # Change to the selected directory
        cd "HNDBMS/$directory"
        echo "Connecting..."
        sleep 2
        . ../../Scripts/DatabaseMenu.sh
        exit 0
    else
        echo "Invalid option. Please select a valid database."
    fi
done
