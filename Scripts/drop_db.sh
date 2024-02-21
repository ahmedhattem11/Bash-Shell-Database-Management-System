#!/bin/bash

clear
echo "Delete Database: "
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

    # Check if the selected option is a valid directory
    if [[ ! -d "HNDBMS/$directory" ]]; then
        echo "Invalid option. Please select a valid directory."
        continue
    fi

    # Prompt the user to confirm the deletion
    read -p "Do you want to delete $directory? (y/n): " confirm
    case $confirm in
        [yY]*)
            # Delete the selected directory
            rm -r "HNDBMS/$directory"
            # Print deletion message after deletion
            echo "$directory database is deleted successfully!"
            sleep 2  # Pause for 2 seconds
            ;;
        *)
            echo "Deletion canceled."
            ;;
    esac
    break
done

# Call the drop_db.sh script
./Scripts/drop_db.sh
