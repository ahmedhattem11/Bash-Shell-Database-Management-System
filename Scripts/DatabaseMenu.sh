#!/bin/bash

clear

# Extract the current directory name
current_dir=$(basename "$PWD")

# Welcome message
echo "Welcome to $current_dir: "
echo "------------------------"

# Prompt the user to select a directory
PS3="Enter a number from above: "
select action in "Create Table" "Select Table" "Drop Table" "Update Data" "Insert Data" "Delete Data" "Back to Main Menu"
do
    case $action in 
    "Create Table")
        . ../../Scripts/create_table.sh
        ;;
    "Select Table")
        . ../../Scripts/select_table.sh
        ;;
     "Drop Table")
        . ../../Scripts/drop_table.sh
        ;;
     "Update Data")
        . ../../Scripts/update_data.sh
        ;;
     "Insert Data")
        . ../../Scripts/insert_data.sh
        ;;
      "Delete Data")
         . ../../Scripts/delete_data.sh
         ;;
     "Back to Main Menu")
         cd ../..
        ./main.sh
        exit 0
        ;;
    esac
done
